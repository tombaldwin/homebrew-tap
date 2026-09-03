# Homebrew formula for candor — one-command effect analysis across every language.
#
# Install:
#   brew install tombaldwin/tap/candor
#   candor update      # fetch the engines (the flagship JVM engine as a native binary, no JVM)
#   candor doctor      # verify
#
# Bumping for a new release: run `scripts/update-candor.sh vX.Y.Z` from the candor
# umbrella repo — it tags the release, computes the SHA-256 from the GitHub source
# tarball, and writes this formula. The umbrella's own UMBRELLA_VERSION and this
# formula version move together (they pin the engine line `candor update` fetches).
class Candor < Formula
  desc "One-command effect analysis across every language"
  homepage "https://candor.poly.io"
  url "https://github.com/tombaldwin/candor/archive/refs/tags/v0.35.0.tar.gz"
  sha256 "2546988a2f097459ba5e110f4297a2d9e97b1a18b9199cfde9c54d7fef74a09b" # filled at ship by update-candor.sh
  license "MIT OR Apache-2.0"

  depends_on "curl" # candor update fetches the engine binaries

  def install
    bin.install "bin/candor"
    zsh_completion.install "completions/_candor" => "_candor"
    bash_completion.install "completions/candor.bash" => "candor"
    fish_completion.install "completions/candor.fish"
    # the Claude Code edit-time Stop-hook scripts — `candor hook` wires them into a repo
    hooks = %w[stop-hook.sh candor-review.sh candor-review-source.sh lib-candor-summary.sh]
    (pkgshare/"hooks").install hooks.map { |f| "integrations/claude-code/#{f}" }
    # `candor init`'s POLICY PROPOSER. Without this, a brew install silently lost init's headline
    # feature: it fell back to a baseline-only setup and printed "policy proposal skipped", while the
    # caveats below promised the full gate. The dispatcher searches ../adopt (a git checkout) then
    # ../share/candor/adopt (this layout) — the same two-layout search it already does for the hooks.
    (pkgshare/"adopt").install "adopt/candor-init"
    prefix.install "README.md", "LICENSE-MIT", "LICENSE-APACHE"
  end

  def caveats
    <<~EOS
      candor manages the analysis engines for you. Get to a first result:

        cd your-project
        candor tour            # the most surprising reaches in this code

      That is the whole thing. If the engine your project needs is not installed
      candor fetches it, and if there is no report yet it scans first — each
      announced before it happens. To require the explicit steps instead, set
      CANDOR_NO_AUTOFETCH=1 / CANDOR_NO_AUTOSCAN=1:

        candor update          # fetch the engines (the JVM engine as a native
                               #   binary — no JVM needed); ts runs via npx
        candor scan .          # analyse (engine picked by the manifest)
        candor doctor          # verify installs + spec agreement

      More:
        candor engines         # what's installed, and where each comes from
        candor outdated        # is a newer version available?
        candor init            # stand up the effect gate (every language present)

      Update everything (the umbrella pins the whole family, so engines stay in
      agreement): brew upgrade candor && candor update
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/candor --version")
    # The install must carry `candor init`'s policy proposer. It did not for several releases, and
    # nothing noticed: the dispatcher degrades to "policy proposal skipped" rather than failing, so a
    # brew user got a quieter `init` than the caveats describe and no error anywhere.
    assert_predicate pkgshare/"adopt/candor-init", :exist?
  end
end

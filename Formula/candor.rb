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
  url "https://github.com/tombaldwin/candor/archive/refs/tags/0.23.0.tar.gz"
  sha256 "0fa439f5a4bc537beea465509ce13aa174c0c76aab8866faa2b91b56b72a1db5" # filled at ship by update-candor.sh
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
    prefix.install "README.md", "LICENSE-MIT", "LICENSE-APACHE"
  end

  def caveats
    <<~EOS
      candor manages the analysis engines for you. Get to a first result:

        candor update          # fetch the engines (the JVM engine as a native
                               #   binary — no JVM needed); ts runs via npx
        cd your-project
        candor scan .          # analyse (engine picked by the manifest)
        candor tour            # a result: the most surprising reaches
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
  end
end

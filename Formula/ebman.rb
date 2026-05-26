# Homebrew formula for ebman — k9s-style TUI for AWS Elastic Beanstalk.
#
# Install:
#   brew tap tombaldwin/tap
#   brew install ebman
#
# Bumping for a new release: run `scripts/update-formula.sh vX.Y.Z` from
# the ebman repo — it computes SHA-256s from the GitHub Release tarballs
# and writes both the in-repo Formula/ebman.rb and this tap copy in one
# go. The release workflow at .github/workflows/release.yml produces the
# tarballs the script consumes.
class Ebman < Formula
  desc "k9s-style TUI for AWS Elastic Beanstalk"
  homepage "https://github.com/tombaldwin/ebman"
  version "0.10.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "cefae666d32631187fde677255eb87be24844868ae7b6201d2c4fa6043386f7d"
    else
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0a16f953b4b632f4f9a8fed8fdd022800613f52c55c81014e884d6ec34faa77d"
    end
  elsif OS.linux?
    url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a07764cf18e1d49bcedb7ea001fe7ea1c62a336333a711160ff8fe95ea9b60a7"
  end

  depends_on "curl" # used by the live-log-tail S3 fetcher

  def install
    bin.install "ebman"
    prefix.install "README.md", "LICENSE-MIT", "LICENSE-APACHE"
  end

  test do
    assert_match "ebman #{version}", shell_output("#{bin}/ebman --version")
  end
end

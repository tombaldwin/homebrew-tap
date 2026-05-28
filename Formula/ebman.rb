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
  version "0.17.4"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a0f8ba827d56a18b7c3cd845af439c493f84907275cfa940c1e8754febd614bc"
    else
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8b884a2a3812d0d5c9a277fb0fa8cedcce225909fa6156bba11a02d3441a60ea"
    end
  elsif OS.linux?
    url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "28aba32dda6bd75891cbcc99748040bf836437f6f48873bd0ca79c7604d4d5f0"
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

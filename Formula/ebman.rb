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
  version "0.12.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "5780e7ab2664a8c96982035477b6d3959eaacf4c3b205bde734adc32fade47e0"
    else
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "b3c05fb642a81d2f1947e2d516a9fd530fe8d75f9c73b9f0552d675d44526a9e"
    end
  elsif OS.linux?
    url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0a75ba35ee7fe41713813eea2e688480100f2372b18638a7de8bebc50d7fed82"
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

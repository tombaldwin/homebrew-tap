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
  version "0.22.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "eeaba2e49d58a7d3fa03ebebfab7a481a540e9f16a6abab67342385c9c1d927f"
    else
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "1fd1445653ecb9e63adc642dd5d2551e60ae9ea004be483e2607275b4026bf88"
    end
  elsif OS.linux?
    url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1543deca07c1d59796e13d6b7deabe97ecf19deae36d6aa9b9794a4c31255f3d"
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

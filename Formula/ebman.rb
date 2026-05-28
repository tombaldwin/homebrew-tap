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
  version "0.17.0"
  license "MIT OR Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "497771c5dd2d35489425d1dd25c76bffc2683ebdac6e0b79254c2ec16e5b8152"
    else
      url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a7715a80b9dd7d68802c66225485e5181957cfe7dc959435ed8fb4d0fbddf867"
    end
  elsif OS.linux?
    url "https://github.com/tombaldwin/ebman/releases/download/v#{version}/ebman-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "ce5ed4d817bcdc74cca67ea74bc391e1a7b18b74f26b48e83bfa1f9f461d0ad9"
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

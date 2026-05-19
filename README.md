# tombaldwin/homebrew-tap

Homebrew tap for [tombaldwin](https://github.com/tombaldwin)'s open-source tools.

## Install

```bash
brew tap tombaldwin/tap
brew install ebman
```

## Available formulae

- **[ebman](https://github.com/tombaldwin/ebman)** — k9s-style TUI for AWS Elastic Beanstalk.

## Updating

Per-release: bump `version` + the three platform `sha256` fields in [`Formula/ebman.rb`](Formula/ebman.rb) to match the new GitHub Release.

```bash
# Pull SHAs from the GH release (replace v0.1.0):
gh release view v0.1.0 --repo tombaldwin/ebman --json assets \
  -q '.assets[] | select(.name | endswith(".tar.gz")) | "\(.name) \(.digest)"'
```

## License

The formulae in this tap are MIT-licensed; the tools they install carry their own licenses (see each upstream repo).

# Versioning

This package contains a script that prints the semantic version of the current
git commit to stdout.

This script is a wrapper around the functionality of
`git describe --tags --dirty` with small changes to split the git pre-release
identifiers to allow semver sorting. It requires the latest tag of the current
branch to be a semantic version, otherwise it raises an exception. Semantic
versions with plus elements like `1.0.2+gold` are not supported and also raise
an exception.

If the latest commit does not have a semver tag, then a pre-release version is
printed.

`<latest-released-version>-[<additional-pre-release-identifier>.]<commits-since-release>.g<small-latest-git-sha>[-<dirty-tag>]`

For example: `1.0.2-5.gb3f7a0c1-dirty`; or if there are additional pre-release
identifiers in the git tag: `1.0.2-alpha.5.gb3f7a0c1-dirty`.

## Calculating the next version

This script can also calculate the next semantic version based on the current
version. To do so, use the `--next` flag. Possible values are `major`, `minor`
or `patch`.

-When `major` is used, the `major` part of the current semver is bumped and the
`minor` and `patch` parts are reset to 0.
-When `minor` is used, the `minor` part of the current semver is bumped and the
`patch` part is reset to 0.
-When `patch` is used, the `patch` part of the current semver is bumped.

## Testing

1. Use `bundle install` to update dependencies.
2. Run `rspec`:
```shell
bundle exec rspec spec/versioning.rb
```

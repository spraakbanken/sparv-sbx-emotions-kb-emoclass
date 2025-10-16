# sparv-sbx-emotions-kb-emoclass

[![PyPI version](https://img.shields.io/pypi/v/sparv-sbx-emotions-kb-emoclass.svg)](https://pypi.org/project/sparv-sbx-emotions-kb-emoclass/)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/sparv-sbx-emotions-kb-emoclass.svg)](https://pypi.org/project/sparv-sbx-emotions-kb-emoclass)

[![Maturity badge - level 2](https://img.shields.io/badge/Maturity-Level%202%20--%20First%20Release-yellowgreen.svg)](https://github.com/spraakbanken/getting-started/blob/main/scorecard.md)
[![Stage](https://img.shields.io/pypi/status/sparv-sbx-emotions-kb-emoclass)](https://pypi.org/project/sparv-sbx-emotions-kb-emoclass/)

[![Code Coverage](https://codecov.io/gh/spraakbanken/sparv-sbx-emotions-kb-emoclass/branch/main/graph/badge.svg)](https://codecov.io/gh/spraakbanken/sparv-sbx-emotions-kb-emoclass/)

[![CI(check)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/check.yml/badge.svg)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/check.yml)
[![CI(release)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/release.yml/badge.svg)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/release.yml)
[![CI(scheduled)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/rolling.yml/badge.svg)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/rolling.yml)
[![CI(test)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/test.yml/badge.svg)](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/actions/workflows/test.yml)

Plugin to [Sparv](https://github.com/spraakbanken/sparv) plugin to annotate sentences, paragraphs and texts with emotional classification.

## Install

First, install [Sparv](https://github.com/spraakbanken/sparv) as suggested,

with [`pipx`](https://):

```bash
pipx install sparv
```

or, with [`uv-pipx`]():

```bash
uvpipx install sparv
```

Then install install `sparv-sbx-emotions-kb-emoclass` with,

if you used `pipx` above:

```bash
pipx inject sparv sparv-sbx-emotions-kb-emoclass
```

or, if you used `uv-pipx` above:

```bash
uvpipx install sparv-sbx-emotions-kb-emoclass --inject sparv
```

## Usage

Depending on how many explicit exports of annotations you have you can decide to use this
annotation exclusively by adding it as the only annotation to export under `xml_export`:

```yaml
xml_export:
  annotations:
    - <sentence>:sbx_emotions_kb_emoclass.sentence-emotion--kb-emoclass
```

To use it together with other annotations you might add it under `export`:

```yaml
export:
    annotations:
        - <sentence>:sbx_emotions_kb_emoclass.sentence-emotion--kb-emoclass
        ...
```

## Known issues

- `InconsistentWarning` because of using `scikit-learn` of version `1.7.2`. See [Issue 11](https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass/issues/11).
  - Solved with: `scikit-learn<1.3.0` and `numpy<2.0.0`

> [!NOTE] You might need to put
> `export CFLAGS="-Wno-error=incompatible-pointer-types" ; export CXXFLAGS="-Wno-error=incompatible-pointer-types"` before installing

## Development

### Development prerequisites

- [`uv`](https://docs.astral.sh/uv/)
- [`pre-commit`](https://pre-commit.org)

For starting to develop on this repository:

- Clone the repo (in one of the ways below):
  - `git clone git@github.com:spraakbanken/sparv-sbx-emotions-kb-emoclass.git`
  - `git clone https://github.com/spraakbanken/sparv-sbx-emotions-kb-emoclass.git`
- Setup environment: `make dev`
- Install `pre-commit` hooks: `pre-commit install`

Do your work.

Tasks to do:

- Test the code with `make test` or `make test-w-coverage`.
- Lint the code with `make lint`.
- Check formatting with `make check-fmt`.
- Format the code with `make fmt`.
- Type-check the code with `make type-check`.
- Test the examples with:
  - `make test-example-small-txt`

This repo uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Release a new version

#### sparv-sbx-sentence-sentiment-kb-sent

- Prepare the CHANGELOG: `make prepare-release`.
- Edit `CHANGELOG.md` to your liking.
- Add to git: `git add --update`
- Commit with `git commit -m 'chore(release): prepare release'` or `cog commit chore 'prepare release' release`.
- Bump version (depends on [`bump-my-version](https://callowayproject.github.io/bump-my-version/))
  - Major: `make bumpversion part=major`
  - Minor: `make bumpversion part=minor`
  - Patch: `make bumpversion part=patch` or `make bumpversion`
- Push `main` and tags to GitHub: `git push main --tags` or `make publish`
  - [GitHub Actions workflow](./.github/workflows/release.yaml) will build, test and publish the package to [PyPi](https://pypi.prg).
- Add metadata for [Språkbanken's resource](https://spraakbanken.gu.se/resurser)
  - Generate metadata: `make generate-metadata`
  - Upload the files from `assets/metadata/export/sbx_metadata/utility` to <https://github.com/spraakbanken/metadata/tree/main/yaml/analysis>.

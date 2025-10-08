# sparv-sbx-emotional-classification

Sparv plugin to annotate sentences, paragraphs and texts with emotional classification.

## Known issues

- `InconsistentWarning` because of using `scikit-learn` of version `1.7.2`. See [Issue 11](https://github.com/spraakbanken/sparv-sbx-emotional-classification/issues/11).
  - Solved with: `scikit-learn<1.3.0` and `numpy<2.0.0`

## Development

> [!NOTE] You might need to put
> `export CFLAGS="-Wno-error=incompatible-pointer-types" ; export CXXFLAGS="-Wno-error=incompatible-pointer-types"` before installing

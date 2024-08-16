# sparv-sbx-sentence-emotional-classification-kb-emoclass

[![PyPI version](https://badge.fury.io/py/sparv-sbx-sentence-emotional-classification-kb-emoclass.svg)](https://pypi.org/project/sparv-sbx-sentence-emotional-classification-kb-emoclass)
![PyPI - Python Version](https://img.shields.io/pypi/pyversions/sparv-sbx-sentence-emotional-classification-kb-emoclass)
[![PyPI - Downloads](https://img.shields.io/pypi/dm/sparv-sbx-sentence-emotional-classification-kb-emoclass)](https://pypi.org/project/sparv-sbx-sentence-emotional-classification-kb-emoclass/)

[![Maturity badge - level 2](https://img.shields.io/badge/Maturity-Level%202%20--%20First%20Release-yellowgreen.svg)](https://github.com/spraakbanken/getting-started/blob/main/scorecard.md)
[![Stage](https://img.shields.io/pypi/status/sparv-sbx-sentence-emotional-classification-kb-emoclass)](https://pypi.org/project/sparv-sbx-sentence-emotional-classification-kb-emoclass/)

[![CI(release)](https://github.com/spraakbanken/sparv-sbx-emotional-classification/actions/workflows/release-sentence-sentiment-kb-sent.yml/badge.svg)](https://github.com/spraakbanken/sparv-sbx-emotional-classification/actions/workflows/release-sentence-sentiment-kb-sent.yml)

Plugin for computing sentence sentiment as a [Sparv](https://github.com/spraakbanken/sparv-pipeline) annotation.

## Install

First, install [Sparv](https://github.com/spraakbanken/sparv-pipeline) as suggested:

```bash
pipx install sparv-pipeline
```

Then install install `sparv-sbx-sentence-emotional-classification-kb-emoclass` with

```bash
pipx inject sparv-pipeline sparv-sbx-sentence-emotional-classification-kb-emoclass
```

## Usage

Depending on how many explicit exports of annotations you have you can decide to use this
annotation exclusively by adding it as the only annotation to export under `xml_export`:

```yaml
xml_export:
    annotations:
        - <sentence>:sbx_sentence_emotional_classification_kb_emoclass.sentence-emotional-classification--kb-emoclass
```

To use it together with other annotations you might add it under `export`:

```yaml
export:
    annotations:
        - <sentence>:sbx_sentence_emotional_classification_kb_emoclass.sentence-emotional-classification--kb-emoclass
        ...
```

### Configuration

You can configure this plugin in the following way.

#### Number of Decimals

The number of decimals defaults to `3` but can be configured in `config.yaml`:

```yaml
sbx_sentence_emotional_classification_kb_emoclass:
    num_decimals: 3
```

> [!NOTE] This also controls the cut-off, so all values where the score round to 0.000 (or the number of decimals) is discarded.

### Metadata

#### Model

Type | HuggingFace Model | Revision
--- | --- | ---
Model | [`KBLab/emotional-classification`](https://huggingface.co/KBLab/emotional-classification) | 73f1663770e79ff5c1aa12a38063a13537a02ce0

## Changelog

This project keeps a [changelog](./CHANGELOG.md).

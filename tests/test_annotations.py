import pytest
from sparv import api as sparv_api
from sparv_testing import MemoryOutput, MockAnnotation
from syrupy.assertion import SnapshotAssertion

from sbx_emotions_kb_emoclass.annotations import annotate_sentence


def test_annotate_sentence_lang_en(snapshot) -> None:  # noqa: ANN001
    output: MemoryOutput = MemoryOutput()
    word = MockAnnotation(
        name="<token>",
        values=[
            "Han",
            "var",
            "glad",
            ".",
            "Rihanna",
            "uppges",
            "gravid",
            ".",
            "Jag",
            "har",
            "ätit",
            "sämre",
            ".",
        ],
    )
    sentence = MockAnnotation(
        name="<sentence>", children={"<token>": [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11, 12]]}
    )

    annotate_sentence(output, word, sentence, None)

    assert output.values == snapshot


def test_annotate_sentence_lang_sv(snapshot) -> None:  # noqa: ANN001
    output: MemoryOutput = MemoryOutput()
    word = MockAnnotation(
        name="<token>",
        values=[
            "Han",
            "var",
            "glad",
            ".",
            "Rihanna",
            "uppges",
            "gravid",
            ".",
            "Jag",
            "har",
            "ätit",
            "sämre",
            ".",
        ],
    )
    sentence = MockAnnotation(
        name="<sentence>", children={"<token>": [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11, 12]]}
    )

    annotate_sentence(output, word, sentence, "sv")

    assert output.values == snapshot


def test_annotate_sentence_with_unsupported_lang_raise_value_error(
    snapshot: SnapshotAssertion,
) -> None:
    with pytest.raises(sparv_api.SparvErrorMessage) as exc:
        annotate_sentence(None, None, "sentence", "xx")

    assert str(exc) == snapshot

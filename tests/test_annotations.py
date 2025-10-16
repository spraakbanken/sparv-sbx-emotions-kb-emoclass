from sbx_sentence_emotional_classification_kb_emoclass.annotations import annotate_sentence
from sparv_testing import MemoryOutput, MockAnnotation


def test_annotate_sentence(snapshot) -> None:  # noqa: ANN001
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

    annotate_sentence(output, word, sentence)

    assert output.values == snapshot

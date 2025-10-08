"""Emotional classifier."""

import pytest
from sbx_sentence_emotional_classification_kb_emoclass.emotional_classifier import (
    EmotionalClassifier,
)


@pytest.fixture(name="emotional_classifier", scope="session")
def fixture_emotional_classifier() -> EmotionalClassifier:
    return EmotionalClassifier()


@pytest.fixture(name="emotional_classifier_sv", scope="session")
def fixture_emotional_classifier_sv() -> EmotionalClassifier:
    return EmotionalClassifier(lang="sv")


def test_emotional_classifier_with_unknown_lang_raises() -> None:
    with pytest.raises(ValueError):
        EmotionalClassifier(lang="xx")


def test_hope_text_en(emotional_classifier: EmotionalClassifier) -> None:
    text = "Vi hoppas och tror att detta också snabbt ska kunna komma på plats , säger Garborg ."

    actual = emotional_classifier.predict_emotion_sentence(text)

    assert actual == "HOPE/ANTICIPATION"


def test_hope_text_sv(emotional_classifier_sv: EmotionalClassifier) -> None:
    text = "Vi hoppas och tror att detta också snabbt ska kunna komma på plats , säger Garborg ."

    actual = emotional_classifier_sv.predict_emotion_sentence(text)

    assert actual == "HOPP/FÖRVÄNTAN"

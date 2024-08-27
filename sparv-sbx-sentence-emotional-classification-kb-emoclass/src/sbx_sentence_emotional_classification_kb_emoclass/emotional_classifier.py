"""Emotional classifier."""

from typing import Optional

from setfit import SetFitModel

MODEL_NAME = "KBLab/emotional-classification"
MODEL_REVISION = "73f1663770e79ff5c1aa12a38063a13537a02ce0"

LABELS_SWE = {
    0: "KÄNSLA SAKNAS",
    1: "GLÄDJE",
    2: "KÄRLEK/EMPATI",
    3: "ORO/RÄDSLA",
    4: "SORG/BESVIKELSE",
    5: "ILSKA/HAT",
    6: "HOPP/FÖRVÄNTAN",
}

LABELS_ENG = {
    0: "ABSENCE OF EMOTION",
    1: "HAPPINESS",
    2: "LOVE/EMPATHY",
    3: "FEAR/ANXIETY",
    4: "SADNESS/DISAPPOINTMENT",
    5: "ANGER/HATE",
    6: "HOPE/ANTICIPATION",
}


class EmotionalClassifier:
    """Emotional classifier."""

    def __init__(self, model: Optional[SetFitModel] = None, lang: str = "en") -> None:
        """Emotional classifier.

        Args:
            model: An optional model to use. If no model is given,
                the default model will be loaded.
        """
        if lang == "en":
            self.labels = LABELS_ENG
        elif lang == "sv":
            self.labels = LABELS_SWE
        else:
            raise ValueError("supported langs are 'en' and 'sv'. Given '{}'")
        self.model = model or self._default_model()

    @classmethod
    def _default_model(cls) -> SetFitModel:
        return SetFitModel.from_pretrained(MODEL_NAME, revision=MODEL_REVISION)

    def predict_emotion_sentence(self, text: str) -> str:
        """Predict emotion on sentence.

        Args:
            text: the text to analyze

        Returns:
            the predicted emotion
        """
        preds = self.model.predict([text], as_numpy=True)
        return self.labels[preds[0]]  # type: ignore

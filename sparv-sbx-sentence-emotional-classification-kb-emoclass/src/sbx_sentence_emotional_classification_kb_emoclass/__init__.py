"""Sparv plugin for annotating sentences with emotional classification."""

# from sparv import api as sparv_api
from sbx_sentence_emotional_classification_kb_emoclass.annotations import annotate_sentence

__all__ = ["annotate_sentence"]


__description__ = "Annotate sentences with emotional classification."
__version__ = "0.1.0"

# __config__ = [sparv_api.Config(f"{PROJECT_NAME}.num_decimals")]

from typing import Dict, Any

class AiProvider:
    def generate_text(self, prompt: str, context: Dict[str, Any]) -> Dict[str, Any]:
        raise NotImplementedError

class GeminiStub(AiProvider):
    def __init__(self, model_name: str = 'gemini-text-default'):
        self.model_name = model_name

    def generate_text(self, prompt: str, context: Dict[str, Any]) -> Dict[str, Any]:
        # Phase 1: stubbed provider — no external calls, deterministic response
        return {'text': '[stub] This is a Gemini stub response.', 'structured': {}}

import anthropic
import os

class LLMProvider:
    """A base class for LLM API providers."""
    def __init__(self, api_key: str):
        if not api_key:
            raise ValueError("API key cannot be empty.")
        self.api_key = api_key

    def create_message(self, model: str, messages: list, system_prompt: str, max_tokens: int = 4096):
        """Creates a message using the provider's API."""
        raise NotImplementedError

class AnthropicProvider(LLMProvider):
    """An implementation for the Anthropic API."""
    def __init__(self, api_key: str):
        super().__init__(api_key)
        self.client = anthropic.Anthropic(api_key=self.api_key)

    def create_message(self, model: str, messages: list, system_prompt: str, max_tokens: int = 4096):
        """
        Creates a message using the Anthropic API.
        This version is currently locked to 'claude-sonnet-4-20250514' and
        always uses the 'thinking' parameter.
        """
        # --- Model Enforcement ---
        # As requested, lock the model to a specific version for now.
        allowed_model = "claude-sonnet-4-20250514"
        if model != allowed_model:
            raise ValueError(
                f"This script is currently configured to only use the '{allowed_model}' model. "
                f"You passed '{model}'. Please update the API call or modify the provider if you wish to use a different model."
            )

        # --- Request Preparation ---
        request_params = {
            "model": model,
            "max_tokens": max_tokens,
            "system": system_prompt,
            "messages": messages,
            "thinking": {"type": "enabled", "budget_tokens": 3000},
            "temperature": 1.0 # Required by the API when 'thinking' is enabled
        }
        
        return self.client.messages.create(**request_params)

def get_provider(provider_name: str = "anthropic") -> type[LLMProvider]:
    """
    Factory function to get a provider class based on its name.
    """
    if provider_name.lower() == "anthropic":
        return AnthropicProvider
    # Add other providers here in the future, e.g.:
    # elif provider_name.lower() == "openai":
    #     return OpenAIProvider
    else:
        raise ValueError(f"Unknown provider: {provider_name}") 
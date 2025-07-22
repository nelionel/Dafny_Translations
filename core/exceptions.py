"""Custom exceptions for Dafny translation"""


class DafnyTranslationError(Exception):
    """Base exception for all Dafny translation errors"""
    pass


class TranslationError(DafnyTranslationError):
    """Error during translation from Python to Dafny"""
    pass


class CompilationError(DafnyTranslationError):
    """Error during Dafny compilation"""
    pass


class VerificationError(DafnyTranslationError):
    """Error during Dafny verification"""
    pass


class ConfigurationError(DafnyTranslationError):
    """Error in configuration"""
    pass


class APIError(DafnyTranslationError):
    """Error from LLM API"""
    pass 
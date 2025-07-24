def compare(game, guess):
    """
    Compare game scores with guesses and return the absolute differences.
    
    Args:
        game: List of actual game scores
        guess: List of guessed scores
    
    Returns:
        List of absolute differences between actual and guessed scores
    """
    return [abs(actual - guessed) for actual, guessed in zip(game, guess)]
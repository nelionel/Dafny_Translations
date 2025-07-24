def compare(game, guess):
    """
    Compares game scores with guesses and returns absolute differences.
    
    Args:
        game: List of actual game scores
        guess: List of guessed scores
    
    Returns:
        List of absolute differences between actual and guessed scores
    """
    result = []
    
    for i in range(len(game)):
        difference = abs(game[i] - guess[i])
        result.append(difference)
    
    return result
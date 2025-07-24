def compare(game, guess):
    """
    Determines how far off each guess was from the actual game results.
    
    Args:
        game: List of actual game scores
        guess: List of guessed scores
    
    Returns:
        List of absolute differences between guesses and actual scores
    """
    result = []
    
    # Iterate through both arrays simultaneously
    for i in range(len(game)):
        # Calculate absolute difference between actual score and guess
        difference = abs(game[i] - guess[i])
        result.append(difference)
    
    return result
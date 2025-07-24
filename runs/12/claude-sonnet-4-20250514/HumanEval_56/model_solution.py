def correct_bracketing(brackets: str):
    """ brackets is a string of "<" and ">".
    return True if every opening bracket has a corresponding closing bracket.

    >>> correct_bracketing("<")
    False
    >>> correct_bracketing("<>")
    True
    >>> correct_bracketing("<<><>>")
    True
    >>> correct_bracketing("><<>")
    False
    """
    counter = 0
    
    for bracket in brackets:
        if bracket == "<":
            counter += 1
        elif bracket == ">":
            counter -= 1
            # If we have more closing brackets than opening brackets at any point
            if counter < 0:
                return False
    
    # All opening brackets should have corresponding closing brackets
    return counter == 0
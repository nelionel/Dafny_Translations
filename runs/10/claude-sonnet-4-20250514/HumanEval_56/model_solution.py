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
            # If counter goes negative, we have more closing than opening brackets
            if counter < 0:
                return False
    
    # All brackets are matched if counter is zero
    return counter == 0
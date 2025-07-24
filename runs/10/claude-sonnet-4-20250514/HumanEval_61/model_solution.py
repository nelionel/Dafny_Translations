def correct_bracketing(brackets: str):
    """ brackets is a string of "(" and ")".
    return True if every opening bracket has a corresponding closing bracket.

    >>> correct_bracketing("(")
    False
    >>> correct_bracketing("()")
    True
    >>> correct_bracketing("(()())")
    True
    >>> correct_bracketing(")(()")
    False
    """
    count = 0
    
    for bracket in brackets:
        if bracket == "(":
            count += 1
        elif bracket == ")":
            count -= 1
            # If count goes negative, we have more closing than opening brackets
            if count < 0:
                return False
    
    # All brackets should be matched (count should be 0)
    return count == 0
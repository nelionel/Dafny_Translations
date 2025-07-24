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
    balance = 0
    
    for bracket in brackets:
        if bracket == "(":
            balance += 1
        elif bracket == ")":
            balance -= 1
            # If balance goes negative, we have more closing than opening brackets
            if balance < 0:
                return False
    
    # Return True only if all brackets are matched (balance is 0)
    return balance == 0
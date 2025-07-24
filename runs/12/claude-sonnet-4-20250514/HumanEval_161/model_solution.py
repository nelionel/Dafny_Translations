def solve(s):
    """You are given a string s.
    if s[i] is a letter, reverse its case from lower to upper or vise versa, 
    otherwise keep it as it is.
    If the string contains no letters, reverse the string.
    The function should return the resulted string.
    Examples
    solve("1234") = "4321"
    solve("ab") = "AB"
    solve("#a@C") = "#A@c"
    """
    # Check if string contains any letters
    has_letters = any(c.isalpha() for c in s)
    
    if not has_letters:
        # No letters, reverse the string
        return s[::-1]
    else:
        # Has letters, reverse case of letters
        result = ""
        for c in s:
            if c.isalpha():
                result += c.swapcase()
            else:
                result += c
        return result
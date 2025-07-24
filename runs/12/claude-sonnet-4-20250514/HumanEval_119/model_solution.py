def match_parens(lst):
    '''
    You are given a list of two strings, both strings consist of open
    parentheses '(' or close parentheses ')' only.
    Your job is to check if it is possible to concatenate the two strings in
    some order, that the resulting string will be good.
    A string S is considered to be good if and only if all parentheses in S
    are balanced. For example: the string '(())()' is good, while the string
    '())' is not.
    Return 'Yes' if there's a way to make a good string, and return 'No' otherwise.

    Examples:
    match_parens(['()(', ')']) == 'Yes'
    match_parens([')', ')']) == 'No'
    '''
    
    def is_balanced(s):
        """Check if a string of parentheses is balanced"""
        counter = 0
        for char in s:
            if char == '(':
                counter += 1
            else:  # char == ')'
                counter -= 1
                # If we have more closing than opening at any point, it's not balanced
                if counter < 0:
                    return False
        # At the end, we should have equal opening and closing parentheses
        return counter == 0
    
    s1, s2 = lst
    
    # Try both possible concatenation orders
    if is_balanced(s1 + s2) or is_balanced(s2 + s1):
        return 'Yes'
    else:
        return 'No'
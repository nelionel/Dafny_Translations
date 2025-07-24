def is_nested(string):
    '''
    Create a function that takes a string as input which contains only square brackets.
    The function should return True if and only if there is a valid subsequence of brackets 
    where at least one bracket in the subsequence is nested.
    '''
    stack = []
    max_depth = 0
    
    for char in string:
        if char == '[':
            stack.append(char)
            max_depth = max(max_depth, len(stack))
        elif char == ']' and stack:
            stack.pop()
    
    return max_depth >= 2
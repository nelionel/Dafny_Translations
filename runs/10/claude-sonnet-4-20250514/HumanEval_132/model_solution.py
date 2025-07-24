def is_nested(string):
    '''
    Create a function that takes a string as input which contains only square brackets.
    The function should return True if and only if there is a valid subsequence of brackets 
    where at least one bracket in the subsequence is nested.
    '''
    stack = []
    max_depth = 0
    current_depth = 0
    
    for char in string:
        if char == '[':
            stack.append(char)
            current_depth += 1
            max_depth = max(max_depth, current_depth)
        elif char == ']':
            if stack:  # Only pop if there's a matching opening bracket
                stack.pop()
                current_depth -= 1
    
    # We need at least one complete pair AND max depth > 1
    # If max_depth > current_depth, it means we had some complete pairs
    return max_depth > 1 and max_depth > current_depth
def is_nested(string):
    '''
    Create a function that takes a string as input which contains only square brackets.
    The function should return True if and only if there is a valid subsequence of brackets 
    where at least one bracket in the subsequence is nested.
    '''
    # We need to find if there's a valid subsequence with nesting
    # A valid nested structure means we have brackets inside other brackets
    
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
    
    # For nesting to exist, we need at least depth 2
    # But we also need to ensure we can form valid pairs
    # Let's use a different approach: count valid nested pairs
    
    # Reset and try a different approach
    open_count = 0
    nested_found = False
    
    for char in string:
        if char == '[':
            open_count += 1
        elif char == ']' and open_count > 0:
            open_count -= 1
            # If we still have open brackets after closing one,
            # it means we had nesting
            if open_count > 0:
                nested_found = True
    
    # We need at least one complete nested pair
    # Let's verify by checking if we can form a valid nested structure
    if not nested_found:
        return False
    
    # Additional check: ensure we have enough brackets to form valid pairs
    open_brackets = string.count('[')
    close_brackets = string.count(']')
    
    # We need at least 4 brackets total to have nesting (like [[]])
    if open_brackets < 2 or close_brackets < 2:
        return False
    
    # Final verification: simulate the bracket matching process
    stack = []
    depth_when_closed = []
    
    for char in string:
        if char == '[':
            stack.append(len(stack))  # Store the depth when this bracket was opened
        elif char == ']' and stack:
            depth = stack.pop()
            depth_when_closed.append(depth)
    
    # Check if any bracket was closed at depth > 0 (meaning it was nested)
    return any(depth > 0 for depth in depth_when_closed)
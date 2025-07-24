def cycpattern_check(a, b):
    """You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
    cycpattern_check("abcd","abd") => False
    cycpattern_check("hello","ell") => True
    cycpattern_check("whassup","psus") => False
    cycpattern_check("abab","baa") => True
    cycpattern_check("efef","eeff") => False
    cycpattern_check("himenss","simen") => True
    """
    if not b:  # Empty string case
        return True
    
    # Generate all rotations of word b
    for i in range(len(b)):
        # Create rotation by moving first i characters to the end
        rotation = b[i:] + b[:i]
        # Check if this rotation is a substring of a
        if rotation in a:
            return True
    
    return False
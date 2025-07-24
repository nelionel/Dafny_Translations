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
    
    # Generate all rotations of string b
    for i in range(len(b)):
        rotation = b[i:] + b[:i]  # Rotate by i positions
        if rotation in a:  # Check if this rotation is a substring of a
            return True
    
    return False
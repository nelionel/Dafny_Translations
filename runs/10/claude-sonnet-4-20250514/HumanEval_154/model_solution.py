def cycpattern_check(a, b):
    """You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
    cycpattern_check("abcd","abd") => False
    cycpattern_check("hello","ell") => True
    cycpattern_check("whassup","psus") => False
    cycpattern_check("abab","baa") => True
    cycpattern_check("efef","eeff") => False
    cycpattern_check("himenss","simen") => True
    """
    
    # If b is empty, it's considered a substring of any string
    if not b:
        return True
    
    # If b is longer than a, no rotation of b can be a substring of a
    if len(b) > len(a):
        return False
    
    # Generate all rotations of b and check if any is a substring of a
    for i in range(len(b)):
        rotation = b[i:] + b[:i]
        if rotation in a:
            return True
    
    return False
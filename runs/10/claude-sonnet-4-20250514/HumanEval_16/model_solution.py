def count_distinct_characters(string: str) -> int:
    """ Given a string, find out how many distinct characters (regardless of case) does it consist of
    >>> count_distinct_characters('xyzXYZ')
    3
    >>> count_distinct_characters('Jerry')
    4
    """
    # Convert to lowercase to handle case-insensitivity
    # Use set to get unique characters, then return the count
    return len(set(string.lower()))
def find_max(words):
    """Write a function that accepts a list of strings.
    The list contains different words. Return the word with maximum number
    of unique characters. If multiple strings have maximum number of unique
    characters, return the one which comes first in lexicographical order.

    find_max(["name", "of", "string"]) == "string"
    find_max(["name", "enam", "game"]) == "enam"
    find_max(["aaaaaaa", "bb" ,"cc"]) == "aaaaaaa"
    """
    if not words:
        return ""
    
    max_unique_count = 0
    result = ""
    
    for word in words:
        unique_count = len(set(word))
        
        # Update result if this word has more unique characters,
        # or if it has the same number but comes first lexicographically
        if (unique_count > max_unique_count or 
            (unique_count == max_unique_count and word < result)):
            max_unique_count = unique_count
            result = word
    
    return result
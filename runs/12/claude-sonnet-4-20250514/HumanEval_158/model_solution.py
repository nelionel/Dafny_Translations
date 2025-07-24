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
    
    def get_unique_count(word):
        return len(set(word))
    
    # Find the maximum unique character count
    max_unique_count = max(get_unique_count(word) for word in words)
    
    # Filter words with maximum unique count and return the lexicographically smallest
    candidates = [word for word in words if get_unique_count(word) == max_unique_count]
    
    return min(candidates)
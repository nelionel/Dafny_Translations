import re

def words_string(s):
    """
    You will be given a string of words separated by commas or spaces. Your task is
    to split the string into words and return an array of the words.
    
    For example:
    words_string("Hi, my name is John") == ["Hi", "my", "name", "is", "John"]
    words_string("One, two, three, four, five, six") == ["One", "two", "three", "four", "five", "six"]
    """
    if not s or not s.strip():
        return []
    
    # Split by comma and/or space using regex
    # The pattern [,\s]+ matches one or more commas or whitespace characters
    words = re.split(r'[,\s]+', s.strip())
    
    # Filter out empty strings that might result from consecutive separators
    return [word for word in words if word]
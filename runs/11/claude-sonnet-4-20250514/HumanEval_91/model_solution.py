def is_bored(S):
    """
    You'll be given a string of words, and your task is to count the number
    of boredoms. A boredom is a sentence that starts with the word "I".
    Sentences are delimited by '.', '?' or '!'.
   
    For example:
    >>> is_bored("Hello world")
    0
    >>> is_bored("The sky is blue. The sun is shining. I love this weather")
    1
    """
    import re
    
    # Split the string by sentence delimiters
    sentences = re.split(r'[.?!]', S)
    
    boredom_count = 0
    
    for sentence in sentences:
        # Strip whitespace and check if sentence starts with "I"
        sentence = sentence.strip()
        if sentence:  # Make sure sentence is not empty
            words = sentence.split()
            if words and words[0] == "I":
                boredom_count += 1
    
    return boredom_count
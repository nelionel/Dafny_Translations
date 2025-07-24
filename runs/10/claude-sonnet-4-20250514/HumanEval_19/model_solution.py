from typing import List


def sort_numbers(numbers: str) -> str:
    """ Input is a space-delimited string of numberals from 'zero' to 'nine'.
    Valid choices are 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight' and 'nine'.
    Return the string with numbers sorted from smallest to largest
    >>> sort_numbers('three one five')
    'one three five'
    """
    # Handle empty string
    if not numbers.strip():
        return ""
    
    # Mapping of number words to their numeric values
    word_to_num = {
        'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4,
        'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9
    }
    
    # Split the input string into individual number words
    number_words = numbers.split()
    
    # Sort the words based on their numeric values
    sorted_words = sorted(number_words, key=lambda word: word_to_num[word])
    
    # Join the sorted words back into a space-delimited string
    return ' '.join(sorted_words)
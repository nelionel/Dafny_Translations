from typing import List

def parse_music(music_string: str) -> List[int]:
    """ Input to this function is a string representing musical notes in a special ASCII format.
    Your task is to parse this string and return list of integers corresponding to how many beats does each
    not last.

    Here is a legend:
    'o' - whole note, lasts four beats
    'o|' - half note, lasts two beats
    '.|' - quater note, lasts one beat

    >>> parse_music('o o| .| o| o| .| .| .| .| o o')
    [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]
    """
    if not music_string.strip():
        return []
    
    # Define mapping from note symbols to beat counts
    note_beats = {
        'o': 4,    # whole note
        'o|': 2,   # half note
        '.|': 1    # quarter note
    }
    
    # Split the string by spaces to get individual notes
    notes = music_string.split()
    
    # Convert each note to its corresponding beat count
    result = []
    for note in notes:
        if note in note_beats:
            result.append(note_beats[note])
    
    return result
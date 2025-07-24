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
    
    # Split by spaces to get individual notes
    notes = music_string.split()
    beats = []
    
    for note in notes:
        if note == 'o|':
            beats.append(2)  # half note
        elif note == '.|':
            beats.append(1)  # quarter note
        elif note == 'o':
            beats.append(4)  # whole note
    
    return beats
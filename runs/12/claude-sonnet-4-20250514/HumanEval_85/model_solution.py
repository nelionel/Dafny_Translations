def add(lst):
    """Given a non-empty list of integers lst. add the even elements that are at odd indices..


    Examples:
        add([4, 2, 6, 7]) ==> 2 
    """
    total = 0
    for i, value in enumerate(lst):
        if i % 2 == 1 and value % 2 == 0:  # odd index and even value
            total += value
    return total
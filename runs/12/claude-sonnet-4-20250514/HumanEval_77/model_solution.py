def iscube(a):
    '''
    Write a function that takes an integer a and returns True 
    if this ingeger is a cube of some integer number.
    Note: you may assume the input is always valid.
    Examples:
    iscube(1) ==> True
    iscube(2) ==> False
    iscube(-1) ==> True
    iscube(64) ==> True
    iscube(0) ==> True
    iscube(180) ==> False
    '''
    if a == 0:
        return True
    
    # Handle negative numbers by working with absolute value
    if a < 0:
        cube_root = -((-a) ** (1/3))
    else:
        cube_root = a ** (1/3)
    
    # Round to nearest integer to handle floating point precision issues
    rounded_root = round(cube_root)
    
    # Check if the rounded root cubed equals the original number
    return rounded_root ** 3 == a
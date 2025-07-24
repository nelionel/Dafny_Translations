def right_angle_triangle(a, b, c):
    '''
    Given the lengths of the three sides of a triangle. Return True if the three
    sides form a right-angled triangle, False otherwise.
    A right-angled triangle is a triangle in which one angle is right angle or 
    90 degree.
    Example:
    right_angle_triangle(3, 4, 5) == True
    right_angle_triangle(1, 2, 3) == False
    '''
    # Sort the sides to identify the longest one (potential hypotenuse)
    sides = sorted([a, b, c])
    
    # Apply Pythagorean theorem: a² + b² = c²
    # where c is the longest side
    return sides[0]**2 + sides[1]**2 == sides[2]**2
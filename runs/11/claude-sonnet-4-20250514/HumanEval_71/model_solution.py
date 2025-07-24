def triangle_area(a, b, c):
    '''
    Given the lengths of the three sides of a triangle. Return the area of
    the triangle rounded to 2 decimal points if the three sides form a valid triangle. 
    Otherwise return -1
    Three sides make a valid triangle when the sum of any two sides is greater 
    than the third side.
    Example:
    triangle_area(3, 4, 5) == 6.00
    triangle_area(1, 2, 10) == -1
    '''
    # Check if the three sides form a valid triangle
    # Triangle inequality: sum of any two sides must be greater than the third side
    if a + b > c and a + c > b and b + c > a:
        # Calculate area using Heron's formula
        # s = semi-perimeter
        s = (a + b + c) / 2
        
        # Area = sqrt(s * (s-a) * (s-b) * (s-c))
        area = (s * (s - a) * (s - b) * (s - c)) ** 0.5
        
        # Round to 2 decimal places
        return round(area, 2)
    else:
        return -1
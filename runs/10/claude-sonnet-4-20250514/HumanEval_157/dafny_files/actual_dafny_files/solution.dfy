method right_angle_triangle(a: real, b: real, c: real) returns (result: bool)
    ensures result <==> (
        // Valid triangle conditions
        a > 0.0 && b > 0.0 && c > 0.0 &&
        a + b > c && a + c > b && b + c > a &&
        // Pythagorean theorem for some ordering of the sides
        (a * a + b * b == c * c || a * a + c * c == b * b || b * b + c * c == a * a)
    )
{
    // First check if the sides can form a valid triangle
    // Triangle inequality: sum of any two sides must be greater than the third side
    if a + b <= c || a + c <= b || b + c <= a {
        return false;
    }
    
    // Check if any side is non-positive
    if a <= 0.0 || b <= 0.0 || c <= 0.0 {
        return false;
    }
    
    // Sort the sides to identify the longest side (hypotenuse)
    // Manual sorting of three values
    var side1, side2, side3: real;
    
    if a >= b && a >= c {
        side3 := a; // a is largest
        if b >= c {
            side1 := c;
            side2 := b;
        } else {
            side1 := b;
            side2 := c;
        }
    } else if b >= a && b >= c {
        side3 := b; // b is largest
        if a >= c {
            side1 := c;
            side2 := a;
        } else {
            side1 := a;
            side2 := c;
        }
    } else {
        side3 := c; // c is largest
        if a >= b {
            side1 := b;
            side2 := a;
        } else {
            side1 := a;
            side2 := b;
        }
    }
    
    // Apply Pythagorean theorem: side1² + side2² = side3²
    // Where side3 is the longest side (hypotenuse)
    return side1 * side1 + side2 * side2 == side3 * side3;
}
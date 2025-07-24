method any_int(x: real, y: real, z: real) returns (result: bool)
    ensures result == (
        (x as int as real == x && y as int as real == y && z as int as real == z) &&
        (x == y + z || y == x + z || z == x + y)
    )
{
    // Check if all numbers are integers
    if !(x as int as real == x && y as int as real == y && z as int as real == z) {
        return false;
    }
    
    // Check if any number equals the sum of the other two
    if x == y + z || y == x + z || z == x + y {
        return true;
    }
    
    return false;
}
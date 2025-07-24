method truncate_number(number: real) returns (result: real)
    requires number > 0.0
    ensures 0.0 <= result < 1.0
    ensures result == number - (number as int) as real
{
    result := number - (number as int) as real;
}
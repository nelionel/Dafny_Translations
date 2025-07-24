method car_race_collision(n: int) returns (result: int)
    requires n >= 0
    ensures result == n * n
{
    result := n * n;
}
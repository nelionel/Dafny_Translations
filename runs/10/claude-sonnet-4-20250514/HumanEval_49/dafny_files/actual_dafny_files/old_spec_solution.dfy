method modp(n: int, p: int) returns (result: int)
    requires p > 0
    requires n >= 0
    ensures 0 <= result < p
{
    result := 1;
    var base := 2 % p;
    var exp := n;
    
    while exp > 0
        invariant 0 <= result < p
        invariant 0 <= base < p
        invariant exp >= 0
        decreases exp
    {
        if exp % 2 == 1 {
            result := (result * base) % p;
        }
        base := (base * base) % p;
        exp := exp / 2;
    }
}
method factorize(n: int) returns (factors: seq<int>)
    requires n >= 0
    ensures n <= 1 ==> |factors| == 0
    ensures n > 1 ==> |factors| > 0
    ensures forall i :: 0 <= i < |factors| - 1 ==> factors[i] <= factors[i + 1]
{
    factors := [];
    
    if n <= 1 {
        return;
    }
    
    var current := n;
    
    // Extract all factors of 2
    while current % 2 == 0
        invariant current > 0
        decreases current
    {
        factors := factors + [2];
        current := current / 2;
    }
    
    // Check odd factors starting from 3
    var factor := 3;
    while factor * factor <= current
        invariant factor >= 3
        invariant factor % 2 == 1
        invariant current > 0
        decreases current - factor + 1000000  // Ensures termination as either current decreases or factor increases
    {
        if current % factor == 0 {
            while current % factor == 0
                invariant current > 0
                decreases current
            {
                factors := factors + [factor];
                current := current / factor;
            }
        }
        factor := factor + 2;
    }
    
    // If current is still greater than 1, then it's a prime factor
    if current > 1 {
        factors := factors + [current];
    }
}
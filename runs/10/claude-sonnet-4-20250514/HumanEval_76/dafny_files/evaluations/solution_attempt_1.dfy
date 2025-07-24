method is_simple_power(x: int, n: int) returns (result: bool)
    ensures (n == 1) ==> (result <==> (x == 1))
    ensures (n == 0) ==> (result <==> (x == 0))
    ensures (n != 0 && x == 1) ==> result
    ensures (n != 0 && x == 0) ==> !result
    ensures (n == -1) ==> (result <==> (x == 1 || x == -1))
    ensures (n > 1 && x < 0) ==> !result
    ensures (n < -1) ==> (result ==> (x == 1 || exists k: int :: k > 0 && ((k % 2 == 1 && power_of(abs(n), k) == -x) || (k % 2 == 0 && power_of(abs(n), k) == x))))
    ensures (n > 1) ==> (result ==> (x == 1 || exists k: int :: k > 0 && power_of(n, k) == x))
{
    // Handle edge cases first
    if n == 1 {
        return x == 1;
    }
    
    if n == 0 {
        return x == 0;
    }
    
    if x == 1 {
        return true; // n^0 = 1 for any n != 0
    }
    
    if x == 0 {
        return false; // n^k = 0 only when n = 0, handled above
    }
    
    // Special case for n = -1: (-1)^k = 1 if k even, -1 if k odd
    if n == -1 {
        return x == 1 || x == -1;
    }
    
    // For |n| > 1, we check powers iteratively
    if n > 1 {
        if x < 0 {
            return false; // positive n raised to any power cannot give negative result
        }
        
        // Check positive powers: n^1, n^2, n^3, ...
        var power: int := n;
        while power < x
            decreases x - power
        {
            // Avoid overflow by checking if power * n would exceed x
            if power > x / n {
                return false;
            }
            power := power * n;
        }
        return power == x;
    }
    
    if n < -1 {
        // For negative n < -1, check both positive and negative powers
        var abs_n: int := -n;
        var power: int := 1;  // Start with n^0 = 1
        var k: int := 0;
        
        // Check n^0 = 1 (already handled above if x == 1)
        
        // Check increasing powers
        while power < abs(x) && k < 64  // Limit iterations to prevent infinite loops
            decreases 64 - k
        {
            k := k + 1;
            if power > abs(x) / abs_n {
                break; // Would overflow
            }
            power := power * abs_n;
            
            // Check if this power equals x (considering sign based on k)
            if k % 2 == 1 {
                // Odd power: n^k is negative
                if -power == x {
                    return true;
                }
            } else {
                // Even power: n^k is positive  
                if power == x {
                    return true;
                }
            }
        }
        return false;
    }
    
    return false;
}

function abs(x: int): int
{
    if x >= 0 then x else -x
}

function power_of(base: int, exp: int): int
    requires exp >= 0
    decreases exp
{
    if exp == 0 then 1
    else base * power_of(base, exp - 1)
}
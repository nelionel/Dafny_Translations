method is_prime(n: int) returns (result: bool)
    ensures result == (n >= 2 && forall k :: 2 <= k < n ==> n % k != 0)
{
    // Numbers less than 2 are not prime
    if n < 2 {
        return false;
    }
    
    // 2 is the only even prime number
    if n == 2 {
        return true;
    }
    
    // All other even numbers are not prime
    if n % 2 == 0 {
        return false;
    }
    
    // Check odd divisors from 3 up to sqrt(n)
    var i := 3;
    while i * i <= n
        invariant i >= 3 && i % 2 == 1
        invariant forall k :: 3 <= k < i && k % 2 == 1 ==> n % k != 0
        decreases n - i * i
    {
        if n % i == 0 {
            return false;
        }
        i := i + 2;
    }
    
    return true;
}
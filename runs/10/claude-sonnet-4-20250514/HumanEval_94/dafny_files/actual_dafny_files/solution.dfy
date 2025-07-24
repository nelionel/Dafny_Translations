method skjkasdkd(lst: seq<int>) returns (result: int)
    ensures result >= 0
    ensures (forall x :: x in lst ==> !is_prime(x)) ==> result == 0
    ensures (exists x :: x in lst && is_prime(x)) ==> 
        exists largest :: largest in lst && is_prime(largest) && 
        (forall y :: y in lst && is_prime(y) ==> y <= largest) &&
        result == sum_of_digits(largest)
{
    // Find all primes in the list
    var primes := [];
    var i := 0;
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant forall j :: 0 <= j < |primes| ==> is_prime(primes[j])
    {
        if is_prime(lst[i]) {
            primes := primes + [lst[i]];
        }
        i := i + 1;
    }
    
    if |primes| == 0 {
        result := 0;
    } else {
        // Find the largest prime
        var largest := primes[0];
        var j := 1;
        while j < |primes|
            invariant 1 <= j <= |primes|
            invariant largest in primes
            invariant forall k :: 0 <= k < j ==> primes[k] <= largest
        {
            if primes[j] > largest {
                largest := primes[j];
            }
            j := j + 1;
        }
        
        result := sum_of_digits(largest);
    }
}

function is_prime(n: int): bool
{
    if n < 2 then false
    else if n == 2 then true
    else if n % 2 == 0 then false
    else has_no_odd_divisors(n, 3)
}

function has_no_odd_divisors(n: int, candidate: int): bool
    requires n >= 3
    requires candidate >= 3 && candidate % 2 == 1
    decreases if candidate * candidate <= n then n - candidate * candidate + 1 else 0
{
    if candidate * candidate > n then true
    else if n % candidate == 0 then false
    else has_no_odd_divisors(n, candidate + 2)
}

function sum_of_digits(n: int): int
    requires n >= 0
    decreases n
{
    if n < 10 then n
    else (n % 10) + sum_of_digits(n / 10)
}
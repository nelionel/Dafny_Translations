method get_max_triples(n: int) returns (result: int)
    requires n > 0
    ensures result >= 0
    ensures n == 1 ==> result == 0
    ensures n == 2 ==> result == 0
    ensures result == combination(count_elements_mod_0(n), 3) + combination(count_elements_mod_1(n), 3)
{
    // Count elements by their remainder when divided by 3
    var count_0 := 0; // count of elements ≡ 0 (mod 3)
    var count_1 := 0; // count of elements ≡ 1 (mod 3)
    
    var i := 1;
    while i <= n
        invariant 1 <= i <= n + 1
        invariant count_0 >= 0 && count_1 >= 0
        invariant count_0 + count_1 == i - 1
        invariant count_0 == count_elements_mod_0_range(1, i - 1)
        invariant count_1 == count_elements_mod_1_range(1, i - 1)
        decreases n - i
    {
        if i % 3 == 2 {
            // i ≡ 2 (mod 3) -> a[i] ≡ 0 (mod 3)
            count_0 := count_0 + 1;
        } else {
            // i ≡ 0,1 (mod 3) -> a[i] ≡ 1 (mod 3)
            count_1 := count_1 + 1;
        }
        i := i + 1;
    }
    
    // Calculate C(count_0, 3) + C(count_1, 3)
    var triples_0 := combination(count_0, 3);
    var triples_1 := combination(count_1, 3);
    
    result := triples_0 + triples_1;
}

function count_elements_mod_0(n: int): int
    requires n >= 0
    ensures count_elements_mod_0(n) >= 0
    ensures count_elements_mod_0(n) <= n
{
    count_elements_mod_0_range(1, n)
}

function count_elements_mod_1(n: int): int
    requires n >= 0
    ensures count_elements_mod_1(n) >= 0
    ensures count_elements_mod_1(n) <= n
    ensures count_elements_mod_0(n) + count_elements_mod_1(n) == n
{
    n - count_elements_mod_0(n)
}

function count_elements_mod_0_range(start: int, end: int): int
    requires start <= end + 1
    ensures count_elements_mod_0_range(start, end) >= 0
{
    if start > end then 0
    else if start % 3 == 2 then 1 + count_elements_mod_0_range(start + 1, end)
    else count_elements_mod_0_range(start + 1, end)
}

function count_elements_mod_1_range(start: int, end: int): int
    requires start <= end + 1
    ensures count_elements_mod_1_range(start, end) >= 0
{
    if start > end then 0
    else if start % 3 != 2 then 1 + count_elements_mod_1_range(start + 1, end)
    else count_elements_mod_1_range(start + 1, end)
}

method combination(n: int, k: int) returns (result: int)
    requires n >= 0 && k >= 0
    ensures result >= 0
    ensures k > n ==> result == 0
    ensures k == 0 ==> result == 1
    ensures k == n && n >= 0 ==> result == 1
    ensures n >= 1 && k == 1 ==> result == n
    ensures n >= 2 && k == 2 ==> result == n * (n - 1) / 2
    ensures n >= 3 && k == 3 ==> result == n * (n - 1) * (n - 2) / 6
{
    if k > n || k < 0 {
        result := 0;
        return;
    }
    
    if k == 0 || k == n {
        result := 1;
        return;
    }
    
    // Calculate C(n, k) = n! / (k! * (n-k)!)
    // Use the optimized approach: C(n, k) = C(n, min(k, n-k))
    var actual_k := if k <= n - k then k else n - k;
    
    result := 1;
    var i := 0;
    
    while i < actual_k
        invariant 0 <= i <= actual_k
        invariant result > 0
        decreases actual_k - i
    {
        result := result * (n - i) / (i + 1);
        i := i + 1;
    }
}
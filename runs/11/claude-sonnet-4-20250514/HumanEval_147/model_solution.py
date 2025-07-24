def get_max_triples(n):
    """
    You are given a positive integer n. You have to create an integer array a of length n.
        For each i (1 ≤ i ≤ n), the value of a[i] = i * i - i + 1.
        Return the number of triples (a[i], a[j], a[k]) of a where i < j < k, 
    and a[i] + a[j] + a[k] is a multiple of 3.
    """
    # Count elements by their remainder when divided by 3
    count_mod = [0, 0, 0]  # count_mod[r] = number of elements ≡ r (mod 3)
    
    for i in range(1, n + 1):
        val = i * i - i + 1
        count_mod[val % 3] += 1
    
    # For sum to be divisible by 3, we need:
    # Case 1: All three numbers ≡ 0 (mod 3) -> C(count_mod[0], 3)
    # Case 2: All three numbers ≡ 1 (mod 3) -> C(count_mod[1], 3)  
    # Case 3: All three numbers ≡ 2 (mod 3) -> C(count_mod[2], 3)
    # Case 4: One each of 0, 1, 2 (mod 3) -> count_mod[0] * count_mod[1] * count_mod[2]
    
    def combination(n, r):
        if n < r or r < 0:
            return 0
        if r == 0 or r == n:
            return 1
        # C(n,3) = n * (n-1) * (n-2) / 6
        if r == 3:
            return n * (n - 1) * (n - 2) // 6
        return 0
    
    result = 0
    
    # Case 1: Three numbers all ≡ 0 (mod 3)
    result += combination(count_mod[0], 3)
    
    # Case 2: Three numbers all ≡ 1 (mod 3)
    result += combination(count_mod[1], 3)
    
    # Case 3: Three numbers all ≡ 2 (mod 3)
    result += combination(count_mod[2], 3)
    
    # Case 4: One each of remainders 0, 1, 2
    result += count_mod[0] * count_mod[1] * count_mod[2]
    
    return result
def get_max_triples(n):
    """
    You are given a positive integer n. You have to create an integer array a of length n.
        For each i (1 ≤ i ≤ n), the value of a[i] = i * i - i + 1.
        Return the number of triples (a[i], a[j], a[k]) of a where i < j < k, 
    and a[i] + a[j] + a[k] is a multiple of 3.
    """
    # Create the array
    a = []
    for i in range(1, n + 1):
        a.append(i * i - i + 1)
    
    # Count elements by their remainder when divided by 3
    # Based on the pattern: i*i - i + 1 ≡ 1 (mod 3) when i ≡ 0,1 (mod 3)
    #                                  ≡ 0 (mod 3) when i ≡ 2 (mod 3)
    count_0 = 0  # count of elements ≡ 0 (mod 3)
    count_1 = 0  # count of elements ≡ 1 (mod 3)
    
    for i in range(1, n + 1):
        if i % 3 == 2:  # i ≡ 2 (mod 3) -> a[i] ≡ 0 (mod 3)
            count_0 += 1
        else:  # i ≡ 0,1 (mod 3) -> a[i] ≡ 1 (mod 3)
            count_1 += 1
    
    # Count valid triples
    # Case 1: Three elements ≡ 0 (mod 3) -> C(count_0, 3)
    # Case 2: Three elements ≡ 1 (mod 3) -> C(count_1, 3)
    
    def combination(n, k):
        if k > n or k < 0:
            return 0
        if k == 0 or k == n:
            return 1
        
        # Calculate C(n, k) = n! / (k! * (n-k)!)
        result = 1
        for i in range(min(k, n - k)):
            result = result * (n - i) // (i + 1)
        return result
    
    triples_0 = combination(count_0, 3)
    triples_1 = combination(count_1, 3)
    
    return triples_0 + triples_1
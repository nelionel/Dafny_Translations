def intersection(interval1, interval2):
    """You are given two intervals,
    where each interval is a pair of integers. For example, interval = (start, end) = (1, 2).
    The given intervals are closed which means that the interval (start, end)
    includes both start and end.
    For each given interval, it is assumed that its start is less or equal its end.
    Your task is to determine whether the length of intersection of these two 
    intervals is a prime number.
    Example, the intersection of the intervals (1, 3), (2, 4) is (2, 3)
    which its length is 1, which not a prime number.
    If the length of the intersection is a prime number, return "YES",
    otherwise, return "NO".
    If the two intervals don't intersect, return "NO".
    """
    
    def is_prime(n):
        """Check if a number is prime"""
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                return False
        return True
    
    # Extract start and end points of both intervals
    start1, end1 = interval1
    start2, end2 = interval2
    
    # Find the intersection
    # The intersection starts at the maximum of the two start points
    # and ends at the minimum of the two end points
    intersection_start = max(start1, start2)
    intersection_end = min(end1, end2)
    
    # Check if there's actually an intersection
    if intersection_start > intersection_end:
        return "NO"
    
    # Calculate the length of the intersection
    # Since intervals are closed, length = end - start + 1
    intersection_length = intersection_end - intersection_start + 1
    
    # Check if the length is prime
    if is_prime(intersection_length):
        return "YES"
    else:
        return "NO"
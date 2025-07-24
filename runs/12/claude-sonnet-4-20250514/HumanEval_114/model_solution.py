def minSubArraySum(nums):
    """
    Given an array of integers nums, find the minimum sum of any non-empty sub-array
    of nums.
    Example
    minSubArraySum([2, 3, 4, 1, 2, 4]) == 1
    minSubArraySum([-1, -2, -3]) == -6
    """
    if not nums:
        return 0
    
    # Initialize with the first element
    min_ending_here = nums[0]
    min_so_far = nums[0]
    
    # Iterate through the rest of the array
    for i in range(1, len(nums)):
        # At each position, we can either:
        # 1. Start a new subarray from current element
        # 2. Extend the previous subarray by including current element
        # We choose the option that gives us the smaller sum
        min_ending_here = min(nums[i], min_ending_here + nums[i])
        
        # Update the global minimum if we found a smaller sum
        min_so_far = min(min_so_far, min_ending_here)
    
    return min_so_far
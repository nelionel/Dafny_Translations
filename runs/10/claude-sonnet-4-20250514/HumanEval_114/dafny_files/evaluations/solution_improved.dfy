method minSubArraySum(nums: seq<int>) returns (result: int)
    requires |nums| >= 0
    ensures |nums| == 0 ==> result == 0
    ensures |nums| > 0 ==> (exists i, j :: 0 <= i <= j < |nums| && result == sum(nums[i..j+1]))
    ensures |nums| > 0 ==> (forall i, j :: 0 <= i <= j < |nums| ==> result <= sum(nums[i..j+1]))
{
    if |nums| == 0 {
        return 0;
    }
    
    if |nums| == 1 {
        return nums[0];
    }
    
    var min_ending_here := nums[0];
    var min_so_far := nums[0];
    var i := 1;
    
    while i < |nums|
        invariant 1 <= i <= |nums|
        invariant min_so_far <= nums[0]
        invariant forall j :: 0 <= j < i ==> min_so_far <= nums[j]
        invariant min_ending_here <= min_so_far
        decreases |nums| - i
    {
        // Either extend the existing subarray or start a new one
        if nums[i] < min_ending_here + nums[i] {
            min_ending_here := nums[i];
        } else {
            min_ending_here := min_ending_here + nums[i];
        }
        
        // Update the overall minimum
        if min_ending_here < min_so_far {
            min_so_far := min_ending_here;
        }
        
        i := i + 1;
    }
    
    result := min_so_far;
}

function sum(s: seq<int>): int {
    if |s| == 0 then 0
    else s[0] + sum(s[1..])
}
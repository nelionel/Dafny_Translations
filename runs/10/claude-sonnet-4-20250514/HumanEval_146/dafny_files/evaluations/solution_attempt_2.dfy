method specialFilter(nums: seq<int>) returns (result: int)
    ensures result >= 0
    ensures result <= |nums|
    ensures result == |set i | 0 <= i < |nums| && nums[i] > 10 && isOdd(getFirstDigit(nums[i])) && isOdd(nums[i] % 10)|
{
    var count := 0;
    var i := 0;
    
    while i < |nums|
        invariant 0 <= i <= |nums|
        invariant count >= 0
        invariant count <= i
        invariant count == |set j | 0 <= j < i && nums[j] > 10 && isOdd(getFirstDigit(nums[j])) && isOdd(nums[j] % 10)|
    {
        if nums[i] > 10 {
            var firstDigit := getFirstDigit(nums[i]);
            var lastDigit := nums[i] % 10;
            
            if isOdd(firstDigit) && isOdd(lastDigit) {
                count := count + 1;
            }
        }
        i := i + 1;
    }
    
    result := count;
}

function isOdd(digit: int): bool
{
    digit == 1 || digit == 3 || digit == 5 || digit == 7 || digit == 9
}

function getFirstDigit(num: int): int
    requires num > 0
    decreases num
{
    if num < 10 then num
    else getFirstDigit(num / 10)
}
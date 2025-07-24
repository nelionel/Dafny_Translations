method specialFilter(nums: seq<int>) returns (result: int)
    ensures result >= 0
    ensures result <= |nums|
{
    var count := 0;
    var i := 0;
    
    while i < |nums|
        invariant 0 <= i <= |nums|
        invariant count >= 0
        invariant count <= i
    {
        if nums[i] > 10 {
            var absNum := if nums[i] < 0 then -nums[i] else nums[i];
            var firstDigit := getFirstDigit(absNum);
            var lastDigit := absNum % 10;
            
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
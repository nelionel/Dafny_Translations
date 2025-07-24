method eat(number: int, need: int, remaining: int) returns (result: seq<int>)
    requires 0 <= number <= 1000
    requires 0 <= need <= 1000  
    requires 0 <= remaining <= 1000
    ensures |result| == 2
    ensures result[0] == number + (if need <= remaining then need else remaining)
    ensures result[1] == remaining - (if need <= remaining then need else remaining)
    ensures result[0] >= number
    ensures result[1] >= 0
    ensures result[1] <= remaining
{
    // Calculate how many carrots can actually be eaten
    // This is the minimum of what we need and what's available
    var can_eat := if need <= remaining then need else remaining;
    
    // Calculate total carrots eaten (already eaten + what we can eat now)
    var total_eaten := number + can_eat;
    
    // Calculate carrots left after eating
    var carrots_left := remaining - can_eat;
    
    result := [total_eaten, carrots_left];
}
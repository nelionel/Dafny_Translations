method prod_signs(arr: seq<int>) returns (result: Option<int>)
    ensures |arr| == 0 ==> result.None?
    ensures |arr| > 0 ==> result.Some? && result.value == sum_of_magnitudes(arr) * product_of_signs(arr)
{
    if |arr| == 0 {
        return None;
    }
    
    var sum_of_magnitudes := 0;
    var product_of_signs := 1;
    var i := 0;
    
    while i < |arr|
        invariant 0 <= i <= |arr|
        invariant sum_of_magnitudes == sum_magnitudes_up_to(arr, i)
        invariant product_of_signs == product_signs_up_to(arr, i)
        decreases |arr| - i
    {
        // Add absolute value to sum
        sum_of_magnitudes := sum_of_magnitudes + (if arr[i] >= 0 then arr[i] else -arr[i]);
        
        // Multiply by sign
        if arr[i] > 0 {
            product_of_signs := product_of_signs * 1;
        } else if arr[i] < 0 {
            product_of_signs := product_of_signs * (-1);
        } else {
            product_of_signs := product_of_signs * 0;
        }
        
        i := i + 1;
    }
    
    result := Some(sum_of_magnitudes * product_of_signs);
}

// Helper function to compute sum of magnitudes
function sum_of_magnitudes(arr: seq<int>): int
{
    if |arr| == 0 then 0
    else (if arr[0] >= 0 then arr[0] else -arr[0]) + sum_of_magnitudes(arr[1..])
}

// Helper function to compute product of signs
function product_of_signs(arr: seq<int>): int
{
    if |arr| == 0 then 1
    else sign(arr[0]) * product_of_signs(arr[1..])
}

// Helper function to get sign of a number
function sign(x: int): int
{
    if x > 0 then 1
    else if x < 0 then -1
    else 0
}

// Helper function for loop invariant - sum of magnitudes up to index i
function sum_magnitudes_up_to(arr: seq<int>, i: int): int
    requires 0 <= i <= |arr|
{
    if i == 0 then 0
    else sum_magnitudes_up_to(arr, i-1) + (if arr[i-1] >= 0 then arr[i-1] else -arr[i-1])
}

// Helper function for loop invariant - product of signs up to index i
function product_signs_up_to(arr: seq<int>, i: int): int
    requires 0 <= i <= |arr|
{
    if i == 0 then 1
    else product_signs_up_to(arr, i-1) * sign(arr[i-1])
}
method sum_seq(numbers: seq<real>) returns (result: real)
    decreases numbers
{
    if |numbers| == 0 {
        result := 0.0;
    } else {
        var rest_sum := sum_seq(numbers[1..]);
        result := numbers[0] + rest_sum;
    }
}

method abs_real(x: real) returns (result: real)
    ensures result >= 0.0
    ensures result == x || result == -x
{
    if x >= 0.0 {
        result := x;
    } else {
        result := -x;
    }
}

method calculate_deviations(numbers: seq<real>, mean_val: real) returns (deviations: seq<real>)
    ensures |deviations| == |numbers|
    decreases numbers
{
    if |numbers| == 0 {
        deviations := [];
    } else {
        var abs_diff := abs_real(numbers[0] - mean_val);
        var rest_deviations := calculate_deviations(numbers[1..], mean_val);
        deviations := [abs_diff] + rest_deviations;
    }
}

method mean_absolute_deviation(numbers: seq<real>) returns (result: real)
    requires |numbers| > 0
    ensures result >= 0.0
{
    // Calculate the mean of the numbers
    var total := sum_seq(numbers);
    var mean_val := total / (|numbers| as real);
    
    // Calculate the absolute deviations from the mean
    var absolute_deviations := calculate_deviations(numbers, mean_val);
    
    // Calculate the sum of absolute deviations
    var deviations_sum := sum_seq(absolute_deviations);
    
    // Return the mean of the absolute deviations
    result := deviations_sum / (|absolute_deviations| as real);
}
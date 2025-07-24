function min_seq(numbers: seq<real>): real
  requires |numbers| > 0
  decreases numbers
{
  if |numbers| == 1 then 
    numbers[0]
  else 
    var rest_min := min_seq(numbers[1..]);
    if numbers[0] <= rest_min then numbers[0] else rest_min
}

function max_seq(numbers: seq<real>): real
  requires |numbers| > 0
  decreases numbers
{
  if |numbers| == 1 then 
    numbers[0]
  else 
    var rest_max := max_seq(numbers[1..]);
    if numbers[0] >= rest_max then numbers[0] else rest_max
}

lemma min_seq_property(numbers: seq<real>)
  requires |numbers| > 0
  ensures forall i :: 0 <= i < |numbers| ==> min_seq(numbers) <= numbers[i]
  decreases numbers
{
  if |numbers| == 1 {
    // Base case: trivially true
  } else {
    min_seq_property(numbers[1..]);
  }
}

lemma max_seq_property(numbers: seq<real>)
  requires |numbers| > 0
  ensures forall i :: 0 <= i < |numbers| ==> numbers[i] <= max_seq(numbers)
  decreases numbers
{
  if |numbers| == 1 {
    // Base case: trivially true
  } else {
    max_seq_property(numbers[1..]);
  }
}

method rescale_to_unit(numbers: seq<real>) returns (result: seq<real>)
  requires |numbers| >= 2
  ensures |result| == |numbers|
  ensures forall i :: 0 <= i < |result| ==> 0.0 <= result[i] <= 1.0
  ensures var min_val := min_seq(numbers);
          var max_val := max_seq(numbers);
          if min_val == max_val then
            forall i :: 0 <= i < |result| ==> result[i] == 0.0
          else
            (exists i :: 0 <= i < |numbers| && numbers[i] == min_val ==> result[i] == 0.0) &&
            (exists j :: 0 <= j < |numbers| && numbers[j] == max_val ==> result[j] == 1.0) &&
            (forall k :: 0 <= k < |numbers| ==> result[k] == (numbers[k] - min_val) / (max_val - min_val))
{
  var min_val := min_seq(numbers);
  var max_val := max_seq(numbers);
  
  min_seq_property(numbers);
  max_seq_property(numbers);
  
  if min_val == max_val {
    // All numbers are the same
    result := seq(|numbers|, i => 0.0);
  } else {
    var range_val := max_val - min_val;
    result := seq(|numbers|, i => (numbers[i] - min_val) / range_val);
    
    // The postcondition about bounds follows from:
    // - min_val <= numbers[i] <= max_val for all i
    // - So 0.0 <= (numbers[i] - min_val) <= range_val
    // - So 0.0 <= (numbers[i] - min_val) / range_val <= 1.0
  }
}
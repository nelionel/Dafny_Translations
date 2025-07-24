method generate_integers(a: int, b: int) returns (result: seq<int>)
  requires a > 0 && b > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] % 2 == 0
  ensures forall i :: 0 <= i < |result| ==> (if a <= b then a else b) <= result[i] <= (if a <= b then b else a)
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] < result[j]
  ensures |result| <= 5
  ensures forall i :: 0 <= i < |result| ==> result[i] in {0, 2, 4, 6, 8}
  ensures forall digit :: digit in {0, 2, 4, 6, 8} && (if a <= b then a else b) <= digit <= (if a <= b then b else a) ==> digit in result
{
  var min_val := if a <= b then a else b;
  var max_val := if a <= b then b else a;
  
  var even_digits := [0, 2, 4, 6, 8];
  result := [];
  
  var i := 0;
  while i < |even_digits|
    invariant 0 <= i <= |even_digits|
    invariant forall j :: 0 <= j < |result| ==> result[j] % 2 == 0
    invariant forall j :: 0 <= j < |result| ==> min_val <= result[j] <= max_val
    invariant forall j, k :: 0 <= j < k < |result| ==> result[j] < result[k]
    invariant |result| <= i
  {
    if min_val <= even_digits[i] <= max_val {
      result := result + [even_digits[i]];
    }
    i := i + 1;
  }
}
datatype Value = IntValue(i: int) | RealValue(r: real) | StringValue(s: string) | BoolValue(b: bool)

method filter_integers(values: seq<Value>) returns (result: seq<int>)
  ensures forall x :: x in result ==> exists i :: 0 <= i < |values| && values[i].IntValue? && values[i].i == x
  ensures forall i :: 0 <= i < |values| && values[i].IntValue? ==> values[i].i in result
  ensures |result| <= |values|
{
  result := [];
  var i := 0;
  
  while i < |values|
    invariant 0 <= i <= |values|
    invariant forall x :: x in result ==> exists j :: 0 <= j < i && values[j].IntValue? && values[j].i == x
    invariant forall j :: 0 <= j < i && values[j].IntValue? ==> values[j].i in result
    decreases |values| - i
  {
    if values[i].IntValue? {
      result := result + [values[i].i];
    }
    i := i + 1;
  }
}
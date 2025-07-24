method tri(n: int) returns (result: seq<int>)
  requires n >= 0
  ensures |result| == n + 1
  ensures result[0] == 1
  ensures n >= 1 ==> result[1] == 3
  ensures forall i :: 0 <= i <= n && i % 2 == 0 && i >= 2 ==> result[i] == 1 + i / 2
  ensures forall i :: 0 <= i <= n && i % 2 == 1 && i >= 3 && i < n ==> result[i] == result[i-1] + result[i-2] + result[i+1]
  ensures n % 2 == 1 && n >= 3 ==> result[n] == result[n-1] + result[n-2] + (1 + (n+1) / 2)
{
  if n == 0 {
    return [1];
  }
  
  // Initialize the result array
  var arr := new int[n + 1];
  
  // Base cases
  arr[0] := 1;  // tri(0) = 1
  if n >= 1 {
    arr[1] := 3;  // tri(1) = 3
  }
  
  // Calculate even positions first (they don't depend on odd positions)
  var i := 2;
  while i <= n
    invariant 2 <= i <= n + 1
    invariant arr[0] == 1
    invariant n >= 1 ==> arr[1] == 3
    invariant forall j :: 0 <= j < i && j % 2 == 0 && j >= 2 ==> arr[j] == 1 + j / 2
  {
    if i % 2 == 0 {
      arr[i] := 1 + i / 2;
    }
    i := i + 1;
  }
  
  // Calculate odd positions (they depend on even positions and previous odd positions)
  i := 3;
  while i <= n
    invariant 3 <= i <= n + 1
    invariant arr[0] == 1
    invariant n >= 1 ==> arr[1] == 3
    invariant forall j :: 0 <= j <= n && j % 2 == 0 && j >= 2 ==> arr[j] == 1 + j / 2
    invariant forall j :: 1 <= j < i && j % 2 == 1 && j >= 3 ==> arr[j] == arr[j-1] + arr[j-2] + arr[j+1]
  {
    if i % 2 == 1 {
      arr[i] := arr[i - 1] + arr[i - 2] + arr[i + 1];
    }
    i := i + 1;
  }
  
  // Convert array to sequence
  result := arr[..];
}
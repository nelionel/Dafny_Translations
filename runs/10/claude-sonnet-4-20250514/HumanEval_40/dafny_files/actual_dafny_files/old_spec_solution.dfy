method triples_sum_to_zero(l: seq<int>) returns (result: bool)
  ensures result <==> exists i, j, k :: 0 <= i < j < k < |l| && l[i] + l[j] + l[k] == 0
{
  if |l| < 3 {
    return false;
  }
  
  var i := 0;
  while i < |l|
    invariant 0 <= i <= |l|
    invariant forall x, y, z :: 0 <= x < y < z < |l| && x < i ==> l[x] + l[y] + l[z] != 0
  {
    var j := i + 1;
    while j < |l|
      invariant i + 1 <= j <= |l|
      invariant forall x, y, z :: 0 <= x < y < z < |l| && (x < i || (x == i && y < j)) ==> l[x] + l[y] + l[z] != 0
    {
      var k := j + 1;
      while k < |l|
        invariant j + 1 <= k <= |l|
        invariant forall x, y, z :: 0 <= x < y < z < |l| && (x < i || (x == i && y < j) || (x == i && y == j && z < k)) ==> l[x] + l[y] + l[z] != 0
      {
        if l[i] + l[j] + l[k] == 0 {
          return true;
        }
        k := k + 1;
      }
      j := j + 1;
    }
    i := i + 1;
  }
  
  return false;
}
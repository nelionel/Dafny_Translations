function is_prime(num: int): bool
  requires num >= 0
{
  if num < 2 then false
  else if num == 2 then true
  else if num % 2 == 0 then false
  else is_prime_odd_helper(num, 3)
}

function is_prime_odd_helper(num: int, divisor: int): bool
  requires num >= 3
  requires divisor >= 3
  requires divisor % 2 == 1
  decreases num - divisor
{
  if divisor * divisor > num then true
  else if num % divisor == 0 then false
  else is_prime_odd_helper(num, divisor + 2)
}

method count_up_to(n: int) returns (result: seq<int>)
  requires n >= 0
  ensures forall i :: 0 <= i < |result| ==> is_prime(result[i])
  ensures forall i :: 0 <= i < |result| ==> result[i] < n
  ensures forall i :: 0 <= i < |result| ==> result[i] >= 2
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] < result[j]
  ensures forall p :: 2 <= p < n && is_prime(p) ==> p in result
{
  result := [];
  
  if n <= 2 {
    return;
  }
  
  var i := 2;
  while i < n
    invariant 2 <= i <= n
    invariant forall k :: 0 <= k < |result| ==> is_prime(result[k])
    invariant forall k :: 0 <= k < |result| ==> result[k] < i
    invariant forall k :: 0 <= k < |result| ==> result[k] >= 2
    invariant forall j, k :: 0 <= j < k < |result| ==> result[j] < result[k]
    invariant forall p :: 2 <= p < i && is_prime(p) ==> p in result
  {
    if is_prime(i) {
      result := result + [i];
    }
    i := i + 1;
  }
}
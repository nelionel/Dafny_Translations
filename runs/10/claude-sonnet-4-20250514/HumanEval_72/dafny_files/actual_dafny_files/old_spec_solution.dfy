method will_it_fly(q: seq<int>, w: int) returns (result: bool)
  ensures result == (IsPalindrome(q) && Sum(q) <= w)
{
    var is_balanced := IsPalindrome(q);
    var is_within_weight := Sum(q) <= w;
    result := is_balanced && is_within_weight;
}

function IsPalindrome(s: seq<int>): bool
{
    s == Reverse(s)
}

function Reverse(s: seq<int>): seq<int>
  decreases |s|
{
    if |s| == 0 then []
    else [s[|s|-1]] + Reverse(s[..|s|-1])
}

function Sum(s: seq<int>): int
  decreases |s|
{
    if |s| == 0 then 0
    else s[0] + Sum(s[1..])
}
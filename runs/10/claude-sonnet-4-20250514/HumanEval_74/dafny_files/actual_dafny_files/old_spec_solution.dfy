function TotalChars(lst: seq<string>): nat
    decreases lst
{
    if |lst| == 0 then 0
    else |lst[0]| + TotalChars(lst[1..])
}

method total_match(lst1: seq<string>, lst2: seq<string>) returns (result: seq<string>)
    ensures result == lst1 || result == lst2
    ensures TotalChars(lst1) <= TotalChars(lst2) ==> result == lst1
    ensures TotalChars(lst1) > TotalChars(lst2) ==> result == lst2
{
    var total1 := TotalChars(lst1);
    var total2 := TotalChars(lst2);
    
    if total1 <= total2 {
        result := lst1;
    } else {
        result := lst2;
    }
}
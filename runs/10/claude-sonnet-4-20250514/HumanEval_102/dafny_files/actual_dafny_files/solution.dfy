method choose_num(x: int, y: int) returns (result: int)
    requires x > 0 && y > 0
    ensures result == -1 <==> (x > y || (forall i :: x <= i <= y ==> i % 2 != 0))
    ensures result != -1 ==> (result % 2 == 0 && x <= result <= y)
    ensures result != -1 ==> (forall i :: x <= i <= y && i % 2 == 0 ==> i <= result)
{
    if x > y {
        result := -1;
    } else if y % 2 == 0 {
        result := y;
    } else if y - 1 >= x {
        result := y - 1;
    } else {
        result := -1;
    }
}
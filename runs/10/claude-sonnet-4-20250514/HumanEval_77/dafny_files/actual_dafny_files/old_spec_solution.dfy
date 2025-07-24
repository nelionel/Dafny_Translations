method iscube(a: int) returns (result: bool)
    ensures result <==> exists x :: x * x * x == a
{
    if a == 0 {
        return true;
    }
    
    if a > 0 {
        var x := 1;
        while x * x * x < a
            invariant x >= 1
            invariant forall y :: 1 <= y < x ==> y * y * y != a
            invariant x * x * x <= a ==> x <= a  // bound to ensure termination
            decreases if x * x * x <= a then a - x * x * x else 0
        {
            x := x + 1;
        }
        return x * x * x == a;
    } else {
        // a < 0
        var x := -1;
        while x * x * x > a
            invariant x <= -1  
            invariant forall y :: x < y <= -1 ==> y * y * y != a
            invariant x * x * x >= a ==> x >= a  // bound to ensure termination
            decreases if x * x * x >= a then x * x * x - a else 0
        {
            x := x - 1;
        }
        return x * x * x == a;
    }
}
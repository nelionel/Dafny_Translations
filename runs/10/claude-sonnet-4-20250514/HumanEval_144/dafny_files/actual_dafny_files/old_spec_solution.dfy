method findSlashIndex(s: string) returns (index: int)
    requires |s| > 0
    requires exists i :: 0 <= i < |s| && s[i] == '/'
    ensures 0 <= index < |s|
    ensures s[index] == '/'
{
    index := 0;
    while index < |s|
        invariant 0 <= index <= |s|
        invariant forall k :: 0 <= k < index ==> s[k] != '/'
        decreases |s| - index
    {
        if s[index] == '/' {
            return;
        }
        index := index + 1;
    }
}

method stringToInt(s: string) returns (value: int)
    requires |s| > 0
    requires forall i :: 0 <= i < |s| ==> '0' <= s[i] <= '9'
    ensures value >= 0
{
    value := 0;
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant value >= 0
        decreases |s| - i
    {
        var digit := s[i] as int - '0' as int;
        value := value * 10 + digit;
        i := i + 1;
    }
}

method simplify(x: string, n: string) returns (result: bool)
    requires |x| >= 3 && |n| >= 3  // minimum "a/b"
    requires exists i :: 0 < i < |x| - 1 && x[i] == '/'
    requires exists j :: 0 < j < |n| - 1 && n[j] == '/'
    requires forall i :: 0 <= i < |x| ==> (x[i] == '/' || ('0' <= x[i] <= '9'))
    requires forall i :: 0 <= i < |n| ==> (n[i] == '/' || ('0' <= n[i] <= '9'))
    // Ensure exactly one slash in each string
    requires (count_char(x, '/') == 1)
    requires (count_char(n, '/') == 1)
{
    // Find slash positions
    var x_slash := findSlashIndex(x);
    var n_slash := findSlashIndex(n);
    
    // Extract numerator and denominator strings
    var x_num_str := x[0..x_slash];
    var x_den_str := x[x_slash+1..];
    var n_num_str := n[0..n_slash];
    var n_den_str := n[n_slash+1..];
    
    // Convert to integers
    var x_num := stringToInt(x_num_str);
    var x_den := stringToInt(x_den_str);
    var n_num := stringToInt(n_num_str);
    var n_den := stringToInt(n_den_str);
    
    // Multiply fractions: (x_num/x_den) * (n_num/n_den) = (x_num * n_num) / (x_den * n_den)
    var result_num := x_num * n_num;
    var result_den := x_den * n_den;
    
    // Check if result is a whole number
    result := result_num % result_den == 0;
}

function count_char(s: string, c: char): int
{
    if |s| == 0 then 0
    else (if s[0] == c then 1 else 0) + count_char(s[1..], c)
}
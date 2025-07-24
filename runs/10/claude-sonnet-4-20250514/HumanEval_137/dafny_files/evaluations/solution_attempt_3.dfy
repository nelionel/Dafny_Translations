datatype Value = IntVal(i: int) | RealVal(r: real) | StringVal(s: string)

method compare_one(a: Value, b: Value) returns (result: Value?)
  ensures var num_a := value_to_real(a);
          var num_b := value_to_real(b);
          (num_a > num_b ==> result == Some(a)) &&
          (num_b > num_a ==> result == Some(b)) &&
          (num_a == num_b ==> result == None)
{
  var num_a := convert_value_to_real(a);
  var num_b := convert_value_to_real(b);
  
  if num_a > num_b {
    result := Some(a);
  } else if num_b > num_a {
    result := Some(b);
  } else {
    result := None;
  }
}

function value_to_real(v: Value): real
{
  match v
  case IntVal(i) => i as real
  case RealVal(r) => r
  case StringVal(s) => if |s| > 0 then string_to_real_value(s) else 0.0
}

method convert_value_to_real(v: Value) returns (r: real)
  ensures r == value_to_real(v)
{
  match v
  case IntVal(i) => r := i as real;
  case RealVal(real_val) => r := real_val;
  case StringVal(s) => 
    if |s| > 0 {
      r := string_to_real(s);
    } else {
      r := 0.0;
    }
}

function string_to_real_value(s: string): real
  requires |s| > 0
{
  var normalized := normalize_decimal_separator_func(s);
  parse_decimal_string_func(normalized)
}

function normalize_decimal_separator_func(s: string): string
  requires |s| > 0
  ensures |normalize_decimal_separator_func(s)| == |s|
{
  if |s| == 0 then ""
  else if s[0] == ',' then "." + normalize_decimal_separator_func(s[1..])
  else [s[0]] + normalize_decimal_separator_func(s[1..])
}

function parse_decimal_string_func(s: string): real
  requires |s| > 0
{
  parse_decimal_helper(s, 0, 0.0, 0.0, 0.0, false, false)
}

function parse_decimal_helper(s: string, i: int, integer_part: real, decimal_part: real, decimal_places: real, is_negative: bool, found_decimal: bool): real
  requires 0 <= i <= |s|
  decreases |s| - i
{
  if i >= |s| then
    var result := if decimal_places > 0.0 then
      integer_part + (decimal_part / power_of_ten(decimal_places))
    else
      integer_part;
    if is_negative then -result else result
  else if i == 0 && s[i] == '-' then
    parse_decimal_helper(s, i + 1, integer_part, decimal_part, decimal_places, true, found_decimal)
  else if s[i] == '.' then
    parse_decimal_helper(s, i + 1, integer_part, decimal_part, decimal_places, is_negative, true)
  else if '0' <= s[i] <= '9' then
    var digit_value := (s[i] as int) - ('0' as int);
    if found_decimal then
      parse_decimal_helper(s, i + 1, integer_part, decimal_part * 10.0 + (digit_value as real), decimal_places + 1.0, is_negative, found_decimal)
    else
      parse_decimal_helper(s, i + 1, integer_part * 10.0 + (digit_value as real), decimal_part, decimal_places, is_negative, found_decimal)
  else
    parse_decimal_helper(s, i + 1, integer_part, decimal_part, decimal_places, is_negative, found_decimal)
}

function power_of_ten(n: real): real
  requires n >= 0.0
{
  if n == 0.0 then 1.0
  else 10.0 * power_of_ten(n - 1.0)
}

method string_to_real(s: string) returns (r: real)
  requires |s| > 0
  ensures r == string_to_real_value(s)
{
  var normalized := normalize_decimal_separator(s);
  r := parse_decimal_string(normalized);
}

method normalize_decimal_separator(s: string) returns (normalized: string)
  requires |s| > 0
  ensures |normalized| == |s|
  ensures normalized == normalize_decimal_separator_func(s)
{
  normalized := "";
  var i := 0;
  while i < |s|
    invariant 0 <= i <= |s|
    invariant |normalized| == i
    invariant normalized == normalize_decimal_separator_func(s[..i])
    decreases |s| - i
  {
    if s[i] == ',' {
      normalized := normalized + ".";
    } else {
      normalized := normalized + [s[i]];
    }
    i := i + 1;
  }
}

method parse_decimal_string(s: string) returns (r: real)
  requires |s| > 0
  ensures r == parse_decimal_string_func(s)
{
  var integer_part := 0.0;
  var decimal_part := 0.0;
  var decimal_places := 0.0;
  var is_negative := false;
  var found_decimal := false;
  var i := 0;
  
  if i < |s| && s[i] == '-' {
    is_negative := true;
    i := i + 1;
  }
  
  while i < |s|
    invariant 0 <= i <= |s|
    decreases |s| - i
  {
    if s[i] == '.' {
      found_decimal := true;
    } else if '0' <= s[i] <= '9' {
      var digit_value := (s[i] as int) - ('0' as int);
      if found_decimal {
        decimal_part := decimal_part * 10.0 + (digit_value as real);
        decimal_places := decimal_places + 1.0;
      } else {
        integer_part := integer_part * 10.0 + (digit_value as real);
      }
    }
    i := i + 1;
  }
  
  if decimal_places > 0.0 {
    var divisor := 1.0;
    var places := decimal_places;
    while places > 0.0
      invariant places >= 0.0
      decreases places
    {
      divisor := divisor * 10.0;
      places := places - 1.0;
    }
    r := integer_part + (decimal_part / divisor);
  } else {
    r := integer_part;
  }
  
  if is_negative {
    r := -r;
  }
}
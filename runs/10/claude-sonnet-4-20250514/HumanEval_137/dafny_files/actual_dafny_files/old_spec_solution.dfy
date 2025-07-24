method compare_one(a: string, b: string) returns (result: string)
  requires |a| > 0 && |b| > 0
  ensures result == "" || result == a || result == b
{
  var num_a := string_to_real(a);
  var num_b := string_to_real(b);
  
  if num_a > num_b {
    result := a;
  } else if num_b > num_a {
    result := b;
  } else {
    result := ""; // Empty string instead of None
  }
}

method string_to_real(s: string) returns (r: real)
  requires |s| > 0
{
  // First, normalize comma to dot
  var normalized := normalize_decimal_separator(s);
  
  // Parse the normalized string to real
  r := parse_decimal_string(normalized);
}

method normalize_decimal_separator(s: string) returns (normalized: string)
  requires |s| > 0
  ensures |normalized| == |s|
{
  normalized := "";
  var i := 0;
  while i < |s|
    invariant 0 <= i <= |s|
    invariant |normalized| == i
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
{
  var integer_part := 0.0;
  var decimal_part := 0.0;
  var decimal_places := 0.0;
  var is_negative := false;
  var found_decimal := false;
  var i := 0;
  
  // Handle negative sign
  if i < |s| && s[i] == '-' {
    is_negative := true;
    i := i + 1;
  }
  
  // Parse digits
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
  
  // Combine integer and decimal parts
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
// Helper function to convert a single digit character to integer
function CharToDigit(c: char): int
  requires '0' <= c <= '9'
  ensures 0 <= CharToDigit(c) <= 9
{
  (c as int) - ('0' as int)
}

// Helper function to check if character is a digit
predicate IsDigit(c: char)
{
  '0' <= c <= '9'
}

// Helper function to parse integer part of string
function ParseIntegerPart(s: string, start: int, end: int): int
  requires 0 <= start <= end <= |s|
  requires forall i :: start <= i < end ==> IsDigit(s[i])
  decreases end - start
{
  if start == end then 0
  else ParseIntegerPart(s, start, end - 1) * 10 + CharToDigit(s[end - 1])
}

// Helper function to parse fractional part of string
function ParseFractionalPart(s: string, start: int, end: int): real
  requires 0 <= start <= end <= |s|
  requires forall i :: start <= i < end ==> IsDigit(s[i])
  decreases end - start
{
  if start == end then 0.0
  else (CharToDigit(s[start]) as real) / (Power10(end - start) as real) + ParseFractionalPart(s, start + 1, end)
}

// Helper function to compute powers of 10
function Power10(n: int): int
  requires n >= 0
  decreases n
{
  if n == 0 then 1 else 10 * Power10(n - 1)
}

// Helper function to find decimal point position
function FindDecimalPoint(s: string): int
  ensures -1 <= FindDecimalPoint(s) < |s|
  ensures FindDecimalPoint(s) == -1 ==> forall i :: 0 <= i < |s| ==> s[i] != '.'
  ensures FindDecimalPoint(s) >= 0 ==> s[FindDecimalPoint(s)] == '.'
{
  FindDecimalPointHelper(s, 0)
}

function FindDecimalPointHelper(s: string, pos: int): int
  requires 0 <= pos <= |s|
  decreases |s| - pos
{
  if pos == |s| then -1
  else if s[pos] == '.' then pos
  else FindDecimalPointHelper(s, pos + 1)
}

// Main string to real conversion function
function StringToReal(s: string): real
  requires |s| > 0
  requires s[0] == '-' || IsDigit(s[0]) || s[0] == '.'
  requires forall i :: 1 <= i < |s| ==> IsDigit(s[i]) || s[i] == '.'
{
  var isNegative := s[0] == '-';
  var startPos := if isNegative then 1 else 0;
  var decimalPos := FindDecimalPoint(s);
  
  if decimalPos == -1 then
    // No decimal point, integer only
    var intPart := ParseIntegerPart(s, startPos, |s|);
    if isNegative then -(intPart as real) else (intPart as real)
  else
    // Has decimal point
    var intPart := if decimalPos == startPos then 0 else ParseIntegerPart(s, startPos, decimalPos);
    var fracPart := if decimalPos == |s| - 1 then 0.0 else ParseFractionalPart(s, decimalPos + 1, |s|);
    var result := (intPart as real) + fracPart;
    if isNegative then -result else result
}

// Helper function to get integer part of a real number (truncation towards zero)
function RealToInt(r: real): int
{
  if r >= 0.0 then r.Floor else -(-r).Floor
}

// Helper function to get absolute value of real
function AbsReal(r: real): real
  ensures AbsReal(r) >= 0.0
  ensures AbsReal(r) == r || AbsReal(r) == -r
{
  if r >= 0.0 then r else -r
}

method closest_integer(value: string) returns (result: int)
  requires |value| > 0
  requires value[0] == '-' || IsDigit(value[0]) || value[0] == '.'
  requires forall i :: 1 <= i < |value| ==> IsDigit(value[i]) || value[i] == '.'
{
  // Convert string to real number
  var num := StringToReal(value);
  
  // Get integer part (truncation towards zero)
  var int_part := RealToInt(num);
  
  // Calculate fractional part
  var fractional_part := AbsReal(num - (int_part as real));
  
  // Apply rounding logic
  if fractional_part == 0.5 {
    // Round away from zero
    if num > 0.0 {
      result := int_part + 1;
    } else {
      result := int_part - 1;
    }
  } else if fractional_part > 0.5 {
    // Round away from zero
    if num >= 0.0 {
      result := int_part + 1;
    } else {
      result := int_part - 1;
    }
  } else {
    // Round towards zero (fractional_part < 0.5)
    result := int_part;
  }
}
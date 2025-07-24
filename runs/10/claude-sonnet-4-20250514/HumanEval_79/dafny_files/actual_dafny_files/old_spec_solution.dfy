method decimal_to_binary(decimal: int) returns (result: string)
  ensures |result| >= 4
  ensures result[0..2] == "db"
  ensures result[|result|-2..] == "db"
{
  var binary := int_to_binary(decimal);
  result := "db" + binary + "db";
}

function int_to_binary(n: int): string
  decreases if n >= 0 then n else -n
{
  if n == 0 then "0"
  else if n > 0 then positive_to_binary(n)
  else "-" + positive_to_binary(-n)
}

function positive_to_binary(n: int): string
  requires n > 0
  decreases n
{
  if n == 1 then "1"
  else positive_to_binary(n / 2) + (if n % 2 == 0 then "0" else "1")
}
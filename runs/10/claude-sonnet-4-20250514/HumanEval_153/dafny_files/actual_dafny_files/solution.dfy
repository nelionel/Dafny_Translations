method Strongest_Extension(class_name: string, extensions: seq<string>) returns (result: string)
  requires |extensions| > 0
  ensures |result| > 0
  ensures exists i :: 0 <= i < |extensions| && class_name + "." + extensions[i] == result
  ensures exists i :: 0 <= i < |extensions| && result == class_name + "." + extensions[i] &&
          (forall j :: 0 <= j < |extensions| ==> CalculateStrength(extensions[j]) <= CalculateStrength(extensions[i])) &&
          (forall j :: 0 <= j < i ==> CalculateStrength(extensions[j]) < CalculateStrength(extensions[i]))
{
  var strongest_extension := extensions[0];
  var max_strength := CalculateStrength(extensions[0]);
  
  var i := 1;
  while i < |extensions|
    invariant 0 <= i <= |extensions|
    invariant exists j :: 0 <= j < i && strongest_extension == extensions[j]
    invariant max_strength == CalculateStrength(strongest_extension)
    invariant forall j :: 0 <= j < i ==> CalculateStrength(extensions[j]) <= max_strength
    decreases |extensions| - i
  {
    var current_strength := CalculateStrength(extensions[i]);
    if current_strength > max_strength {
      max_strength := current_strength;
      strongest_extension := extensions[i];
    }
    i := i + 1;
  }
  
  result := class_name + "." + strongest_extension;
}

function CalculateStrength(extension: string): int
{
  CountUppercase(extension) - CountLowercase(extension)
}

function CountUppercase(s: string): int
  decreases |s|
{
  if |s| == 0 then 0
  else (if 'A' <= s[0] <= 'Z' then 1 else 0) + CountUppercase(s[1..])
}

function CountLowercase(s: string): int
  decreases |s|
{
  if |s| == 0 then 0
  else (if 'a' <= s[0] <= 'z' then 1 else 0) + CountLowercase(s[1..])
}
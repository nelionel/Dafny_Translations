method encode(message: string) returns (result: string)
  requires forall i :: 0 <= i < |message| ==> isLetter(message[i]) || message[i] == ' '
  ensures |result| == |message|
  ensures forall i :: 0 <= i < |message| && message[i] == ' ' ==> result[i] == ' '
  ensures forall i :: 0 <= i < |message| && isVowel(message[i]) ==> result[i] == swapCase(mapVowel(message[i]))
  ensures forall i :: 0 <= i < |message| && message[i] != ' ' && !isVowel(message[i]) ==> result[i] == swapCase(message[i])
{
  result := "";
  var i := 0;
  
  while i < |message|
    invariant 0 <= i <= |message|
    invariant |result| == i
    invariant forall j :: 0 <= j < i && message[j] == ' ' ==> result[j] == ' '
    invariant forall j :: 0 <= j < i && isVowel(message[j]) ==> result[j] == swapCase(mapVowel(message[j]))
    invariant forall j :: 0 <= j < i && message[j] != ' ' && !isVowel(message[j]) ==> result[j] == swapCase(message[j])
    decreases |message| - i
  {
    var ch := message[i];
    
    if ch == ' ' {
      result := result + [' '];
    } else if isVowel(ch) {
      var mappedChar := mapVowel(ch);
      var swappedChar := swapCase(mappedChar);
      result := result + [swappedChar];
    } else {
      var swappedChar := swapCase(ch);
      result := result + [swappedChar];
    }
    
    i := i + 1;
  }
}

function isLetter(c: char): bool
{
  ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

function isVowel(c: char): bool
{
  c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
  c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'
}

function mapVowel(c: char): char
  requires isVowel(c)
{
  match c
    case 'a' => 'c'
    case 'e' => 'g' 
    case 'i' => 'k'
    case 'o' => 'q'
    case 'u' => 'w'
    case 'A' => 'C'
    case 'E' => 'G'
    case 'I' => 'K'
    case 'O' => 'Q'
    case 'U' => 'W'
}

function swapCase(c: char): char
{
  if 'a' <= c <= 'z' then
    (c as int - 'a' as int + 'A' as int) as char
  else if 'A' <= c <= 'Z' then
    (c as int - 'A' as int + 'a' as int) as char
  else
    c
}
method encode(message: string) returns (result: string)
  ensures |result| == |message|
{
  result := "";
  var i := 0;
  
  while i < |message|
    invariant 0 <= i <= |message|
    invariant |result| == i
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
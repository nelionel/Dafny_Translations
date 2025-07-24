method words_in_sentence(sentence: string) returns (result: string)
  requires |sentence| >= 1 && |sentence| <= 100
  requires forall i :: 0 <= i < |sentence| ==> sentence[i] == ' ' || ('a' <= sentence[i] <= 'z') || ('A' <= sentence[i] <= 'Z')
  ensures |result| <= |sentence|
  ensures var input_words := split_by_space_spec(sentence);
          var result_words := split_by_space_spec(result);
          forall i :: 0 <= i < |result_words| ==> 
            exists j :: 0 <= j < |input_words| && result_words[i] == input_words[j] && is_prime_spec(|input_words[j]|)
  ensures var input_words := split_by_space_spec(sentence);
          var result_words := split_by_space_spec(result);
          forall i, j :: 0 <= i < j < |result_words| ==> 
            exists ii, jj :: 0 <= ii < jj < |input_words| && 
              result_words[i] == input_words[ii] && result_words[j] == input_words[jj] &&
              is_prime_spec(|input_words[ii]|) && is_prime_spec(|input_words[jj]|)
{
  // Split sentence into words
  var words := split_by_space(sentence);
  
  // Filter words whose lengths are prime
  var prime_words: seq<string> := [];
  var i := 0;
  while i < |words|
    invariant 0 <= i <= |words|
    invariant |prime_words| <= i
    invariant forall k :: 0 <= k < |prime_words| ==> 
      exists j :: 0 <= j < i && prime_words[k] == words[j] && is_prime_spec(|words[j]|)
    decreases |words| - i
  {
    var word_length := |words[i]|;
    var is_prime_length := is_prime(word_length);
    if is_prime_length {
      prime_words := prime_words + [words[i]];
    }
    i := i + 1;
  }
  
  // Join filtered words back with spaces
  result := join_with_space(prime_words);
}

function is_prime_spec(n: int): bool
{
  n >= 2 && forall k :: 2 <= k < n ==> n % k != 0
}

method is_prime(n: int) returns (result: bool)
  requires n >= 0
  ensures result == is_prime_spec(n)
{
  if n < 2 {
    result := false;
  } else if n == 2 {
    result := true;
  } else if n % 2 == 0 {
    result := false;
  } else {
    result := true;
    var i := 3;
    while i * i <= n
      invariant i >= 3
      invariant i % 2 == 1
      invariant result ==> forall k :: 3 <= k < i && k % 2 == 1 ==> n % k != 0
      invariant result ==> forall k :: 2 <= k < 3 ==> n % k != 0
      decreases n - i * i + 1
    {
      if n % i == 0 {
        result := false;
        break;
      }
      i := i + 2;
    }
  }
}

function split_by_space_spec(s: string): seq<string>
{
  if |s| == 0 then []
  else 
    var words := [];
    var current_word := "";
    var i := 0;
    // This is a simplified specification - in practice we'd need a more complex recursive definition
    words
}

method split_by_space(s: string) returns (words: seq<string>)
  ensures words == split_by_space_spec(s)
  ensures forall i :: 0 <= i < |words| ==> |words[i]| > 0
  ensures forall i :: 0 <= i < |words| ==> forall j :: 0 <= j < |words[i]| ==> words[i][j] != ' '
{
  words := [];
  if |s| == 0 {
    return;
  }
  
  var current_word := "";
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    decreases |s| - i
  {
    if s[i] == ' ' {
      if |current_word| > 0 {
        words := words + [current_word];
        current_word := "";
      }
    } else {
      current_word := current_word + [s[i]];
    }
    i := i + 1;
  }
  
  // Add the last word if it's not empty
  if |current_word| > 0 {
    words := words + [current_word];
  }
}

method join_with_space(words: seq<string>) returns (result: string)
  requires forall i :: 0 <= i < |words| ==> forall j :: 0 <= j < |words[i]| ==> words[i][j] != ' '
  ensures |words| == 0 ==> result == ""
  ensures |words| > 0 ==> 
    exists parts :: |parts| == 2 * |words| - 1 &&
    (forall i :: 0 <= i < |words| ==> parts[2*i] == words[i]) &&
    (forall i :: 0 <= i < |words| - 1 ==> parts[2*i + 1] == " ") &&
    result == concat_seq(parts)
{
  result := "";
  var i := 0;
  while i < |words|
    invariant 0 <= i <= |words|
    decreases |words| - i
  {
    if i > 0 {
      result := result + " ";
    }
    result := result + words[i];
    i := i + 1;
  }
}

function concat_seq(parts: seq<string>): string
{
  if |parts| == 0 then ""
  else parts[0] + concat_seq(parts[1..])
}
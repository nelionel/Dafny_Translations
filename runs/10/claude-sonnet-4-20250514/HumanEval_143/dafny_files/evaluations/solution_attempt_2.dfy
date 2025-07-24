method words_in_sentence(sentence: string) returns (result: string)
  requires |sentence| >= 1 && |sentence| <= 100
  requires forall i :: 0 <= i < |sentence| ==> sentence[i] != ' ' || (i > 0 && i < |sentence| - 1)  // no leading/trailing spaces
  ensures |result| <= |sentence|
  ensures result == "" || (result[0] != ' ' && result[|result| - 1] != ' ')  // no leading/trailing spaces in result
  ensures forall i :: 0 <= i < |result| - 1 ==> (result[i] == ' ' ==> result[i+1] != ' ')  // no consecutive spaces
  ensures var input_words := split_by_space(sentence);
          var result_words := if result == "" then [] else split_by_space(result);
          (forall w :: w in result_words ==> w in input_words && is_prime_spec(|w|)) &&
          (forall i, j :: 0 <= i < j < |result_words| ==> 
            exists k1, k2 :: 0 <= k1 < k2 < |input_words| && 
            input_words[k1] == result_words[i] && input_words[k2] == result_words[j])
{
  // Split sentence into words
  var words := split_by_space(sentence);
  
  // Filter words whose lengths are prime
  var prime_words: seq<string> := [];
  var i := 0;
  while i < |words|
    invariant 0 <= i <= |words|
    invariant |prime_words| <= i
    invariant forall w :: w in prime_words ==> w in words && is_prime_spec(|w|)
    invariant forall j, k :: 0 <= j < k < |prime_words| ==> 
      exists j1, k1 :: 0 <= j1 < k1 < i && words[j1] == prime_words[j] && words[k1] == prime_words[k]
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
      invariant result && i * i > n ==> is_prime_spec(n)
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

method split_by_space(s: string) returns (words: seq<string>)
  ensures |words| >= 0
  ensures forall w :: w in words ==> |w| > 0 && forall i :: 0 <= i < |w| ==> w[i] != ' '
  ensures join_with_space(words) == s || (s != "" && join_with_space(words) + " " == s) || (" " + join_with_space(words) == s) || (" " + join_with_space(words) + " " == s)
{
  words := [];
  if |s| == 0 {
    return;
  }
  
  var current_word := "";
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    invariant forall w :: w in words ==> |w| > 0 && forall j :: 0 <= j < |w| ==> w[j] != ' '
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
  requires forall w :: w in words ==> forall i :: 0 <= i < |w| ==> w[i] != ' '
  ensures |words| == 0 ==> result == ""
  ensures |words| > 0 ==> |result| > 0 && result[0] != ' ' && result[|result| - 1] != ' '
  ensures forall i :: 0 <= i < |result| - 1 ==> (result[i] == ' ' ==> result[i+1] != ' ')
{
  result := "";
  var i := 0;
  while i < |words|
    invariant 0 <= i <= |words|
    invariant i == 0 ==> result == ""
    invariant i > 0 ==> |result| > 0 && result[0] != ' ' && result[|result| - 1] != ' '
    decreases |words| - i
  {
    if i > 0 {
      result := result + " ";
    }
    result := result + words[i];
    i := i + 1;
  }
}
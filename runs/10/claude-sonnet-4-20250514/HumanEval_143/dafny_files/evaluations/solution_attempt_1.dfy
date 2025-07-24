method words_in_sentence(sentence: string) returns (result: string)
  requires |sentence| >= 1 && |sentence| <= 100
  requires forall i :: 0 <= i < |sentence| ==> sentence[i] == ' ' || ('a' <= sentence[i] <= 'z') || ('A' <= sentence[i] <= 'Z')
  ensures |result| <= |sentence|
  ensures exists words :: words == split_by_space(sentence) && 
          result == join_with_space(seq(|words|, i requires 0 <= i < |words| => words[i]) |
                    i | 0 <= i < |words| && is_prime(|words[i]|))
{
  // Split sentence into words
  var words := split_by_space(sentence);
  
  // Filter words whose lengths are prime
  var prime_words: seq<string> := [];
  var i := 0;
  while i < |words|
    invariant 0 <= i <= |words|
    invariant |prime_words| <= i
    invariant forall j :: 0 <= j < |prime_words| ==> 
              exists k :: 0 <= k < i && words[k] == prime_words[j] && is_prime(|words[k]|)
    invariant forall j :: 0 <= j < i ==> 
              (is_prime(|words[j]|) <==> exists k :: 0 <= k < |prime_words| && prime_words[k] == words[j])
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

method is_prime(n: int) returns (result: bool)
  requires n >= 0
  ensures result <==> (n >= 2 && forall k :: 2 <= k < n ==> n % k != 0)
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
  ensures |words| == 0 <==> |s| == 0 || forall i :: 0 <= i < |s| ==> s[i] == ' '
  ensures |words| > 0 ==> forall i :: 0 <= i < |words| ==> |words[i]| > 0
  ensures |words| > 0 ==> forall i :: 0 <= i < |words| ==> forall j :: 0 <= j < |words[i]| ==> words[i][j] != ' '
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
  ensures |words| == 0 ==> result == ""
  ensures |words| == 1 ==> result == words[0]
  ensures |words| > 1 ==> |result| >= |words| - 1 + (sum i | 0 <= i < |words| :: |words[i]|)
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
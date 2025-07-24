method fix_spaces(text: string) returns (result: string)
    ensures |text| == 0 ==> result == ""
    ensures ' ' !in result
    ensures forall i :: 0 <= i < |text| && text[i] != ' ' ==> text[i] in result
    // Preserve order of non-space characters
    ensures forall i, j :: 0 <= i < j < |text| && text[i] != ' ' && text[j] != ' ' ==> 
        exists ri, rj :: 0 <= ri < rj < |result| && result[ri] == text[i] && result[rj] == text[j]
    // Result only contains original non-space characters, underscores, and dashes
    ensures forall i :: 0 <= i < |result| ==> result[i] == '_' || result[i] == '-' || result[i] in text
    // Single space becomes single underscore
    ensures forall i :: 0 <= i < |text| && text[i] == ' ' && 
        (i == 0 || text[i-1] != ' ') && 
        (i == |text|-1 || text[i+1] != ' ') ==> 
        exists j :: 0 <= j < |result| && result[j] == '_'
    // Two consecutive spaces become two underscores
    ensures forall i :: 0 <= i < |text|-1 && text[i] == ' ' && text[i+1] == ' ' &&
        (i == 0 || text[i-1] != ' ') && 
        (i+2 >= |text| || text[i+2] != ' ') ==> 
        exists j :: 0 <= j < |result|-1 && result[j] == '_' && result[j+1] == '_'
    // Three or more consecutive spaces become single dash
    ensures forall i :: 0 <= i < |text|-2 && text[i] == ' ' && text[i+1] == ' ' && text[i+2] == ' ' &&
        (i == 0 || text[i-1] != ' ') ==> 
        exists j :: 0 <= j < |result| && result[j] == '-'
{
    if |text| == 0 {
        return text;
    }
    
    result := "";
    var i := 0;
    
    while i < |text|
        invariant 0 <= i <= |text|
        decreases |text| - i
    {
        if text[i] == ' ' {
            // Count consecutive spaces
            var space_count := 0;
            var j := i;
            
            while j < |text| && text[j] == ' '
                invariant i <= j <= |text|
                invariant space_count == j - i
                decreases |text| - j
            {
                space_count := space_count + 1;
                j := j + 1;
            }
            
            // Replace based on count
            if space_count > 2 {
                result := result + "-";
            } else {
                var k := 0;
                while k < space_count
                    invariant 0 <= k <= space_count
                    decreases space_count - k
                {
                    result := result + "_";
                    k := k + 1;
                }
            }
            
            i := j;
        } else {
            result := result + [text[i]];
            i := i + 1;
        }
    }
}

function count_char(s: string, c: char): nat
{
    if |s| == 0 then 0
    else (if s[0] == c then 1 else 0) + count_char(s[1..], c)
}
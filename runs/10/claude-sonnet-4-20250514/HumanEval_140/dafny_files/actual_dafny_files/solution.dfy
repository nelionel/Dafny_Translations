method fix_spaces(text: string) returns (result: string)
    ensures |text| == 0 ==> result == ""
    ensures ' ' !in result
    ensures forall i :: 0 <= i < |result| ==> result[i] == '_' || result[i] == '-' || result[i] in text
    // Preserve order of non-space characters
    ensures forall i, j :: 0 <= i < j < |text| && text[i] != ' ' && text[j] != ' ' ==> 
        exists ri, rj :: 0 <= ri < rj < |result| && result[ri] == text[i] && result[rj] == text[j]
    // All non-space characters are preserved
    ensures forall i :: 0 <= i < |text| && text[i] != ' ' ==> text[i] in result
    // Precise transformation rules for consecutive spaces
    ensures forall i, len :: 0 <= i < |text| && len >= 1 &&
        (forall k :: i <= k < i + len ==> k < |text| && text[k] == ' ') &&
        (i == 0 || text[i-1] != ' ') &&
        (i + len >= |text| || text[i + len] != ' ') ==>
        (len == 1 ==> exists pos :: 0 <= pos < |result| && result[pos] == '_' &&
            forall other :: 0 <= other < |result| && other != pos ==> result[other] != '_' || 
            exists other_run :: other_run != i && is_space_run_of_length_1_or_2(text, other_run)) &&
        (len == 2 ==> exists pos1, pos2 :: 0 <= pos1 < pos2 < |result| && result[pos1] == '_' && result[pos2] == '_' &&
            forall other :: 0 <= other < |result| && other != pos1 && other != pos2 ==> result[other] != '_' || 
            exists other_run :: other_run != i && is_space_run_of_length_1_or_2(text, other_run)) &&
        (len > 2 ==> exists pos :: 0 <= pos < |result| && result[pos] == '-' &&
            forall other :: 0 <= other < |result| && other != pos ==> result[other] != '-' || 
            exists other_run :: other_run != i && is_space_run_of_length_3_plus(text, other_run))
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

predicate is_space_run_of_length_1_or_2(text: string, start: int)
{
    0 <= start < |text| && text[start] == ' ' &&
    (start == 0 || text[start-1] != ' ') &&
    ((start + 1 < |text| && text[start + 1] != ' ') ||
     (start + 1 < |text| && text[start + 1] == ' ' && start + 2 < |text| && text[start + 2] != ' ') ||
     (start + 1 < |text| && text[start + 1] == ' ' && start + 2 >= |text|))
}

predicate is_space_run_of_length_3_plus(text: string, start: int)
{
    0 <= start < |text| && text[start] == ' ' &&
    (start == 0 || text[start-1] != ' ') &&
    start + 2 < |text| && text[start + 1] == ' ' && text[start + 2] == ' '
}
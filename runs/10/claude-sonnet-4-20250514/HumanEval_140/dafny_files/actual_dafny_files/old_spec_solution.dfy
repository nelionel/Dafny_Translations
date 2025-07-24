method fix_spaces(text: string) returns (result: string)
    ensures |result| >= 0
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
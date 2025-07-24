method IsAllDigits(s: string) returns (result: bool)
    requires |s| > 0
    ensures result <==> (forall i :: 0 <= i < |s| ==> '0' <= s[i] <= '9')
{
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant forall j :: 0 <= j < i ==> '0' <= s[j] <= '9'
    {
        if s[i] < '0' || s[i] > '9' {
            return false;
        }
        i := i + 1;
    }
    return true;
}

method StringToInt(s: string) returns (result: int)
    requires |s| > 0
    requires forall i :: 0 <= i < |s| ==> '0' <= s[i] <= '9'
    ensures result >= 0
{
    var i := 0;
    var value := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant value >= 0
    {
        var digit := (s[i] as int) - ('0' as int);
        value := value * 10 + digit;
        i := i + 1;
    }
    return value;
}

method SplitByDash(s: string) returns (parts: seq<string>)
    ensures |parts| >= 1
{
    if |s| == 0 {
        return [s];
    }
    
    var result := [];
    var start := 0;
    var i := 0;
    
    while i < |s|
        invariant 0 <= start <= i <= |s|
        invariant |result| >= 0
    {
        if s[i] == '-' {
            var part := s[start..i];
            result := result + [part];
            start := i + 1;
        }
        i := i + 1;
    }
    
    // Add the last part
    var last_part := s[start..];
    result := result + [last_part];
    
    return result;
}

method CountDashes(s: string) returns (count: int)
    ensures count >= 0
    ensures count <= |s|
{
    var i := 0;
    var dash_count := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant dash_count >= 0
    {
        if s[i] == '-' {
            dash_count := dash_count + 1;
        }
        i := i + 1;
    }
    
    return dash_count;
}

predicate ValidDateFormat(date: string)
{
    |date| > 0 &&
    (exists i, j :: 0 <= i < j < |date| && date[i] == '-' && date[j] == '-' &&
     (forall k :: 0 <= k < |date| && k != i && k != j ==> date[k] != '-'))
}

predicate IsValidMonth(month: int)
{
    1 <= month <= 12
}

predicate IsValidDay(day: int, month: int)
    requires IsValidMonth(month)
{
    if month in {1, 3, 5, 7, 8, 10, 12} then
        1 <= day <= 31
    else if month in {4, 6, 9, 11} then
        1 <= day <= 30
    else // month == 2
        1 <= day <= 29
}

method valid_date(date: string) returns (result: bool)
    ensures result ==> (
        |date| > 0 &&
        ValidDateFormat(date) &&
        exists parts :: |parts| == 3 &&
        (forall i :: 0 <= i < |parts[0]| ==> '0' <= parts[0][i] <= '9') &&
        (forall i :: 0 <= i < |parts[1]| ==> '0' <= parts[1][i] <= '9') &&
        (forall i :: 0 <= i < |parts[2]| ==> '0' <= parts[2][i] <= '9') &&
        |parts[0]| > 0 && |parts[1]| > 0 && |parts[2]| > 0 &&
        exists month, day, year ::
            month >= 0 && day >= 0 && year >= 0 &&
            IsValidMonth(month) &&
            IsValidDay(day, month)
    )
    ensures !result ==> (
        |date| == 0 ||
        !ValidDateFormat(date) ||
        exists parts :: |parts| == 3 &&
        (|parts[0]| == 0 || |parts[1]| == 0 || |parts[2]| == 0 ||
         exists i :: (0 <= i < |parts[0]| && (parts[0][i] < '0' || parts[0][i] > '9')) ||
         exists i :: (0 <= i < |parts[1]| && (parts[1][i] < '0' || parts[1][i] > '9')) ||
         exists i :: (0 <= i < |parts[2]| && (parts[2][i] < '0' || parts[2][i] > '9')) ||
         exists month, day :: !IsValidMonth(month) || (IsValidMonth(month) && !IsValidDay(day, month)))
    )
{
    // Rule 1: Check if date string is not empty
    if |date| == 0 {
        return false;
    }
    
    // Rule 4: Check if date is in correct format (mm-dd-yyyy)
    var dash_count := CountDashes(date);
    if dash_count != 2 {
        return false;
    }
    
    // Split by dashes
    var parts := SplitByDash(date);
    if |parts| != 3 {
        return false;
    }
    
    var month_str := parts[0];
    var day_str := parts[1];
    var year_str := parts[2];
    
    // Check if all parts are non-empty
    if |month_str| == 0 || |day_str| == 0 || |year_str| == 0 {
        return false;
    }
    
    // Check if all parts are numeric
    var month_is_digits := IsAllDigits(month_str);
    var day_is_digits := IsAllDigits(day_str);
    var year_is_digits := IsAllDigits(year_str);
    
    if !month_is_digits || !day_is_digits || !year_is_digits {
        return false;
    }
    
    // Convert to integers
    var month := StringToInt(month_str);
    var day := StringToInt(day_str);
    var year := StringToInt(year_str);
    
    // Rule 3: Check if month is valid (1-12)
    if month < 1 || month > 12 {
        return false;
    }
    
    // Rule 2: Check if day is valid based on the month
    // Months with 31 days: 1,3,5,7,8,10,12
    if month == 1 || month == 3 || month == 5 || month == 7 || 
       month == 8 || month == 10 || month == 12 {
        if day < 1 || day > 31 {
            return false;
        }
    }
    // Months with 30 days: 4,6,9,11
    else if month == 4 || month == 6 || month == 9 || month == 11 {
        if day < 1 || day > 30 {
            return false;
        }
    }
    // February (month 2) - max 29 days
    else if month == 2 {
        if day < 1 || day > 29 {
            return false;
        }
    }
    
    return true;
}
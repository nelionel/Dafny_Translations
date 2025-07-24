method strlen(s: string) returns (result: int)
    ensures result >= 0
    ensures result == |s|
{
    result := |s|;
}
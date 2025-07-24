method get_row(lst: seq<seq<int>>, x: int) returns (coordinates: seq<(int, int)>)
    ensures forall coord :: coord in coordinates ==> 
        0 <= coord.0 < |lst| && 0 <= coord.1 < |lst[coord.0]| && lst[coord.0][coord.1] == x
    ensures forall i, j :: 0 <= i < j < |coordinates| ==> 
        coordinates[i].0 <= coordinates[j].0 && 
        (coordinates[i].0 == coordinates[j].0 ==> coordinates[i].1 >= coordinates[j].1)
{
    coordinates := [];
    
    // Find all occurrences of x
    for row_idx := 0 to |lst|
        invariant 0 <= row_idx <= |lst|
        invariant forall coord :: coord in coordinates ==> 
            0 <= coord.0 < row_idx && 0 <= coord.1 < |lst[coord.0]| && lst[coord.0][coord.1] == x
    {
        for col_idx := 0 to |lst[row_idx]|
            invariant 0 <= col_idx <= |lst[row_idx]|
            invariant forall coord :: coord in coordinates ==> 
                (coord.0 < row_idx || (coord.0 == row_idx && coord.1 >= col_idx)) ==> 
                0 <= coord.0 < |lst| && 0 <= coord.1 < |lst[coord.0]| && lst[coord.0][coord.1] == x
        {
            if lst[row_idx][col_idx] == x {
                coordinates := coordinates + [(row_idx, col_idx)];
            }
        }
    }
    
    // Sort coordinates: first by row ascending, then by column descending
    coordinates := SortCoordinates(coordinates);
}

method SortCoordinates(coords: seq<(int, int)>) returns (sorted: seq<(int, int)>)
    ensures |sorted| == |coords|
    ensures forall coord :: coord in coords <==> coord in sorted
    ensures forall i, j :: 0 <= i < j < |sorted| ==> 
        sorted[i].0 <= sorted[j].0 && 
        (sorted[i].0 == sorted[j].0 ==> sorted[i].1 >= sorted[j].1)
    decreases |coords|
{
    if |coords| <= 1 {
        sorted := coords;
        return;
    }
    
    // Simple insertion sort
    sorted := [];
    for i := 0 to |coords|
        invariant 0 <= i <= |coords|
        invariant |sorted| == i
        invariant forall coord :: coord in sorted ==> coord in coords
        invariant forall k, l :: 0 <= k < l < |sorted| ==> 
            sorted[k].0 <= sorted[l].0 && 
            (sorted[k].0 == sorted[l].0 ==> sorted[k].1 >= sorted[l].1)
    {
        var coord := coords[i];
        var j := |sorted|;
        
        while j > 0 && CompareCoordinates(sorted[j-1], coord) > 0
            invariant 0 <= j <= |sorted|
            decreases j
        {
            j := j - 1;
        }
        
        sorted := sorted[..j] + [coord] + sorted[j..];
    }
}

function CompareCoordinates(a: (int, int), b: (int, int)): int
{
    if a.0 < b.0 then -1
    else if a.0 > b.0 then 1
    else if a.1 > b.1 then -1  // descending order for columns within same row
    else if a.1 < b.1 then 1
    else 0
}
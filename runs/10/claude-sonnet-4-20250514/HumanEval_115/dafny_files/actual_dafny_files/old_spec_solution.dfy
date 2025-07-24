method max_fill(grid: seq<seq<int>>, capacity: int) returns (total_trips: int)
    requires capacity > 0
    requires |grid| > 0
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| > 0
    requires forall i, j :: 0 <= i < |grid| && 0 <= j < |grid[i]| ==> grid[i][j] == 0 || grid[i][j] == 1
    requires forall i :: 0 <= i < |grid| - 1 ==> |grid[i]| == |grid[i + 1]|  // all wells have same length
    ensures total_trips >= 0
{
    total_trips := 0;
    var i := 0;
    
    while i < |grid|
        invariant 0 <= i <= |grid|
        invariant total_trips >= 0
        decreases |grid| - i
    {
        var water_units := count_water_units(grid[i]);
        var trips_needed := if water_units > 0 then ceiling_division(water_units, capacity) else 0;
        total_trips := total_trips + trips_needed;
        i := i + 1;
    }
}

function count_water_units(row: seq<int>): int
    requires forall j :: 0 <= j < |row| ==> row[j] == 0 || row[j] == 1
    ensures count_water_units(row) >= 0
    ensures count_water_units(row) <= |row|
    decreases |row|
{
    if |row| == 0 then 0
    else row[0] + count_water_units(row[1..])
}

function ceiling_division(numerator: int, denominator: int): int
    requires denominator > 0
    requires numerator >= 0
    ensures ceiling_division(numerator, denominator) >= 0
    ensures numerator == 0 ==> ceiling_division(numerator, denominator) == 0
    ensures numerator > 0 ==> ceiling_division(numerator, denominator) > 0
    ensures ceiling_division(numerator, denominator) * denominator >= numerator
    ensures (ceiling_division(numerator, denominator) - 1) * denominator < numerator || numerator == 0
{
    if numerator == 0 then 0
    else (numerator + denominator - 1) / denominator
}
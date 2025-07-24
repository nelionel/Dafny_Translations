method max_fill(grid: seq<seq<int>>, capacity: int) returns (total_trips: int)
    requires capacity > 0
    ensures total_trips >= 0
    ensures total_trips == sum_ceiling_divisions(grid, capacity)
{
    total_trips := 0;
    var i := 0;
    
    while i < |grid|
        invariant 0 <= i <= |grid|
        invariant total_trips >= 0
        invariant total_trips == sum_ceiling_divisions(grid[..i], capacity)
        decreases |grid| - i
    {
        var water_units := count_water_units(grid[i]);
        var trips_needed := if water_units > 0 then ceiling_division(water_units, capacity) else 0;
        total_trips := total_trips + trips_needed;
        i := i + 1;
    }
}

function sum_ceiling_divisions(grid: seq<seq<int>>, capacity: int): int
    requires capacity > 0
    ensures sum_ceiling_divisions(grid, capacity) >= 0
{
    if |grid| == 0 then 0
    else 
        var water_units := count_water_units(grid[0]);
        var trips_needed := if water_units > 0 then ceiling_division(water_units, capacity) else 0;
        trips_needed + sum_ceiling_divisions(grid[1..], capacity)
}

function count_water_units(row: seq<int>): int
    ensures count_water_units(row) == sum_sequence(row)
    decreases |row|
{
    if |row| == 0 then 0
    else row[0] + count_water_units(row[1..])
}

function sum_sequence(s: seq<int>): int
    decreases |s|
{
    if |s| == 0 then 0
    else s[0] + sum_sequence(s[1..])
}

function ceiling_division(numerator: int, denominator: int): int
    requires denominator > 0
    ensures ceiling_division(numerator, denominator) >= 0
    ensures numerator <= 0 ==> ceiling_division(numerator, denominator) == 0
    ensures numerator > 0 ==> ceiling_division(numerator, denominator) > 0
    ensures ceiling_division(numerator, denominator) * denominator >= numerator
    ensures (ceiling_division(numerator, denominator) - 1) * denominator < numerator || numerator <= 0
{
    if numerator <= 0 then 0
    else (numerator + denominator - 1) / denominator
}
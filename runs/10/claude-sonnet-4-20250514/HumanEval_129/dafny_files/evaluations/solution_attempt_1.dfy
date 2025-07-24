method minPath(grid: seq<seq<int>>, k: int) returns (result: seq<int>)
    requires |grid| >= 2
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| == |grid|
    requires k > 0
    requires ValidGrid(grid)
    ensures |result| == k
    ensures forall i :: 0 <= i < |result| ==> result[i] in GridValues(grid)
    ensures IsValidPath(grid, result)
    ensures IsLexicographicallyMinimal(grid, result, k)
{
    var n := |grid|;
    var directions := [(0, 1), (0, -1), (1, 0), (-1, 0)];
    
    // Find all starting positions with their values
    var startPositions: seq<(int, int, int)> := [];
    var i := 0;
    while i < n
        invariant 0 <= i <= n
        invariant |startPositions| == i * n
    {
        var j := 0;
        while j < n
            invariant 0 <= j <= n
            invariant |startPositions| == i * n + j
        {
            startPositions := startPositions + [(grid[i][j], i, j)];
            j := j + 1;
        }
        i := i + 1;
    }
    
    // Sort starting positions by value
    startPositions := SortPositions(startPositions);
    
    var bestResult: seq<int> := [];
    var found := false;
    
    var pos := 0;
    while pos < |startPositions|
        invariant 0 <= pos <= |startPositions|
        invariant found ==> |bestResult| == k
    {
        var startVal, startRow, startCol := startPositions[pos].0, startPositions[pos].1, startPositions[pos].2;
        var path := DFS(grid, startRow, startCol, [startVal], k - 1, n);
        
        if |path| == k {
            if !found || IsLexicographicallySmaller(path, bestResult) {
                bestResult := path;
                found := true;
            }
        }
        pos := pos + 1;
    }
    
    result := if found then bestResult else seq(k, i => 1);
}

predicate ValidGrid(grid: seq<seq<int>>)
    requires |grid| >= 2
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| == |grid|
{
    var n := |grid|;
    var values := set i, j | 0 <= i < n && 0 <= j < n :: grid[i][j];
    values == set i | 1 <= i <= n * n :: i
}

function GridValues(grid: seq<seq<int>>): set<int>
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| == |grid|
{
    set i, j | 0 <= i < |grid| && 0 <= j < |grid| :: grid[i][j]
}

predicate IsValidPath(grid: seq<seq<int>>, path: seq<int>)
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| == |grid|
{
    |path| > 0 && exists positions: seq<(int, int)> ::
        |positions| == |path| &&
        (forall i :: 0 <= i < |positions| ==> 
            0 <= positions[i].0 < |grid| && 0 <= positions[i].1 < |grid| &&
            grid[positions[i].0][positions[i].1] == path[i]) &&
        (forall i :: 0 <= i < |positions| - 1 ==> AreAdjacent(positions[i], positions[i+1]))
}

predicate AreAdjacent(pos1: (int, int), pos2: (int, int))
{
    var dr := pos2.0 - pos1.0;
    var dc := pos2.1 - pos1.1;
    (dr == 0 && (dc == 1 || dc == -1)) || (dc == 0 && (dr == 1 || dr == -1))
}

predicate IsLexicographicallyMinimal(grid: seq<seq<int>>, result: seq<int>, k: int)
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| == |grid|
    requires |result| == k
{
    forall path :: IsValidPath(grid, path) && |path| == k ==> !IsLexicographicallySmaller(path, result)
}

method GetNeighbors(grid: seq<seq<int>>, row: int, col: int, n: int) returns (neighbors: seq<(int, int, int)>)
    requires 0 <= row < n
    requires 0 <= col < n
    requires n == |grid|
    requires forall i :: 0 <= i < n ==> |grid[i]| == n
{
    var directions := [(0, 1), (0, -1), (1, 0), (-1, 0)];
    neighbors := [];
    var i := 0;
    
    while i < |directions|
        invariant 0 <= i <= |directions|
    {
        var dr, dc := directions[i].0, directions[i].1;
        var newRow := row + dr;
        var newCol := col + dc;
        
        if 0 <= newRow < n && 0 <= newCol < n {
            neighbors := neighbors + [(grid[newRow][newCol], newRow, newCol)];
        }
        i := i + 1;
    }
    
    neighbors := SortPositions(neighbors);
}

method DFS(grid: seq<seq<int>>, row: int, col: int, path: seq<int>, remainingSteps: int, n: int) returns (result: seq<int>)
    requires 0 <= row < n
    requires 0 <= col < n
    requires n == |grid|
    requires forall i :: 0 <= i < n ==> |grid[i]| == n
    requires remainingSteps >= 0
    requires |path| >= 1
    decreases remainingSteps
{
    if remainingSteps == 0 {
        result := path;
        return;
    }
    
    var neighbors := GetNeighbors(grid, row, col, n);
    var bestPath: seq<int> := [];
    var found := false;
    
    var i := 0;
    while i < |neighbors|
        invariant 0 <= i <= |neighbors|
        invariant found ==> |bestPath| == |path| + remainingSteps
    {
        var val, nextRow, nextCol := neighbors[i].0, neighbors[i].1, neighbors[i].2;
        var candidatePath := DFS(grid, nextRow, nextCol, path + [val], remainingSteps - 1, n);
        
        if |candidatePath| == |path| + remainingSteps {
            if !found || IsLexicographicallySmaller(candidatePath, bestPath) {
                bestPath := candidatePath;
                found := true;
            }
        }
        i := i + 1;
    }
    
    result := if found then bestPath else [];
}

method SortPositions(positions: seq<(int, int, int)>) returns (sorted: seq<(int, int, int)>)
{
    sorted := positions;
    var i := 0;
    while i < |sorted|
        invariant 0 <= i <= |sorted|
    {
        var j := i + 1;
        while j < |sorted|
            invariant i < j <= |sorted|
        {
            if sorted[j].0 < sorted[i].0 {
                var temp := sorted[i];
                sorted := sorted[i := sorted[j]][j := temp];
            }
            j := j + 1;
        }
        i := i + 1;
    }
}

predicate IsLexicographicallySmaller(a: seq<int>, b: seq<int>)
{
    if |a| == 0 then |b| > 0
    else if |b| == 0 then false
    else if a[0] < b[0] then true
    else if a[0] > b[0] then false
    else IsLexicographicallySmaller(a[1..], b[1..])
}
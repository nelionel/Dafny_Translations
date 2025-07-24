function findPlanetIndexPure(planets: seq<string>, planet: string): int
    requires |planets| == 8
    ensures findPlanetIndexPure(planets, planet) == -1 || (0 <= findPlanetIndexPure(planets, planet) < |planets| && planets[findPlanetIndexPure(planets, planet)] == planet)
    ensures findPlanetIndexPure(planets, planet) != -1 ==> planets[findPlanetIndexPure(planets, planet)] == planet
    ensures findPlanetIndexPure(planets, planet) == -1 ==> forall i :: 0 <= i < |planets| ==> planets[i] != planet
{
    if |planets| == 0 then -1
    else if planets[0] == planet then 0
    else 
        var subResult := findPlanetIndexPure(planets[1..], planet);
        if subResult == -1 then -1 else subResult + 1
}

method bf(planet1: string, planet2: string) returns (result: seq<string>)
    ensures var planets := ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"];
            var index1 := findPlanetIndexPure(planets, planet1);
            var index2 := findPlanetIndexPure(planets, planet2);
            (index1 == -1 || index2 == -1) ==> |result| == 0
    ensures var planets := ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"];
            var index1 := findPlanetIndexPure(planets, planet1);
            var index2 := findPlanetIndexPure(planets, planet2);
            (index1 != -1 && index2 != -1) ==> 
            (var start := if index1 < index2 then index1 else index2;
             var end := if index1 > index2 then index1 else index2;
             result == if start + 1 >= end then [] else planets[start + 1..end])
    ensures |result| <= 6
    ensures forall p :: p in result ==> p in ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
{
    var planets := ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"];
    
    // Find indices of both planets
    var index1 := findPlanetIndex(planets, planet1);
    var index2 := findPlanetIndex(planets, planet2);
    
    // Check if both planets are valid
    if index1 == -1 || index2 == -1 {
        result := [];
        return;
    }
    
    // Determine the start and end indices
    var start := if index1 < index2 then index1 else index2;
    var end := if index1 > index2 then index1 else index2;
    
    // Return planets between the two planets (exclusive)
    if start + 1 >= end {
        result := [];
    } else {
        result := planets[start + 1..end];
    }
}

method findPlanetIndex(planets: seq<string>, planet: string) returns (index: int)
    requires |planets| == 8
    ensures index == -1 || (0 <= index < |planets| && planets[index] == planet)
    ensures index != -1 ==> planets[index] == planet
    ensures index == -1 ==> forall i :: 0 <= i < |planets| ==> planets[i] != planet
    ensures index == findPlanetIndexPure(planets, planet)
{
    index := -1;
    var i := 0;
    while i < |planets|
        invariant 0 <= i <= |planets|
        invariant index == -1 ==> forall j :: 0 <= j < i ==> planets[j] != planet
        invariant index != -1 ==> 0 <= index < i && planets[index] == planet
        decreases |planets| - i
    {
        if planets[i] == planet {
            index := i;
            return;
        }
        i := i + 1;
    }
}
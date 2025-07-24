method bf(planet1: string, planet2: string) returns (result: seq<string>)
    ensures |result| <= 6  // At most 6 planets between any two
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
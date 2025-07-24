method bf(planet1: string, planet2: string) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := bf("Jupiter", "Neptune");
    expect result == ["Saturn", "Uranus"];
}

method {:test} test_1()
{
    var result := bf("Earth", "Mercury");
    expect result == ["Venus"];
}

method {:test} test_2()
{
    var result := bf("Mercury", "Uranus");
    expect result == ["Venus", "Earth", "Mars", "Jupiter", "Saturn"];
}

method {:test} test_3()
{
    var result := bf("Neptune", "Venus");
    expect result == ["Earth", "Mars", "Jupiter", "Saturn", "Uranus"];
}

method {:test} test_4()
{
    var result := bf("Earth", "Earth");
    expect result == [];
}

method {:test} test_5()
{
    var result := bf("Mars", "Earth");
    expect result == [];
}

method {:test} test_6()
{
    var result := bf("Jupiter", "Makemake");
    expect result == [];
}
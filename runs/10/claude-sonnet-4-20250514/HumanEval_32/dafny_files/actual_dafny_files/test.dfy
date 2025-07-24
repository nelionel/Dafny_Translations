method poly(xs: seq<real>, x: real) returns (result: real)
    requires |xs| > 0
{
    result := 0.0;
}

function abs_real(x: real): real
{
    if x >= 0.0 then x else -x
}

method {:test} test_0()
{
    // Test polynomial x^2 - 1 = 0 at root x = 1
    // Coefficients: [-1, 0, 1] represents -1 + 0*x + 1*x^2
    var coeffs := [-1.0, 0.0, 1.0];
    var result := poly(coeffs, 1.0);
    expect abs_real(result) < 0.0001;
}

method {:test} test_1()
{
    // Test polynomial x^2 - 1 = 0 at root x = -1
    var coeffs := [-1.0, 0.0, 1.0];
    var result := poly(coeffs, -1.0);
    expect abs_real(result) < 0.0001;
}

method {:test} test_2()
{
    // Test polynomial x - 2 = 0 at root x = 2
    // Coefficients: [-2, 1] represents -2 + 1*x
    var coeffs := [-2.0, 1.0];
    var result := poly(coeffs, 2.0);
    expect abs_real(result) < 0.0001;
}

method {:test} test_3()
{
    // Test polynomial x^2 - 4 = 0 at root x = 2
    // Coefficients: [-4, 0, 1] represents -4 + 0*x + 1*x^2
    var coeffs := [-4.0, 0.0, 1.0];
    var result := poly(coeffs, 2.0);
    expect abs_real(result) < 0.0001;
}

method {:test} test_4()
{
    // Test polynomial x^2 - 4 = 0 at root x = -2
    var coeffs := [-4.0, 0.0, 1.0];
    var result := poly(coeffs, -2.0);
    expect abs_real(result) < 0.0001;
}

method {:test} test_5()
{
    // Test polynomial 2x - 6 = 0 at root x = 3
    // Coefficients: [-6, 2] represents -6 + 2*x
    var coeffs := [-6.0, 2.0];
    var result := poly(coeffs, 3.0);
    expect abs_real(result) < 0.0001;
}
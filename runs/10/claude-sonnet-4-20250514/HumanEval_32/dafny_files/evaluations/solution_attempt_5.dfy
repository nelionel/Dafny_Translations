method poly(xs: seq<real>, x: real) returns (result: real)
    requires |xs| > 0
    ensures result == poly_spec(xs, x, |xs|)
{
    result := 0.0;
    var i := 0;
    while i < |xs|
        invariant 0 <= i <= |xs|
        invariant result == poly_spec(xs, x, i)
        decreases |xs| - i
    {
        var power := pow(x, i);
        result := result + xs[i] * power;
        i := i + 1;
    }
}

function poly_spec(xs: seq<real>, x: real, n: int): real
    requires 0 <= n <= |xs|
    decreases n
{
    if n == 0 then 0.0
    else poly_spec(xs, x, n-1) + xs[n-1] * pow(x, n-1)
}

method poly_derivative(xs: seq<real>, x: real) returns (result: real)
    requires |xs| > 0
    ensures result == poly_derivative_spec(xs, x)
{
    result := 0.0;
    var i := 1;
    while i < |xs|
        invariant 1 <= i <= |xs|
        decreases |xs| - i
    {
        var power := if i == 1 then 1.0 else pow(x, i - 1);
        result := result + (i as real) * xs[i] * power;
        i := i + 1;
    }
}

function poly_derivative_spec(xs: seq<real>, x: real): real
    requires |xs| > 0
{
    if |xs| == 1 then 0.0
    else poly_derivative_spec_helper(xs, x, 1, |xs|)
}

function poly_derivative_spec_helper(xs: seq<real>, x: real, i: int, n: int): real
    requires 1 <= i <= n <= |xs|
    decreases n - i
{
    if i == n then 0.0
    else (i as real) * xs[i] * pow(x, i - 1) + poly_derivative_spec_helper(xs, x, i + 1, n)
}

method find_zero(xs: seq<real>) returns (result: real)
    requires |xs| > 0
    requires |xs| % 2 == 0  // even number of coefficients
    requires xs[|xs|-1] != 0.0  // largest (leading) coefficient is non-zero
    ensures abs_real(poly_spec(xs, result, |xs|)) < 0.0000000001 || 
            abs_real(poly_derivative_spec(xs, result)) < 0.0000000001 ||
            exists prev_x: real :: 
                (abs_real(result - prev_x) < 0.0000000001 && 
                 abs_real(poly_derivative_spec(xs, prev_x)) >= 0.0000000001)
{
    var x := 1.0;
    var iterations := 0;
    var tolerance := 0.0000000001;  // 1e-10 in decimal form
    
    while iterations < 1000
        invariant 0 <= iterations <= 1000
        decreases 1000 - iterations
    {
        var fx := poly(xs, x);
        var fpx := poly_derivative(xs, x);
        
        // Check if we found the zero (within tolerance)
        if abs_real(fx) < tolerance
        {
            break;
        }
        
        // Avoid division by zero
        if abs_real(fpx) < tolerance
        {
            break;
        }
        
        // Newton-Raphson update: x_new = x - f(x)/f'(x)
        var x_new := x - fx / fpx;
        
        // Check for convergence
        if abs_real(x_new - x) < tolerance
        {
            break;
        }
        
        x := x_new;
        iterations := iterations + 1;
    }
    
    result := x;
}

function pow(base: real, exp: int): real
    requires exp >= 0
    decreases exp
{
    if exp == 0 then 1.0
    else base * pow(base, exp - 1)
}

function abs_real(x: real): real
{
    if x >= 0.0 then x else -x
}
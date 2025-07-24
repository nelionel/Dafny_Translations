def bf(planet1, planet2):
    '''
    There are eight planets in our solar system: the closerst to the Sun 
    is Mercury, the next one is Venus, then Earth, Mars, Jupiter, Saturn, 
    Uranus, Neptune.
    Write a function that takes two planet names as strings planet1 and planet2. 
    The function should return a tuple containing all planets whose orbits are 
    located between the orbit of planet1 and the orbit of planet2, sorted by 
    the proximity to the sun. 
    The function should return an empty tuple if planet1 or planet2
    are not correct planet names. 
    Examples
    bf("Jupiter", "Neptune") ==> ("Saturn", "Uranus")
    bf("Earth", "Mercury") ==> ("Venus")
    bf("Mercury", "Uranus") ==> ("Venus", "Earth", "Mars", "Jupiter", "Saturn")
    '''
    # Define the planets in order from the Sun
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    
    # Check if both planets are valid
    if planet1 not in planets or planet2 not in planets:
        return ()
    
    # Get the indices of the two planets
    index1 = planets.index(planet1)
    index2 = planets.index(planet2)
    
    # Determine the range between the two planets (exclusive)
    start = min(index1, index2)
    end = max(index1, index2)
    
    # Get planets between the two planets (exclusive of the endpoints)
    between_planets = planets[start + 1:end]
    
    # Return as tuple
    return tuple(between_planets)
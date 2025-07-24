def max_fill(grid, capacity):
    import math
    
    total_trips = 0
    
    for row in grid:
        water_units = sum(row)  # Count number of 1s in this row
        trips_needed = math.ceil(water_units / capacity)
        total_trips += trips_needed
    
    return total_trips
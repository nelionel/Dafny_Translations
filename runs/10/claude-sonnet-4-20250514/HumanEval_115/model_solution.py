def max_fill(grid, capacity):
    import math
    """
    You are given a rectangular grid of wells. Each row represents a single well,
    and each 1 in a row represents a single unit of water.
    Each well has a corresponding bucket that can be used to extract water from it, 
    and all buckets have the same capacity.
    Your task is to use the buckets to empty the wells.
    Output the number of times you need to lower the buckets.
    """
    
    total_trips = 0
    
    # For each well (row)
    for row in grid:
        # Count water units in this well
        water_units = sum(row)
        
        # Calculate trips needed for this well
        if water_units > 0:
            trips_needed = math.ceil(water_units / capacity)
        else:
            trips_needed = 0
            
        total_trips += trips_needed
    
    return total_trips
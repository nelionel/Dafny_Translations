def minPath(grid, k):
    """
    Given a grid with N rows and N columns (N >= 2) and a positive integer k, 
    each cell of the grid contains a value. Every integer in the range [1, N * N]
    inclusive appears exactly once on the cells of the grid.

    You have to find the minimum path of length k in the grid. You can start
    from any cell, and in each step you can move to any of the neighbor cells,
    in other words, you can go to cells which share an edge with you current
    cell.
    Please note that a path of length k means visiting exactly k cells (not
    necessarily distinct).
    You CANNOT go off the grid.
    A path A (of length k) is considered less than a path B (of length k) if
    after making the ordered lists of the values on the cells that A and B go
    through (let's call them lst_A and lst_B), lst_A is lexicographically less
    than lst_B, in other words, there exist an integer index i (1 <= i <= k)
    such that lst_A[i] < lst_B[i] and for any j (1 <= j < i) we have
    lst_A[j] = lst_B[j].
    It is guaranteed that the answer is unique.
    Return an ordered list of the values on the cells that the minimum path go through.
    """
    if not grid or not grid[0]:
        return []
    
    n = len(grid)
    
    # Find the minimum value and its position
    min_val = float('inf')
    min_pos = (0, 0)
    
    for i in range(n):
        for j in range(n):
            if grid[i][j] < min_val:
                min_val = grid[i][j]
                min_pos = (i, j)
    
    # If k is 1, just return the minimum value
    if k == 1:
        return [min_val]
    
    # Directions for adjacent cells (up, down, left, right)
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    
    def get_neighbors(row, col):
        neighbors = []
        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc
            if 0 <= new_row < n and 0 <= new_col < n:
                neighbors.append((new_row, new_col))
        return neighbors
    
    def dfs(row, col, path, remaining_steps):
        if remaining_steps == 0:
            return path[:]
        
        # Get all neighbors and their values
        neighbors = get_neighbors(row, col)
        neighbor_values = [(grid[r][c], r, c) for r, c in neighbors]
        
        # Sort by value to ensure lexicographical order
        neighbor_values.sort()
        
        # Try each neighbor in order of their values
        for val, r, c in neighbor_values:
            path.append(val)
            result = dfs(r, c, path, remaining_steps - 1)
            if result:
                return result
            path.pop()
        
        return None
    
    # Start DFS from the minimum value position
    initial_path = [min_val]
    result = dfs(min_pos[0], min_pos[1], initial_path, k - 1)
    
    return result if result else []
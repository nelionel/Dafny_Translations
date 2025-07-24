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
    
    n = len(grid)
    directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]  # right, left, down, up
    
    # Find all possible starting positions and their values
    start_positions = []
    for i in range(n):
        for j in range(n):
            start_positions.append((grid[i][j], i, j))
    
    # Sort by value to try starting from smallest values first
    start_positions.sort()
    
    def get_neighbors(row, col):
        neighbors = []
        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc
            if 0 <= new_row < n and 0 <= new_col < n:
                neighbors.append((grid[new_row][new_col], new_row, new_col))
        return sorted(neighbors)  # Sort by value to prioritize smaller values
    
    def dfs(row, col, path, remaining_steps):
        if remaining_steps == 0:
            return path
        
        # Get all possible next moves
        neighbors = get_neighbors(row, col)
        
        # Try each neighbor in order of their values (smallest first)
        best_path = None
        for val, next_row, next_col in neighbors:
            candidate_path = dfs(next_row, next_col, path + [val], remaining_steps - 1)
            if candidate_path is not None:
                if best_path is None or candidate_path < best_path:
                    best_path = candidate_path
        
        return best_path
    
    # Try starting from each position, prioritizing smaller starting values
    best_result = None
    
    for start_val, start_row, start_col in start_positions:
        result = dfs(start_row, start_col, [start_val], k - 1)
        if result is not None:
            if best_result is None or result < best_result:
                best_result = result
    
    return best_result
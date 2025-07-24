import heapq

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
    
    # Priority queue: (current_path, row, col)
    # Python's heapq creates a min-heap, so paths will be processed in lexicographical order
    pq = []
    
    # Start from each cell in the grid
    for i in range(n):
        for j in range(n):
            heapq.heappush(pq, ([grid[i][j]], i, j))
    
    # Directions: up, down, left, right
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    
    while pq:
        path, row, col = heapq.heappop(pq)
        
        # If we've reached the desired path length, return it
        if len(path) == k:
            return path
        
        # Try all neighboring cells
        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc
            
            # Check if the new position is within bounds
            if 0 <= new_row < n and 0 <= new_col < n:
                new_path = path + [grid[new_row][new_col]]
                heapq.heappush(pq, (new_path, new_row, new_col))
    
    return []  # This should never happen given the problem constraints
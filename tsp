import sys

# Number of cities
N = 5

# Distance matrix
dist = [
    [0, 10, 15, 20, 25], # Distances from A
    [10, 0, 35, 25, 30], # Distances from B
    [15, 35, 0, 30, 20], # Distances from C
    [20, 25, 30, 0, 15], # Distances from D
    [25, 30, 20, 15, 0]  # Distances from E
]

# Initialize the memoization table
dp = [[-1] * N for _ in range(1 << N)]

def tsp(mask, pos):
    # Base case: all cities have been visited
    if mask == (1 << N) - 1:
        return dist[pos][0] # Return to the starting point

    # If the result is already computed, return it
    if dp[mask][pos] != -1:
        return dp[mask][pos]

    answer = sys.maxsize

    # Try to go to every other city
    for city in range(N):
        if (mask & (1 << city)) == 0:
            new_answer = dist[pos][city] + tsp(mask | (1 << city), city)
            answer = min(answer, new_answer)

    dp[mask][pos] = answer
    return answer

# Start the TSP from the first city (index 0) with mask 1 (only the first city visited)
result = tsp(1, 0)

print("The minimum path distance is:", result)

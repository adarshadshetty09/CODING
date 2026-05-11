# Complete Notes on Time Complexity and Space Complexity

---

# 1. Introduction

When writing programs, we need to know:

1. How fast the program runs
2. How much memory the program uses

These are called:

| Concept          | Meaning                 |
| ---------------- | ----------------------- |
| Time Complexity  | Measures execution time |
| Space Complexity | Measures memory usage   |

These concepts are extremely important in:

* Data Structures
* Algorithms
* Competitive Programming
* System Design
* Technical Interviews

Companies like:

* Google
* Amazon
* Microsoft
* Meta

heavily focus on complexity analysis.

---

# 2. Why Complexity Matters

Suppose you have two algorithms.

Algorithm A:

```text
10 operations
```

Algorithm B:

```text
1,000,000 operations
```

For small inputs both may work.

But when input becomes huge:

```text
n = 1,000,000
```

slow algorithms become unusable.

Complexity helps us:

* choose better algorithms
* optimize programs
* handle large-scale systems
* reduce resource usage

---

# 3. What is Input Size?

Input size is generally represented by:

```text
n
```

Examples:

| Problem        | n Means                  |
| -------------- | ------------------------ |
| Array problem  | Number of elements       |
| String problem | Number of characters     |
| Graph problem  | Number of vertices/nodes |
| Matrix problem | Rows or columns          |

Example:

```python
arr = [1,2,3,4,5]
```

Here:

```text
n = 5
```

---

# 4. What is Time Complexity?

Time Complexity measures:

> How the running time increases as input size increases.

It does NOT measure actual seconds.

It measures:

```text
Growth Rate
```

---

# 5. Big O Notation

We represent complexity using:

```text
Big O Notation
```

Written as:

```text
O(...)
```

Big O describes:

```text
Worst-case growth
```

---

# 6. Common Time Complexities

| Complexity | Name         | Performance    |
| ---------- | ------------ | -------------- |
| O(1)       | Constant     | Excellent      |
| O(log n)   | Logarithmic  | Very Fast      |
| O(n)       | Linear       | Good           |
| O(n log n) | Linearithmic | Efficient      |
| O(n²)      | Quadratic    | Slow           |
| O(2ⁿ)      | Exponential  | Very Slow      |
| O(n!)      | Factorial    | Extremely Slow |

---

# 7. O(1) — Constant Time

An operation takes the same time regardless of input size.

Example:

```python
arr = [10,20,30,40]

print(arr[2])
```

Accessing an index is direct.

Even if array has 1 million elements:

```python
print(arr[2])
```

still takes nearly same time.

---

## Complexity

### Time

```text
O(1)
```

### Space

```text
O(1)
```

---

# 8. O(n) — Linear Time

Operations grow linearly with input.

Example:

```python
for i in range(n):
    print(i)
```

If:

```text
n = 5
```

loop runs 5 times.

If:

```text
n = 100
```

loop runs 100 times.

---

## Complexity

### Time

```text
O(n)
```

### Space

```text
O(1)
```

---

# 9. O(n²) — Quadratic Time

Usually caused by nested loops.

Example:

```python
for i in range(n):
    for j in range(n):
        print(i, j)
```

Operations:

```text
n × n
```

Result:

```text
O(n²)
```

---

## Example

If:

```text
n = 100
```

operations:

```text
100 × 100 = 10,000
```

If:

```text
n = 1000
```

operations:

```text
1,000,000
```

---

# 10. O(log n) — Logarithmic Time

Problem size reduces every step.

Usually happens in:

* Binary Search
* Balanced Trees

Example:

```python
while n > 1:
    n = n // 2
```

Example:

```text
16 → 8 → 4 → 2 → 1
```

Only few steps needed.

---

## Complexity

### Time

```text
O(log n)
```

---

# 11. O(n log n)

Very efficient for sorting.

Used in:

* Merge Sort
* Quick Sort (average)
* Heap Sort

Example idea:

```text
n operations repeated log n times
```

---

# 12. O(2ⁿ) — Exponential

Very slow.

Example:

Recursive Fibonacci.

```python
def fib(n):
    if n <= 1:
        return n

    return fib(n-1) + fib(n-2)
```

Function calls explode rapidly.

---

# 13. O(n!) — Factorial

Worst complexity.

Used in:

* permutation generation
* traveling salesman brute force

Very expensive.

---

# 14. Complexity Order (Fastest to Slowest)

```text
O(1)
O(log n)
O(n)
O(n log n)
O(n²)
O(2ⁿ)
O(n!)
```

---

# 15. Rules for Calculating Time Complexity

---

# Rule 1: Drop Constants

Example:

```python
for i in range(n):
    print(i)

for j in range(n):
    print(j)
```

Operations:

```text
n + n = 2n
```

Ignore constant:

```text
O(n)
```

---

# Rule 2: Nested Loops Multiply

Example:

```python
for i in range(n):
    for j in range(n):
        print(i, j)
```

Complexity:

```text
O(n²)
```

---

# Rule 3: Sequential Loops Add

Example:

```python
for i in range(n):
    print(i)

for j in range(m):
    print(j)
```

Complexity:

```text
O(n + m)
```

---

# Rule 4: Ignore Lower Order Terms

Example:

```text
O(n² + n + 1)
```

Final:

```text
O(n²)
```

Because dominant term matters most.

---

# 16. Best Case, Average Case, Worst Case

---

# Best Case

Minimum operations.

---

# Worst Case

Maximum operations.

Big O usually describes worst case.

---

# Average Case

Average operations.

---

# Example: Linear Search

```python
arr = [1,2,3,4,5]
```

Searching:

```text
1
```

Best case:

```text
O(1)
```

Searching:

```text
5
```

Worst case:

```text
O(n)
```

---

# 17. Space Complexity

Space Complexity measures:

> Extra memory used by algorithm.

Includes:

* variables
* arrays
* recursion stack
* dynamic memory

---

# 18. O(1) Space Complexity

Fixed memory usage.

Example:

```python
a = 10
b = 20
c = a + b
```

Memory does not grow with input.

---

## Space

```text
O(1)
```

---

# 19. O(n) Space Complexity

Memory grows with input.

Example:

```python
arr = []

for i in range(n):
    arr.append(i)
```

Array size grows with `n`.

---

## Space

```text
O(n)
```

---

# 20. Time-Space Tradeoff

Sometimes:

* faster algorithms use more memory
* memory-efficient algorithms are slower

Example:

Using HashMap:

* faster searching
* more memory used

---

# 21. Practical Complexity Analysis

---

# Example 1

```python
for i in range(n):
    print(i)
```

### Time

```text
O(n)
```

### Space

```text
O(1)
```

---

# Example 2

```python
for i in range(n):
    for j in range(n):
        print(i, j)
```

### Time

```text
O(n²)
```

### Space

```text
O(1)
```

---

# Example 3

```python
arr = []

for i in range(n):
    arr.append(i)
```

### Time

```text
O(n)
```

### Space

```text
O(n)
```

---

# Example 4

```python
i = 1

while i < n:
    i *= 2
```

### Time

```text
O(log n)
```

---

# 22. Complexity of Common Operations

| Operation            | Complexity |
| -------------------- | ---------- |
| Array Access         | O(1)       |
| Linear Search        | O(n)       |
| Binary Search        | O(log n)   |
| Insert at End (List) | O(1)       |
| Insert at Beginning  | O(n)       |
| Bubble Sort          | O(n²)      |
| Merge Sort           | O(n log n) |

---

# 23. Complexity in Recursion

Example:

```python
def fun(n):
    if n == 0:
        return

    fun(n-1)
```

Function called `n` times.

### Time

```text
O(n)
```

### Space

```text
O(n)
```

because recursion stack stores function calls.

---

# 24. How to Analyze Complexity

---

# Step 1

Count loops.

---

# Step 2

Check nested loops.

---

# Step 3

Check recursion calls.

---

# Step 4

See whether input halves.

---

# Step 5

Check extra memory usage.

---

# 25. Important Interview Patterns

---

# Single Loop

```python
for i in range(n):
```

Usually:

```text
O(n)
```

---

# Nested Loop

```python
for i in range(n):
    for j in range(n):
```

Usually:

```text
O(n²)
```

---

# Divide by 2

```python
n = n // 2
```

Usually:

```text
O(log n)
```

---

# Recursion

Depends on:

* number of calls
* work inside calls

---

# 26. Real-World Importance

Complexity matters in:

* Search Engines
* Databases
* Social Media
* Banking Systems
* Cloud Computing
* AI Systems

Example:

Searching billions of records requires efficient algorithms.

---

# 27. Most Important Concepts to Master

You should deeply understand:

1. Big O notation
2. Nested loop analysis
3. Binary search complexity
4. Sorting complexities
5. Recursion complexity
6. Space complexity
7. Time-space tradeoff

---

# 28. Common Mistakes Beginners Make

---

## Mistake 1

Thinking actual seconds matter.

Complexity measures growth rate.

---

## Mistake 2

Ignoring nested loops.

---

## Mistake 3

Forgetting recursion stack space.

---

## Mistake 4

Confusing O(log n) with O(n).

---

# 29. Quick Revision Sheet

| Pattern             | Complexity |
| ------------------- | ---------- |
| Access array index  | O(1)       |
| Single loop         | O(n)       |
| Nested loops        | O(n²)      |
| Halving input       | O(log n)   |
| Merge sort          | O(n log n) |
| Recursive Fibonacci | O(2ⁿ)      |

---

# 30. Final Summary

---

# Time Complexity

Measures:

```text
Execution speed growth
```

---

# Space Complexity

Measures:

```text
Memory growth
```

---

# Most Common Complexities

| Complexity | Meaning     |
| ---------- | ----------- |
| O(1)       | Constant    |
| O(log n)   | Very Fast   |
| O(n)       | Linear      |
| O(n²)      | Nested Loop |
| O(2ⁿ)      | Exponential |

---

# Golden Rules

1. Nested loops multiply
2. Sequential loops add
3. Ignore constants
4. Focus on dominant term
5. Halving input means log n

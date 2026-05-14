# Arrays in Python — Complete Deep Dive

In Python, “arrays” can mean different things depending on the context:


| Type          | Used For                        | Example               |
| ------------- | ------------------------------- | --------------------- |
| Python List   | General-purpose collection      | `[1, 2, 3]`           |
| `array`module | Memory-efficient numeric arrays | `array('i', [1,2,3])` |
| NumPy Array   | Fast scientific computing       | `np.array([1,2,3])`   |

For learning Data Structures and Algorithms (DSA), you should start with **Python Lists**, because lists behave like dynamic arrays.

---

# 1. What is an Array?

An array is a collection of elements stored in sequence.

Example:

```python
numbers = [10, 20, 30, 40]
```

Memory visualization:

```text
Index:    0    1    2    3
Value:   10   20   30   40
```

---

# 2. Why Arrays are Important

Arrays are one of the most fundamental data structures.

They are used in:

* Searching
* Sorting
* Matrices
* Dynamic Programming
* Graphs
* Strings
* Databases
* Machine Learning

Almost every DSA problem starts with arrays.

---

# 3. Characteristics of Arrays

## Ordered

Elements keep their order.

```python
arr = [5, 1, 9]
```

`5` stays first.

---

## Indexed

Every element has an index.

```python
arr = [10, 20, 30]

print(arr[0])  # 10
print(arr[1])  # 20
```

---

## Mutable

Arrays/lists can be modified.

```python
arr = [1, 2, 3]

arr[1] = 100

print(arr)
```

Output:

```python
[1, 100, 3]
```

---

## Dynamic Size

Python lists grow automatically.

```python
arr = []

arr.append(10)
arr.append(20)
```

---

# 4. Creating Arrays

## Using List

```python
arr = [1, 2, 3, 4]
```

---

## Empty Array

```python
arr = []
```

---

## Mixed Data Types

Python allows mixed types.

```python
arr = [1, "hello", 3.5]
```

But in DSA, we usually keep same data types.

---

# 5. Accessing Elements

## Positive Indexing

```python
arr = [10, 20, 30]

print(arr[0])
print(arr[2])
```

Output:

```python
10
30
```

---

## Negative Indexing

```python
arr = [10, 20, 30]

print(arr[-1])
print(arr[-2])
```

Output:

```python
30
20
```

---

# 6. Traversing an Array

Traversal means visiting every element.

---

## Method 1 — Using Loop

```python
arr = [10, 20, 30, 40]

for i in arr:
    print(i)
```

---

## Method 2 — Using Index

```python
arr = [10, 20, 30]

for i in range(len(arr)):
    print(arr[i])
```

---

# 7. Array Operations

---

# Insert Operation

## Append at End

```python
arr = [1, 2, 3]

arr.append(4)

print(arr)
```

Output:

```python
[1, 2, 3, 4]
```

Time Complexity:


| Operation | Complexity |
| --------- | ---------- |
| append()  | O(1)       |

---

## Insert at Specific Position

```python
arr = [1, 2, 4]

arr.insert(2, 3)

print(arr)
```

Output:

```python
[1, 2, 3, 4]
```

Time Complexity:


| Operation | Complexity |
| --------- | ---------- |
| insert()  | O(n)       |

Because elements shift.

---

# Delete Operation

## Remove by Value

```python
arr = [1, 2, 3]

arr.remove(2)

print(arr)
```

Output:

```python
[1, 3]
```

---

## Remove by Index

```python
arr = [10, 20, 30]

arr.pop(1)

print(arr)
```

Output:

```python
[10, 30]
```

---

# Searching in Array

---

# Linear Search

Check elements one by one.

```python
arr = [10, 20, 30, 40]

target = 30

for i in range(len(arr)):
  
    if arr[i] == target:
        print("Found at index", i)
```

Time Complexity:

O(n)

---

# Binary Search

Works only on sorted arrays.

Example:

```python
arr = [1, 3, 5, 7, 9]
```

Search middle repeatedly.

Time Complexity:

O(\\log n)

We’ll learn this deeply later.

---

# 8. Updating Elements

```python
arr = [1, 2, 3]

arr[0] = 100

print(arr)
```

Output:

```python
[100, 2, 3]
```

---

# 9. Slicing Arrays

Slicing extracts portions.

Syntax:

```python
arr[start:end:step]
```

---

## Examples

```python
arr = [0,1,2,3,4,5]
```

### First 3 Elements

```python
print(arr[0:3])
```

Output:

```python
[0, 1, 2]
```

---

### Reverse Array

```python
print(arr[::-1])
```

Output:

```python
[5, 4, 3, 2, 1, 0]
```

---

# 10. Important Array Functions


| Function    | Meaning            |
| ----------- | ------------------ |
| `append()`  | Add at end         |
| `insert()`  | Insert at position |
| `remove()`  | Remove value       |
| `pop()`     | Remove by index    |
| `sort()`    | Sort array         |
| `reverse()` | Reverse array      |
| `index()`   | Find index         |
| `count()`   | Count occurrence   |

---

# 11. Sorting Arrays

```python
arr = [5, 2, 1, 9]

arr.sort()

print(arr)
```

Output:

```python
[1, 2, 5, 9]
```

---

# Descending Order

```python
arr.sort(reverse=True)
```

---

# 12. Array Time Complexities


| Operation | Complexity |
| --------- | ---------- |
| Access    | O(1)       |
| Update    | O(1)       |
| Search    | O(n)       |
| Append    | O(1)       |
| Insert    | O(n)       |
| Delete    | O(n)       |

---

# 13. Internal Working of Python Lists

Python lists are:

* Dynamic arrays
* Stored in contiguous memory references
* Automatically resized

When capacity becomes full:

1. Python creates larger memory
2. Copies old elements
3. Adds new element

That’s why append is usually fast.

---

# 14. Real Array Problems

Common interview questions:


| Problem              | Concept            |
| -------------------- | ------------------ |
| Find largest element | Traversal          |
| Reverse array        | Two pointers       |
| Remove duplicates    | Sorting            |
| Rotate array         | Index manipulation |
| Move zeros           | Two pointers       |
| Kadane’s Algorithm  | Maximum subarray   |
| Prefix Sum           | Range queries      |

---

# 15. Difference Between Python List and Real Arrays


| Python List           | Traditional Array |
| --------------------- | ----------------- |
| Dynamic               | Fixed size        |
| Can store mixed types | Same type only    |
| Flexible              | Faster            |
| Easy to use           | Memory efficient  |

---

# 16. Real Array Module in Python

Python also has the built-in `array` module.

```python
from array import array

arr = array('i', [1, 2, 3])
```

`'i'` means integer type.

Unlike lists:

* Stores same data type only
* More memory efficient

---

# 17. 2D Arrays

Arrays inside arrays.

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6]
]
```

Visualization:

```text
1 2 3
4 5 6
```

Access:

```python
print(matrix[1][2])
```

Output:

```python
6
```

---

# 18. Common Mistakes Beginners Make

## Index Out of Range

```python
arr = [1,2,3]

print(arr[5])
```

Error:

```python
IndexError
```

---

## Confusing append and insert

```python
arr.append(5)
```

Adds at end.

```python
arr.insert(0, 5)
```

Adds at beginning.

---

# 19. Practice Problems

Start with these:

1. Find largest element
2. Find smallest element
3. Reverse array
4. Sum of elements
5. Count even/odd
6. Linear search
7. Find second largest
8. Remove duplicates
9. Rotate array
10. Move zeros to end

---

# 20. Most Important Concepts to Master

You should deeply understand:

* Indexing
* Traversal
* Insert/Delete
* Time complexity
* Two pointers
* Sliding window
* Prefix sum

These are core DSA foundations.

---

# 21. Simple Real-World Analogy

Think of an array like:

```text
Apartment Building
```

Each apartment has:

* Position number → Index
* Resident → Value

Example:

```text
Apartment 0 → 10
Apartment 1 → 20
Apartment 2 → 30
```

---

# 22. Mini Practice

Predict output:

```python
arr = [1, 2, 3]

arr.append(4)

arr.insert(1, 100)

arr.pop()

print(arr)
```

Try yourself first.

Answer:

```python
[1, 100, 2, 3]
```

---

# 23. Learning Roadmap for Arrays

Recommended order:

1. Basics
2. Traversal
3. Insert/Delete
4. Searching
5. Sorting
6. Two Pointers
7. Sliding Window
8. Prefix Sum
9. Binary Search
10. Advanced Array Problems

---

# 24. Next Best Topics After Arrays

After mastering arrays:

* Strings
* Sorting
* Searching
* Hashing
* Linked Lists
* Stack
* Queue

---

# 25. Beginner Exercises

## Exercise 1

Find sum of all elements.

```python
arr = [1, 2, 3, 4]
```

Expected Output:

```python
10
```

---

## Exercise 2

Find maximum element.

```python
arr = [5, 9, 1, 3]
```

Expected Output:

```python
9
```

---

## Exercise 3

Reverse the array.

```python
arr = [1, 2, 3]
```

Expected Output:

```python
[3, 2, 1]
```

---

# Final Important Point

In Python DSA:

```python
list = dynamic array
```

So when interviewers say:

> “Solve using arrays”

You will mostly use Python lists.

---

We can continue step by step with:

1. Array traversal problems
2. Array insertion/deletion internally
3. Two pointer technique
4. Sliding window
5. Prefix sum
6. Kadane’s algorithm
7. Binary search on arrays
8. Advanced interview problems

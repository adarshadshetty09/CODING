## All DSA Notes 

The "Finding Missing Elements" problem is a common DSA interview question. Here are the most common variations:

1. Find one missing number (0 to n)

Example:

Input: [3, 0, 1]
Output: 2

Python (Sum method) – O(n) time, O(1) space


```
def missing_number(nums):
    n = len(nums)
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(nums)
    return expected_sum - actual_sum

nums = [3, 0, 1]
print(missing_number(nums))
```

---

2. Using XOR (Best for interviews)

```
def missing_number(nums):
    xor = len(nums)

    for i in range(len(nums)):
        xor ^= i
        xor ^= nums[i]

    return xor

nums = [3, 0, 1]
print(missing_number(nums))
```

Why it works:

a ^ a = 0

a ^ 0 = a

All matching numbers cancel out, leaving only the missing number.



---

3. Find all missing numbers (1 to n)

Example:

Input: [4,3,2,7,8,2,3,1]
Output: [5,6]

```
def find_disappeared_numbers(nums):
    s = set(nums)
    result = []

    for i in range(1, len(nums) + 1):
        if i not in s:
            result.append(i)

    return result

nums = [4,3,2,7,8,2,3,1]
print(find_disappeared_numbers(nums))
```

Time: O(n)
Space: O(n)


---

Interview Tip

For missing element problems, think about these approaches:

1. Sum formula


2. XOR


3. Hash Set


4. Sorting


5. Cyclic Sort (for numbers in the range 1..n)



These cover most interview variations from companies like TCS, Cognizant, Accenture, EPAM, and product-based companies.


The brute force approach checks every possible number to see which one is missing.

Problem

Find the missing number from 0 to n.

Example:

Input: [3, 0, 1]
Output: 2

Brute Force Algorithm

1. Loop from 0 to n.


2. For each number, search the entire array.


3. If the number is not found, return it.



Python Code

```
def missing_number(nums):
    n = len(nums)

    for i in range(n + 1):
        found = False

        for num in nums:
            if num == i:
                found = True
                break

        if not found:
            return i

nums = [3, 0, 1]
print(missing_number(nums))
```

Dry Run

For nums = [3, 0, 1]:

Check 0 → Found ✅

Check 1 → Found ✅

Check 2 → Not Found ❌ → Return 2


Complexity

Time: O(n²) (nested loops)

Space: O(1)


This is the simplest approach to understand. After this, you can optimize it using:

Better: Hash Set → O(n) time, O(n) space

Best: Sum Formula or XOR → O(n) time, O(1) space.

Problem: Maximum Consecutive Ones (LeetCode 485)

Given a binary array (0s and 1s), return the maximum number of consecutive 1s. 

Example

Input:  [1, 1, 0, 1, 1, 1]
Output: 3

Idea

Keep counting consecutive 1s.

When you encounter 0, reset the count to 0.

Keep track of the maximum count seen so far.


Python Code

```

def findMaxConsecutiveOnes(nums):
    count = 0
    max_count = 0

    for num in nums:
        if num == 1:
            count += 1
            max_count = max(max_count, count)
        else:
            count = 0

    return max_count


nums = [1, 1, 0, 1, 1, 1]
print(findMaxConsecutiveOnes(nums))
```

Dry Run

Array:

[1, 1, 0, 1, 1, 1]

Element	count	max_count

1	1	1
1	2	2
0	0	2
1	1	2
1	2	2
1	3	3


Answer = 3

Visualization

Index : 0 1 2 3 4 5
Array : 1 1 0 1 1 1
         ↑ ↑   ↑ ↑ ↑
Count : 1 2 0 1 2 3
Max   : 1 2 2 2 2 3

Complexity

Time: O(n) (single traversal)

Space: O(1)


This is the optimal solution for the problem. 
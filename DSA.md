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


This is the Single Number problem (LeetCode 136).

Problem

Given an array where every element appears twice except one, find the element that appears only once.

Example

Input:  [4, 1, 2, 1, 2]
Output: 4

Optimal Approach (XOR)

Key XOR Properties

a ^ a = 0

a ^ 0 = a

XOR is commutative and associative.


When you XOR all numbers together, the duplicate numbers cancel each other out, leaving only the unique number.

Python Code

```
def single_number(nums):
    result = 0

    for num in nums:
        result ^= num

    return result


nums = [4, 1, 2, 1, 2]
print(single_number(nums))
```

Dry Run

Array:

[4, 1, 2, 1, 2]

Number	Result (XOR)

Start	0
4	0 ^ 4 = 4
1	4 ^ 1 = 5
2	5 ^ 2 = 7
1	7 ^ 1 = 6
2	6 ^ 2 = 4


Final Answer = 4

Visualization

4 ^ 1 ^ 2 ^ 1 ^ 2
      ↓     ↓
     1^1 = 0
           ↓
         2^2 = 0

4 ^ 0 ^ 0 = 4

Complexity

Time: O(n) — one pass through the array.

Space: O(1) — no extra data structures.


This is the most efficient solution and is commonly asked in coding interviews.

That's completely normal. These problems become much easier once you understand the pattern, not just the code.

Let's take the Single Number problem slowly.

Problem

Array = [4, 1, 2, 1, 2]

Every number appears twice except one.

Find that one number.

Method 1: Brute Force (Easy to Understand)

Check each number and count how many times it appears.

4 → appears 1 time ✅ Answer = 4

1 → appears 2 times

2 → appears 2 times


Python:

def single_number(nums):
    for i in nums:
        count = 0

        for j in nums:
            if i == j:
                count += 1

        if count == 1:
            return i

nums = [4, 1, 2, 1, 2]
print(single_number(nums))

Time Complexity: O(n²)


---

Method 2: XOR (Optimal)

Now suppose we don't want to count.

Remember these rules:

5 ^ 5 = 0
7 ^ 7 = 0
0 ^ x = x

Let's XOR all numbers:

4 ^ 1 ^ 2 ^ 1 ^ 2

Pair the duplicates:

4 ^ (1 ^ 1) ^ (2 ^ 2)

Since:

1 ^ 1 = 0
2 ^ 2 = 0

Now:

4 ^ 0 ^ 0 = 4

So the answer is 4.


---

Why does XOR work?

Imagine duplicates "cancel each other."

1 comes twice  → disappears
2 comes twice  → disappears
4 comes once   → remains

That's exactly what XOR does.


---

My suggestion for learning DSA

Don't jump directly to the optimal solution.

For every problem, follow this order:

1. Understand the question.


2. Solve it manually on paper.


3. Write the brute-force solution.


4. Learn the optimized solution and why it works.



This is how most people build intuition.


Yes. This is a very common DSA problem:

> Find the longest subarray whose sum is exactly K = 3.



Let's learn it slowly with an example.

Example

arr = [1, 2, 1, 1, 1]
k = 3

Possible subarrays with sum 3:

[1, 2]          → sum = 3 → length 2
[2, 1]          → sum = 3 → length 2
[1, 1, 1]       → sum = 3 → length 3  ✅

So the answer is:

3

Brute-force approach — easiest to understand


```
def longest_subarray(arr, k):
    max_length = 0

    for i in range(len(arr)):
        total = 0

        for j in range(i, len(arr)):
            total += arr[j]

            if total == k:
                length = j - i + 1
                max_length = max(max_length, length)

    return max_length


arr = [1, 2, 1, 1, 1]
k = 3

print(longest_subarray(arr, k))

```

Output:

3

Visualize it

For:

[1, 2, 1, 1, 1]

When i = 2:

i
       ↓
[1, 2, 1, 1, 1]
      └───────┘
       1+1+1 = 3

Length:

j - i + 1
4 - 2 + 1
= 3

So:

Longest length = 3

Important: This brute-force method is O(n²). After you understand this, the next step is learning the O(n) prefix-sum + hashmap approach, which is the important interview solution.

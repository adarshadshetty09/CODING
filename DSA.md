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
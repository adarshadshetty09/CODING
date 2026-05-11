## 1. `count_digitv0()` — Loop Version

```python
def count_digitv0(n):
    n = abs(n)

    if n == 0:
        return 1

    count = 0
    while n:
        n //= 10
        count += 1

    return count
```

### Time Complexity

The loop runs once for each digit.

If `n` has `d` digits:

[
d = \\lfloor \\log\_{10}(n) \\rfloor + 1
]

So:

[
\\text{Time Complexity} = O(\\log\_{10} n)
]

### Space Complexity

Only a few variables are used (`count`, `n`).

[
\\text{Space Complexity} = O(1)
]

---

## 2. `count_digitv1()` — String Conversion Version

```python
def count_digitv1(n):
    return len(str(abs(n)))
```

### Time Complexity

Operations:

1. `abs(n)` → `O(1)`
2. `str(n)` → converts every digit to character → `O(d)`
3. `len()` → `O(1)`

Overall:

[
\\text{Time Complexity} = O(d)
]

Since:

[
d = \\log\_{10}(n)
]

We can also write:

[
O(\\log n)
]

---

### Space Complexity

`str(abs(n))` creates a new string containing all digits.

If there are `d` digits:

[
\\text{Space Complexity} = O(d)
]

or

[
O(\\log n)
]

---

# Final Comparison


| Version           | Time Complexity | Space Complexity |
| ----------------- | --------------- | ---------------- |
| `count_digitv0()` | `O(log n)`      | `O(1)`           |
| `count_digitv1()` | `O(log n)`      | `O(log n)`       |

---

# Which is Better?

* **Interview / DSA:**
  `count_digitv0()` is preferred because it uses constant space.
* **Real-world Python code:**
  `count_digitv1()` is cleaner and more readable.

# 1. `reverse_numberv0()`

```python
def reverse_numberv0(n):
    n = abs(n)
    rev = 0
  
    while n > 0:
        digit = n % 10
  
        rev = rev * 10 + digit
        n = n // 10
    return rev
```

## Time Complexity

The loop runs once for every digit.

If the number has `d` digits:

[
d = \\lfloor \\log\_{10}(n) \\rfloor + 1
]

So:

[
\\text{Time Complexity} = O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

Only variables (`rev`, `digit`, `n`) are used.

[
\\text{Space Complexity} = O(1)
]

---

# 2. `reverse_numberv1()`

```python
def reverse_numberv1(n):
    sign = -1 if n < 0 else 1
    n = abs(n)

    rev = 0

    while n:
        rev = rev * 10 + (n % 10)
        n //= 10

    return sign * rev
```

## Time Complexity

Again, loop runs once per digit.

[
\\text{Time Complexity} = O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

No extra data structures are created.

[
\\text{Space Complexity} = O(1)
]

---

# 3. String-Based Version

```python
def reverse_number(n):
    sign = -1 if n < 0 else 1
    return sign * int(str(abs(n))[::-1])
```

## Time Complexity

Operations:

1. `abs(n)` → `O(1)`
2. `str(abs(n))` → `O(d)`
3. `[::-1]` slicing → `O(d)`
4. `int()` conversion → `O(d)`

Total:

[
O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

A new reversed string is created.

[
\\text{Space Complexity} = O(d)
]

or

[
O(\\log n)
]

---

# Final Comparison


| Function             | Time Complexity | Space Complexity |
| -------------------- | --------------- | ---------------- |
| `reverse_numberv0()` | `O(log n)`      | `O(1)`           |
| `reverse_numberv1()` | `O(log n)`      | `O(1)`           |
| String version       | `O(log n)`      | `O(log n)`       |

---

# Best Choice

* **For DSA / interviews:**
  `reverse_numberv1()` is best because it is optimized and clean.
* **For production Python code:**
  String version is shortest and very readable.

```python
def is_palindrome(n):
    original = n 
    reverse  = 0
  
    while n > 0:
        digit = n % 10
    
        reverse = reverse * 10 + digit
        n = n // 10
    
    return original == reverse


print(is_palindrome(121))
print(is_palindrome(123))
```

# Time Complexity

The loop runs once for each digit in the number.

If the number has `d` digits:

[
d = \\lfloor \\log\_{10}(n) \\rfloor + 1
]

So:

[
\\text{Time Complexity} = O(d)
]

or simply:

[
O(\\log n)
]

---

# Space Complexity

Only a few variables are used:

* `original`
* `reverse`
* `digit`

No extra data structures are created.

[
\\text{Space Complexity} = O(1)
]

---

# Final Answer


| Complexity Type  | Value      |
| ---------------- | ---------- |
| Time Complexity  | `O(log n)` |
| Space Complexity | `O(1)`     |




# 1. `reverse_number()` (String Method)

```python
def reverse_number(n):
    sign = -1 if n < 0 else 1
    return sign * int(str(abs(n))[::-1])
```

## Time Complexity

Operations:

* `str(abs(n))` → `O(d)`
* `[::-1]` → `O(d)`
* `int()` → `O(d)`

Total:

[
O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

A new reversed string is created.

[
O(d)
]

or

[
O(\\log n)
]

---

# 2. `is_palindromev0()`

```python
def is_palindromev0(n):
    original = n 
    reverse  = 0
  
    while n > 0:
        digit = n % 10
      
        reverse = reverse * 10 + digit
        n = n // 10
      
    return original == reverse
```

## Time Complexity

Loop runs once for every digit.

[
O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

Only variables are used.

[
O(1)
]

---

# 3. `is_palindrome()` (Optimized Full Reverse)

```python
def is_palindrome(n):
    if n < 0:
        return False

    original = n
    reverse = 0

    while n:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return original == reverse
```

## Time Complexity

Still reverses all digits.

[
O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

[
O(1)
]

---

# 4. `is_palindromev2()` (Half Reverse Method)

```python
def is_palindromev2(n):
    if n < 0 or (n % 10 == 0 and n != 0):
        return False

    reverse = 0

    while n > reverse:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return n == reverse or n == reverse // 10
```

---

## Time Complexity

Only half the digits are processed.

If total digits = `d`

Loop runs:

[
d/2
]

times.

So technically:

[
O(d/2)
]

But in Big-O notation constants are ignored:

[
O(d)
]

or

[
O(\\log n)
]

---

## Space Complexity

No extra data structures used.

[
O(1)
]

---

# Final Comparison Table


| Function                   | Time Complexity | Space Complexity |
| -------------------------- | --------------- | ---------------- |
| `reverse_number()`(string) | `O(log n)`      | `O(log n)`       |
| `is_palindromev0()`        | `O(log n)`      | `O(1)`           |
| `is_palindrome()`          | `O(log n)`      | `O(1)`           |
| `is_palindromev2()`        | `O(log n)`      | `O(1)`           |

---

# Best Version

### For Interviews / DSA

✅ `is_palindromev2()`
Because it:

* Reverses only half
* Uses constant space
* Shows optimization skills

### For Readability

✅ `is_palindrome()`
Cleaner and easier to understand.

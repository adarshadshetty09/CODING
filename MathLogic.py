# ==============================
# Count Digits
# ==============================

def count_digits_math(n):
    """
    Count digits using mathematical approach.
    Time  : O(log n)
    Space : O(1)
    """
    n = abs(n)

    if n == 0:
        return 1

    count = 0

    while n:
        n //= 10
        count += 1

    return count


def count_digits_string(n):
    """
    Count digits using string conversion.
    Time  : O(log n)
    Space : O(log n)
    """
    return len(str(abs(n)))


# ==============================
# Reverse Number
# ==============================

def reverse_number_math(n):
    """
    Reverse a number using mathematical approach.
    Time  : O(log n)
    Space : O(1)
    """
    sign = -1 if n < 0 else 1
    n = abs(n)

    reverse = 0

    while n:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return sign * reverse


def reverse_number_string(n):
    """
    Reverse a number using string slicing.
    Time  : O(log n)
    Space : O(log n)
    """
    sign = -1 if n < 0 else 1
    return sign * int(str(abs(n))[::-1])


# ==============================
# Palindrome Number
# ==============================

def is_palindrome(n):
    """
    Check palindrome by reversing full number.
    Time  : O(log n)
    Space : O(1)
    """
    if n < 0:
        return False

    return n == reverse_number_math(n)


def is_palindrome_optimized(n):
    """
    Check palindrome using half-reversal method.
    More optimized for large numbers.

    Time  : O(log n)
    Space : O(1)
    """
    if n < 0 or (n % 10 == 0 and n != 0):
        return False

    reverse = 0

    while n > reverse:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return n == reverse or n == reverse // 10


# ==============================
# Armstrong Number
# ==============================

def is_armstrong(n):
    """
    Check whether a number is an Armstrong number.

    Example:
    153 = 1³ + 5³ + 3³

    Time  : O(log n)
    Space : O(1)
    """
    if n < 0:
        return False

    original = n
    digits = count_digits_math(n)

    total = 0

    while n:
        digit = n % 10
        total += digit ** digits
        n //= 10

    return total == original


# ==============================
# Test Cases
# ==============================

print("Count Digits")
print(count_digits_math(1231231))
print(count_digits_math(0))
print(count_digits_math(-9876))

print()

print("Reverse Number")
print(reverse_number_math(54321))
print(reverse_number_math(-12345))
print(reverse_number_math(1000))
print(reverse_number_math(0))

print()

print("Palindrome")
print(is_palindrome(121))
print(is_palindrome(123))
print(is_palindrome(-121))
print(is_palindrome(0))

print()

print("Optimized Palindrome")
print(is_palindrome_optimized(121))
print(is_palindrome_optimized(123))

print()

print("Armstrong")
print(is_armstrong(153))
print(is_armstrong(123))
# =========================================================
# NUMBER PROGRAMS - CLEAN & READABLE VERSION
# =========================================================


# =========================================================
# Count Digits
# =========================================================

def count_digits_math(n):
    """
    Count digits using mathematical approach.

    Time Complexity  : O(log n)
    Space Complexity : O(1)
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

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """
    return len(str(abs(n)))


# =========================================================
# Reverse Number
# =========================================================

def reverse_number_math(n):
    """
    Reverse a number using mathematical approach.

    Time Complexity  : O(log n)
    Space Complexity : O(1)
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

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """
    sign = -1 if n < 0 else 1

    return sign * int(str(abs(n))[::-1])


# =========================================================
# Palindrome Number
# =========================================================

def is_palindrome(n):
    """
    Check palindrome by reversing the full number.

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """
    if n < 0:
        return False

    return n == reverse_number_math(n)


def is_palindrome_optimized(n):
    """
    Check palindrome using half-reversal method.

    More optimized for large numbers.

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """
    if n < 0 or (n % 10 == 0 and n != 0):
        return False

    reverse = 0

    while n > reverse:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return n == reverse or n == reverse // 10


# =========================================================
# Armstrong Number
# =========================================================

def is_armstrong(n):
    """
    Check whether a number is an Armstrong number.

    Example:
    153 = 1³ + 5³ + 3³

    Time Complexity  : O(log n)
    Space Complexity : O(1)
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


# =========================================================
# Prime Number
# =========================================================

def is_prime_basic(n):
    """
    Check prime number using brute-force approach.

    Time Complexity  : O(n)
    Space Complexity : O(1)
    """
    if n <= 1:
        return False

    count = 0

    for i in range(1, n + 1):

        if n % i == 0:
            count += 1

    return count == 2


def is_prime_optimized(n):
    """
    Optimized prime number check.

    Checks divisibility only till sqrt(n).

    Time Complexity  : O(sqrt(n))
    Space Complexity : O(1)
    """
    if n <= 1:
        return False

    i = 2

    while i * i <= n:

        if n % i == 0:
            return False

        i += 1

    return True


# =========================================================
# Factors / Divisors of a Number
# =========================================================

def find_factors_basic(n):
    """
    Find factors using brute-force approach.

    Time Complexity  : O(n)
    Space Complexity : O(k)

    where k = number of factors
    """
    factors = []

    for i in range(1, n + 1):

        if n % i == 0:
            factors.append(i)

    return factors


def find_factors_optimized(n):
    """
    Find factors using optimized sqrt(n) approach.

    Time Complexity  : O(sqrt(n) * log k)
    Space Complexity : O(k)

    where k = number of factors
    """
    factors = []

    i = 1

    while i * i <= n:

        if n % i == 0:

            factors.append(i)

            if i != n // i:
                factors.append(n // i)

        i += 1

    return sorted(factors)


# =========================================================
# TEST CASES
# =========================================================

print("========== COUNT DIGITS ==========")
print(count_digits_math(1231231))
print(count_digits_math(0))
print(count_digits_math(-9876))

print()

print(count_digits_string(1231231))
print(count_digits_string(0))
print(count_digits_string(-9876))

print()


print("========== REVERSE NUMBER ==========")
print(reverse_number_math(54321))
print(reverse_number_math(-12345))
print(reverse_number_math(1000))
print(reverse_number_math(0))

print()

print(reverse_number_string(54321))
print(reverse_number_string(-12345))

print()


print("========== PALINDROME ==========")
print(is_palindrome(121))
print(is_palindrome(123))
print(is_palindrome(-121))
print(is_palindrome(0))

print()


print("========== OPTIMIZED PALINDROME ==========")
print(is_palindrome_optimized(121))
print(is_palindrome_optimized(123))

print()


print("========== ARMSTRONG NUMBER ==========")
print(is_armstrong(153))
print(is_armstrong(123))

print()


print("========== PRIME NUMBER ==========")
print(is_prime_basic(7))
print(is_prime_basic(10))

print()

print(is_prime_optimized(7))
print(is_prime_optimized(10))
print(is_prime_optimized(13))

print()


print("========== FACTORS / DIVISORS ==========")
print(find_factors_basic(12))
print(find_factors_basic(15))
print(find_factors_basic(14))
print(find_factors_basic(17))
print(find_factors_basic(36))

print()


print("========== OPTIMIZED FACTORS ==========")
print(find_factors_optimized(14))
print(find_factors_optimized(17))
print(find_factors_optimized(36))
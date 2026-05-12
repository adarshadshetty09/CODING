# =========================================================
# NUMBER PROGRAMS - CLEAN & INTERVIEW-READY VERSION
# =========================================================


# =========================================================
# COUNT DIGITS
# =========================================================

def count_digits_math(n):
    """
    Count digits using mathematical approach.

    Logic:
    - Remove digits one by one using integer division.
    - Every division by 10 removes the last digit.
    - Count how many times division happens.

    Example:
    1234 -> 123 -> 12 -> 1 -> 0

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Convert negative number to positive
    n = abs(n)

    # Special case for 0
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

    Logic:
    - Convert number into string
    - Return length of string

    Example:
    1234 -> "1234" -> length = 4

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    return len(str(abs(n)))


# =========================================================
# REVERSE NUMBER
# =========================================================

def reverse_number_math(n):
    """
    Reverse number using mathematical approach.

    Logic:
    - Extract last digit using modulus (% 10)
    - Add digit to reverse number
    - Remove last digit using // 10

    Example:
    123

    reverse = 0
    reverse = 0 * 10 + 3 = 3
    reverse = 3 * 10 + 2 = 32
    reverse = 32 * 10 + 1 = 321

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    sign = -1 if n < 0 else 1
    n = abs(n)

    reverse = 0

    while n:
        digit = n % 10
        reverse = reverse * 10 + digit
        n //= 10

    return sign * reverse


def reverse_number_string(n):
    """
    Reverse number using string slicing.

    Logic:
    - Convert number into string
    - Reverse string using slicing
    - Convert back to integer

    Example:
    "1234" -> "4321"

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    sign = -1 if n < 0 else 1

    return sign * int(str(abs(n))[::-1])


# =========================================================
# PALINDROME NUMBER
# =========================================================

def is_palindrome(n):
    """
    Check palindrome by reversing the full number.

    Logic:
    - Reverse the number
    - Compare reversed number with original number

    Example:
    121 -> reverse = 121 -> palindrome

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Negative numbers are not palindrome
    if n < 0:
        return False

    return n == reverse_number_math(n)


def is_palindrome_optimized(n):
    """
    Optimized palindrome check using half reversal.

    Logic:
    - Reverse only half of the digits
    - Compare both halves

    Example:
    1221

    First half  = 12
    Second half = 12

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Negative numbers are not palindrome
    # Numbers ending with 0 are not palindrome
    if n < 0 or (n % 10 == 0 and n != 0):
        return False

    reverse = 0

    # Reverse only half
    while n > reverse:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    # Handles both even and odd digit counts
    return n == reverse or n == reverse // 10


# =========================================================
# ARMSTRONG NUMBER
# =========================================================

def is_armstrong(n):
    """
    Check whether a number is Armstrong number.

    Logic:
    - Count total digits
    - Raise every digit to power of total digits
    - Add all powered digits
    - Compare with original number

    Example:
    153

    1³ + 5³ + 3³
    = 1 + 125 + 27
    = 153

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
# PRIME NUMBER
# =========================================================

def is_prime_basic(n):
    """
    Prime check using brute-force approach.

    Logic:
    - Count total divisors
    - Prime number has exactly 2 divisors:
      1 and itself

    Example:
    7 -> divisors = 1, 7

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
    Optimized prime check.

    Logic:
    - Factors always occur in pairs
    - Check divisibility only till sqrt(n)

    Example:
    36

    Factor pairs:
    (1,36)
    (2,18)
    (3,12)
    (4,9)
    (6,6)

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
# FACTORS / DIVISORS OF A NUMBER
# =========================================================

def find_factors_basic(n):
    """
    Find factors using brute-force approach.

    Logic:
    - Check every number from 1 to n
    - If perfectly divisible, it is a factor

    Example:
    12 -> 1,2,3,4,6,12

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
    Find factors using sqrt(n) optimization.

    Logic:
    - Factors always come in pairs

    Example:
    36

    1 × 36
    2 × 18
    3 × 12
    4 × 9
    6 × 6

    So check only till sqrt(n)

    Time Complexity  : O(sqrt(n) * log k)
    Space Complexity : O(k)

    where k = number of factors
    """

    factors = []

    i = 1

    while i * i <= n:

        if n % i == 0:

            factors.append(i)

            # Avoid duplicate factors for perfect square
            if i != n // i:
                factors.append(n // i)

        i += 1

    return sorted(factors)


# =========================================================
# GREATEST COMMON DIVISOR (GCD)
# =========================================================

def gcd_bruteforce(a, b):
    """
    Find GCD using brute-force approach.

    Logic:
    - Find all common divisors
    - Largest common divisor is GCD

    Example:
    12 -> 1,2,3,4,6,12
    18 -> 1,2,3,6,9,18

    GCD = 6

    Time Complexity  : O(min(a, b))
    Space Complexity : O(1)
    """

    limit = min(a, b)
    ans = 1

    for i in range(1, limit + 1):

        if a % i == 0 and b % i == 0:
            ans = i

    return ans


def gcd_optimized(a, b):
    """
    Find GCD using Euclidean Algorithm.

    Logic:
    gcd(a, b) = gcd(b, a % b)

    Keep replacing:
    a = b
    b = remainder

    until remainder becomes 0

    Example:
    gcd(48,18)

    48 % 18 = 12
    18 % 12 = 6
    12 % 6 = 0

    GCD = 6

    Time Complexity  : O(log(min(a, b)))
    Space Complexity : O(1)
    """

    while b:
        a, b = b, a % b

    return a


def gcd_recursive(a, b):
    """
    Recursive Euclidean Algorithm.

    Logic:
    - Same as iterative approach
    - Uses recursion instead of loop

    Time Complexity  : O(log(min(a, b)))
    Space Complexity : O(log(min(a, b)))
    """

    if b == 0:
        return a

    return gcd_recursive(b, a % b)


# =========================================================
# LEAST COMMON MULTIPLE (LCM)
# =========================================================

def lcm_bruteforce(a, b):
    """
    Find LCM using brute-force approach.

    Logic:
    - Start from greater number
    - Find first number divisible by both

    Example:
    4,6

    Multiples of 4:
    4,8,12...

    Multiples of 6:
    6,12...

    LCM = 12

    Time Complexity  : O(lcm(a, b))
    Space Complexity : O(1)
    """

    greater = max(a, b)

    while True:

        if greater % a == 0 and greater % b == 0:
            return greater

        greater += 1


def lcm_optimized(a, b):
    """
    Find LCM using GCD formula.

    Formula:
    LCM(a,b) × GCD(a,b) = a × b

    Therefore:
    LCM(a,b) = (a × b) // GCD(a,b)

    Time Complexity  : O(log(min(a, b)))
    Space Complexity : O(1)
    """

    return (a * b) // gcd_optimized(a, b)


def lcm_safe(a, b):
    """
    Safe LCM implementation.

    Logic:
    - Handles zero values
    - Handles negative numbers
    - Uses absolute value

    Time Complexity  : O(log(min(a, b)))
    Space Complexity : O(1)
    """

    if a == 0 or b == 0:
        return 0

    return abs(a * b) // gcd_optimized(a, b)


# =========================================================
# PERFECT NUMBER
# =========================================================

def is_perfect_number(n):
    """
    Check whether number is perfect number.

    Logic:
    - Add all proper divisors
    - If sum equals original number,
      then it is perfect number

    Example:
    6

    Proper divisors:
    1,2,3

    Sum = 6

    Time Complexity  : O(n)
    Space Complexity : O(1)
    """

    if n <= 1:
        return False

    total = 0

    for i in range(1, n):

        if n % i == 0:
            total += i

    return total == n


# =========================================================
# FACTORIAL
# =========================================================

def factorial(n):
    """
    Find factorial of a number.

    Logic:
    - Multiply all numbers from 1 to n

    Example:
    5!
    = 5 × 4 × 3 × 2 × 1
    = 120

    Time Complexity  : O(n)
    Space Complexity : O(1)
    """

    result = 1

    for i in range(1, n + 1):
        result *= i

    return result


# =========================================================
# STRONG NUMBER
# =========================================================

def is_strong_number(n):
    """
    Check whether number is strong number.

    Logic:
    - Find factorial of every digit
    - Add all factorials
    - Compare with original number

    Example:
    145

    1! + 4! + 5!
    = 1 + 24 + 120
    = 145

    Time Complexity  : O(d)
    Space Complexity : O(1)
    """

    if n < 0:
        return False

    original = n
    total = 0

    while n:

        digit = n % 10
        total += factorial(digit)

        n //= 10

    return total == original


# =========================================================
# OPTIMIZED STRONG NUMBER
# =========================================================

# Precompute factorials from 0 to 9
factorials = [1] * 10

for i in range(1, 10):
    factorials[i] = factorials[i - 1] * i


def is_strong_number_optimized(n):
    """
    Optimized strong number check.

    Logic:
    - Store factorials beforehand
    - Avoid recalculating factorial repeatedly

    Example:
    factorials[5] = 120

    Time Complexity  : O(d)
    Space Complexity : O(1)
    """

    if n < 0:
        return False

    original = n
    total = 0

    while n:

        digit = n % 10
        total += factorials[digit]

        n //= 10

    return total == original

# =========================================================
# FIBONACCI SERIES
# =========================================================

def fibonacci(n):
    """
    Print Fibonacci series.

    Logic:
    - Fibonacci sequence starts with:
      0, 1

    - Every next number is sum of previous two numbers.

    Formula:
    next_number = a + b

    Example:
    0 1 1 2 3 5 8

    Step-by-step:
    a = 0
    b = 1

    next = 0 + 1 = 1
    next = 1 + 1 = 2
    next = 1 + 2 = 3

    Time Complexity  : O(n)
    Space Complexity : O(1)
    """

    a = 0
    b = 1

    for _ in range(n):

        print(a, end=" ")

        next_number = a + b

        a = b
        b = next_number


# =========================================================
# FIBONACCI USING LIST
# =========================================================

def fibonacci_list(n):
    """
    Generate Fibonacci series using list.

    Logic:
    - Store Fibonacci numbers inside list
    - Every next number is sum of previous two numbers

    Example:
    fib[0] = 0
    fib[1] = 1

    fib[2] = fib[1] + fib[0]
    fib[3] = fib[2] + fib[1]

    Output:
    [0,1,1,2,3,5,8...]

    Time Complexity  : O(n)
    Space Complexity : O(n)
    """

    fib = [0, 1]

    for i in range(2, n):

        fib.append(fib[i - 1] + fib[i - 2])

    return fib


# =========================================================
# DECIMAL TO BINARY CONVERSION
# =========================================================

def decimal_to_binary(n):
    """
    Convert decimal number to binary.

    Logic:
    - Divide number by 2 repeatedly
    - Store remainders
    - Read remainders in reverse order

    Example:
    13

    13 % 2 = 1
     6 % 2 = 0
     3 % 2 = 1
     1 % 2 = 1

    Binary = 1101

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    if n == 0:
        return "0"

    binary = ""

    while n > 0:

        remainder = n % 2

        binary += str(remainder)

        n //= 2

    # Reverse because remainders come backward
    return binary[::-1]


# =========================================================
# DECIMAL TO BINARY - OPTIMIZED VERSION
# =========================================================

def decimal_to_binary_optimized(n):
    """
    Optimized decimal to binary conversion.

    Logic:
    - Store binary digits inside list
    - Join list at the end
    - Faster than repeated string concatenation

    Why Better?
    - Strings are immutable in Python
    - List append is more efficient

    Example:
    13 -> 1101

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    if n == 0:
        return "0"

    binary = []

    while n > 0:

        binary.append(str(n % 2))

        n //= 2

    return ''.join(binary[::-1])


# =========================================================
# BINARY TO DECIMAL CONVERSION
# =========================================================

def binary_to_decimal(binary):
    """
    Convert binary to decimal.

    Logic:
    - Traverse binary digits from right to left
    - Multiply each digit with powers of 2
    - Add all values

    Example:
    1101

    = 1×2³ + 1×2² + 0×2¹ + 1×2⁰
    = 8 + 4 + 0 + 1
    = 13

    Time Complexity  : O(n)
    Space Complexity : O(1)
    """

    power = 0
    decimal = 0

    # Traverse from right to left
    for digit in binary[::-1]:

        decimal += int(digit) * (2 ** power)

        power += 1

    return decimal


# =========================================================
# BINARY TO DECIMAL - ALTERNATIVE METHOD
# =========================================================

def binary_to_decimal_alt(binary):
    """
    Convert binary to decimal using mathematical approach.

    Logic:
    - Extract digits using modulus (% 10)
    - Multiply digits with powers of 2
    - Add all values

    Example:
    1101

    1 × 2⁰ = 1
    0 × 2¹ = 0
    1 × 2² = 4
    1 × 2³ = 8

    Total = 13

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    decimal = 0
    power = 0

    while binary > 0:

        digit = binary % 10

        decimal += digit * (2 ** power)

        power += 1

        binary //= 10

    return decimal


# =========================================================
# Automorphic Number
# =========================================================

def count_digits(n):
    
    if n == 0:
        return 1 
    
    count = 0
    
    while n: 
        n //= 10
        count += 1 
    return count

def is_automorphic(n):
    
    if n < 0:
        return False
    square = n * n 
    
    digits = count_digits(n)
    divisor = 10 ** digits
    
    return square % divisor == n 


# =========================================================
# Neon Number
# =========================================================

def is_neon_number(n):
    
    if n < 0:
        return False
    
    square = n * n 
    
    total = 0
    
    while square:
        
        digit = square % 10 
        total += digit
        
        square //= 10 
    return total == n


# =========================================================
# Neon Number / Better Version
# =========================================================

def is_neon_number_better(n):
    
    if n < 0:
        return False
    
    sqaure = n * n 
    
    if sqaure == 0:
        return True
    
    total = 0 
    
    while sqaure:
        total += sqaure % 10 
        sqaure //= 10 
    return total == n


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

print()


print("========== GCD - BRUTE FORCE ==========")

print(gcd_bruteforce(12, 18))

print()


print("========== GCD - OPTIMIZED ==========")

print(gcd_optimized(48, 18))

print()


print("========== GCD - RECURSIVE ==========")

print(gcd_recursive(48, 18))

print()


print("========== LCM - BRUTE FORCE ==========")

print(lcm_bruteforce(4, 6))

print()


print("========== LCM - OPTIMIZED ==========")

print(lcm_optimized(12, 18))

print()


print("========== LCM - SAFE VERSION ==========")

print(lcm_safe(12, 18))
print(lcm_safe(0, 5))
print(lcm_safe(-4, 6))

print()


print("========== PERFECT NUMBER ==========")

print(is_perfect_number(6))
print(is_perfect_number(28))
print(is_perfect_number(12))

print()


print("========== STRONG NUMBER ==========")

print(is_strong_number(145))
print(is_strong_number(123))

print()


print("========== OPTIMIZED STRONG NUMBER ==========")

print(is_strong_number_optimized(145))
print(is_strong_number_optimized(123))


print()


print("========== Fibonacci Series ==========")
print(fibonacci(7))

print()
print("========== Fibonacci Series List ==========")
print(fibonacci_list(10))

print()
print("========== Decimal to Binary Conversion ==========")
print(decimal_to_binary(13))
print(decimal_to_binary(8))
print(decimal_to_binary(5))

print()
print("========== Decimal to Binary Conversion/Optimized Version ==========")
print(decimal_to_binary_optimized(13))
print(decimal_to_binary_optimized(8))
print(decimal_to_binary_optimized(5))

print()
print("========== Binary to Decimal Conversion  ==========")
print(binary_to_decimal("1101"))
print(binary_to_decimal("1011"))

print()
print("========== Binary to Decimal Conversion Aleternate Method ==========")
print(binary_to_decimal_alt(1101))
print(binary_to_decimal_alt(1011))


print()
print("========== Automorphic Number ==========")
print(is_automorphic(5))
print(is_automorphic(25))
print(is_automorphic(7))

print()
print("========== Neon Number ==========")
print(is_neon_number(9))
print(is_neon_number(7))

print()
print("========== Neon Number Better Version==========")
print(is_neon_number_better(9))
print(is_neon_number_better(7))
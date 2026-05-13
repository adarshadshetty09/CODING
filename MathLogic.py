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

# =========================================================
# AUTOMORPHIC NUMBER
# =========================================================

def is_automorphic(n):
    """
    Check whether number is Automorphic Number.

    Logic:
    - Find square of number
    - Check whether square ends with same digits as number

    Example:
    25

    Square:
    25² = 625

    Ends with:
    25

    So 25 is Automorphic Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    if n < 0:
        return False

    square = n * n

    digits = count_digits_math(n)

    divisor = 10 ** digits

    return square % divisor == n


# =========================================================
# Neon Number
# =========================================================

# =========================================================
# NEON NUMBER
# =========================================================

def is_neon_number(n):
    """
    Check whether number is Neon Number.

    Logic:
    - Find square of number
    - Add digits of square
    - Compare sum with original number

    Example:
    9

    Square:
    9² = 81

    Digit Sum:
    8 + 1 = 9

    So 9 is Neon Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    if n < 0:
        return False

    square = n * n

    total = 0

    while square:

        total += square % 10

        square //= 10

    return total == n






# =========================================================
# NEON NUMBER - OPTIMIZED VERSION
# =========================================================

"""
A number is called a Neon Number if:

Sum of digits of square of the number
equals the original number.
"""


def is_neon_number_better(n):
    """
    Check whether number is Neon Number.

    Logic:
    - Find square of number
    - Extract digits of square
    - Add all digits
    - Compare sum with original number

    Formula:
    digit_sum(n²) == n

    Example:
    9

    Step 1:
    9² = 81

    Step 2:
    Digit Sum:
    8 + 1 = 9

    Step 3:
    9 == 9

    So 9 is Neon Number

    Example:
    1

    1² = 1

    Digit Sum:
    1

    So 1 is also Neon Number

    Why is this optimized?
    - Uses mathematical digit extraction
    - No string conversion used
    - Constant extra space

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Negative numbers are not Neon numbers
    if n < 0:
        return False

    # Find square of number
    square = n * n

    # Special case for 0
    if square == 0:
        return True

    total = 0

    while square:

        # Extract last digit
        digit = square % 10

        # Add digit to total
        total += digit

        # Remove last digit
        square //= 10

    # Compare with original number
    return total == n




# =========================================================
# HARSHAD NUMBER (NIVEN NUMBER)
# =========================================================

"""
A number is called a Harshad Number
(or Niven Number) if:

The number is divisible by
the sum of its digits.
"""


def is_harshad_number(n):
    """
    Check whether number is Harshad Number.

    Logic:
    - Find sum of digits
    - Check whether original number
      is divisible by digit sum
    - If divisible, then it is
      Harshad Number

    Formula:
    number % digit_sum == 0

    Example:
    18

    Step 1:
    Digit Sum:
    1 + 8 = 9

    Step 2:
    18 % 9 == 0

    Since remainder is 0,
    18 is Harshad Number

    Example:
    21

    Digit Sum:
    2 + 1 = 3

    21 % 3 == 0

    So 21 is also Harshad Number

    Example:
    19

    Digit Sum:
    1 + 9 = 10

    19 % 10 != 0

    So 19 is NOT Harshad Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Harshad numbers are positive integers
    if n <= 0:
        return False

    original = n

    digit_sum = 0

    while n:

        # Extract last digit
        digit = n % 10

        # Add digit to digit sum
        digit_sum += digit

        # Remove last digit
        n //= 10

    # Check divisibility condition
    return original % digit_sum == 0


    
# =========================================================
# SPY NUMBER
# =========================================================

"""
A number is called a Spy Number if:

Sum of digits equals
product of digits.
"""


def is_spy_number(n):
    """
    Check whether number is Spy Number.

    Logic:
    - Extract digits one by one
    - Find:
        1. Sum of digits
        2. Product of digits
    - Compare both values

    Formula:
    sum_of_digits == product_of_digits

    Example:
    123

    Sum:
    1 + 2 + 3 = 6

    Product:
    1 × 2 × 3 = 6

    Both are equal.

    So 123 is Spy Number

    Example:
    1124

    Sum:
    1 + 1 + 2 + 4 = 8

    Product:
    1 × 1 × 2 × 4 = 8

    So 1124 is also Spy Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Negative numbers are not Spy numbers
    if n < 0:
        return False

    digit_sum = 0

    digit_product = 1

    while n:

        # Extract last digit
        digit = n % 10

        # Add digit to sum
        digit_sum += digit

        # Multiply digit to product
        digit_product *= digit

        # Remove last digit
        n //= 10

    # Compare sum and product
    return digit_sum == digit_product





    
# =========================================================
# DUCK NUMBER
# =========================================================

"""
A Duck Number is:

A number containing at least one zero,
but NOT starting with zero.
"""


def is_duck_number(n):
    """
    Check whether number is Duck Number.

    Logic:
    - Extract digits one by one using % 10
    - If any digit becomes 0,
      then it is Duck Number

    Example:
    1023

    Digits:
    3 → 2 → 0 → 1

    Contains zero.

    So 1023 is Duck Number

    Example:
    321

    Digits:
    1 → 2 → 3

    No zero found.

    So not a Duck Number

    Note:
    Mathematical approach cannot detect
    leading zeros because integers do not
    store leading zeros.

    Example:
    0123 becomes 123 internally.

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Duck numbers are positive integers
    if n <= 0:
        return False

    while n:

        # Extract last digit
        digit = n % 10

        # Check whether digit is 0
        if digit == 0:
            return True

        # Remove last digit
        n //= 10

    return False

# =========================================================
# DUCK NUMBER
# =========================================================

"""
A Duck Number is:

A number containing at least one zero,
but NOT starting with zero.
"""


def is_duck_number(n):
    """
    Check whether number is Duck Number.

    Logic:
    - Convert number into string
    - Check whether:
        1. Number contains at least one '0'
        2. Number does not start with '0'

    Example:
    1023

    Contains:
    0

    Does not start with:
    0

    So 1023 is Duck Number

    Example:
    321

    No zero present.

    So not a Duck Number

    Example:
    0123

    Starts with zero.

    So not a Duck Number

    Why use string approach?
    - Cleaner and more readable
    - Easier to check leading zero
    - Avoids extra mathematical logic

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    # Duck numbers are positive integers
    if n <= 0:
        return False

    # Convert number into string
    number = str(n)

    # Check Duck Number condition
    return '0' in number and number[0] != '0'





# =========================================================
# SUNNY NUMBER
# =========================================================

"""
A number is called a Sunny Number if:

n + 1 is a perfect square.
"""

import math


def is_sunny_number(n):
    """
    Check whether number is Sunny Number.

    Logic:
    - Add 1 to the number
    - Find square root of resulting value
    - If square root is a whole number,
      then it is Sunny Number

    Formula:
    n + 1 = perfect square

    Example:
    8

    8 + 1 = 9

    √9 = 3

    3 × 3 = 9

    Since 9 is a perfect square,
    8 is Sunny Number

    Example:
    15

    15 + 1 = 16

    √16 = 4

    4 × 4 = 16

    So 15 is also Sunny Number

    Time Complexity  : O(1)
    Space Complexity : O(1)
    """

    # Negative numbers are not Sunny numbers
    if n < 0:
        return False

    # Add 1 to number
    value = n + 1

    # Find square root
    root = int(math.sqrt(value))

    # Check perfect square condition
    return root * root == value


# =========================================================
# PETERSON NUMBER
# =========================================================

"""
A number is called a Peterson Number if:

Sum of factorials of digits equals
the original number.

Note:
Peterson Number and Strong Number
are the same concept.
"""


# Precompute factorials from 0 to 9
# to avoid repeated factorial calculations
factorials = [1] * 10

for i in range(1, 10):

    factorials[i] = factorials[i - 1] * i


def is_peterson_number(n):
    """
    Check whether number is Peterson Number.

    Logic:
    - Extract digits one by one
    - Find factorial of each digit
    - Add all factorial values
    - Compare total with original number

    Example:
    145

    1! + 4! + 5!
    = 1 + 24 + 120
    = 145

    Equals original number.

    So 145 is Peterson Number

    Why use precomputed factorials?
    - Digits are only from 0 to 9
    - Avoid repeated factorial calculation
    - Improves performance

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Negative numbers are not Peterson numbers
    if n < 0:
        return False

    original = n

    total = 0

    while n:

        # Extract last digit
        digit = n % 10

        # Add factorial of digit
        total += factorials[digit]

        # Remove last digit
        n //= 10

    # Compare with original number
    return total == original




# =========================================================
# DISARIUM NUMBER
# =========================================================

def is_disarium_number(n):
    """
    Check whether number is Disarium Number.

    Logic:
    - Convert number into string
    - Traverse digits with their positions
    - Raise each digit to its position
    - Add all powered values
    - Compare total with original number

    Formula:
    digit¹ + digit² + digit³ + ...

    Example:
    135

    1¹ + 3² + 5³
    = 1 + 9 + 125
    = 135

    Equals original number.

    So 135 is Disarium Number

    Example:
    89

    8¹ + 9²
    = 8 + 81
    = 89

    So 89 is also Disarium Number

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    # Negative numbers are not Disarium numbers
    if n < 0:
        return False

    # Convert number into string
    digits = str(n)

    total = 0

    # Enumerate gives:
    # position and digit together
    # start=1 because positions begin from 1
    for position, digit in enumerate(digits, start=1):

        # Raise digit to its position
        total += int(digit) ** position

    # Compare with original number
    return total == n

# =========================================================
# HAPPY NUMBER
# =========================================================


def square_digit_sum(n):
    """
    Find sum of squares of digits.

    Logic:
    - Extract digits one by one using % 10
    - Square each digit
    - Add squared values
    - Remove last digit using // 10

    Example:
    19

    1² + 9²
    = 1 + 81
    = 82

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    total = 0

    while n:

        # Extract last digit
        digit = n % 10

        # Add square of digit
        total += digit * digit

        # Remove last digit
        n //= 10

    return total


def is_happy_number(n):
    """
    Check whether number is Happy Number.

    Logic:
    - Replace number with sum of squares of digits
    - Repeat the process
    - If number becomes 1 -> Happy Number
    - If number repeats again -> Not Happy Number

    Why use set?
    - To detect infinite loops
    - Non-happy numbers eventually repeat

    Example:
    19

    Step 1:
    1² + 9² = 82

    Step 2:
    8² + 2² = 68

    Step 3:
    6² + 8² = 100

    Step 4:
    1² + 0² + 0² = 1

    Since it becomes 1,
    19 is Happy Number.

    Example of Non-Happy Number:
    4

    4² = 16
    1² + 6² = 37
    3² + 7² = 58
    5² + 8² = 89
    ...

    Eventually repeats again.

    Time Complexity  : O(log n)
    Space Complexity : O(log n)
    """

    # Happy numbers are positive integers
    if n <= 0:
        return False

    # Store visited numbers to detect loop
    visited = set()

    # Continue until number becomes 1
    # or loop repeats
    while n != 1 and n not in visited:

        visited.add(n)

        n = square_digit_sum(n)

    return n == 1

# =========================================================
# KAPREKAR NUMBER
# =========================================================


def count_digits(n):
    """
    Count digits in a number.

    Logic:
    - Remove digits one by one using // 10
    - Count how many times division happens

    Example:
    1234

    1234 -> 123 -> 12 -> 1 -> 0

    Total digits = 4

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    if n == 0:
        return 1

    count = 0

    while n:

        count += 1

        n //= 10

    return count


def is_kaprekar_number(n):
    """
    Check whether number is Kaprekar Number.

    Logic:
    - Find square of number
    - Count digits in original number
    - Split square into two parts
    - Add both parts
    - Compare with original number

    Formula:
    left_part + right_part == original_number

    Example:
    45

    Step 1:
    45² = 2025

    Step 2:
    Digits in 45 = 2

    Step 3:
    Split square using divisor = 10² = 100

    Left  = 2025 // 100 = 20
    Right = 2025 % 100 = 25

    Step 4:
    20 + 25 = 45

    Equals original number.

    So 45 is Kaprekar Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Kaprekar numbers are positive numbers
    if n < 1:
        return False

    # Find square of number
    square = n * n

    # Count digits in original number
    digits = count_digits(n)

    # Create divisor for splitting square
    divisor = 10 ** digits

    # Split square into left and right parts
    left = square // divisor

    right = square % divisor

    # Check Kaprekar condition
    return left + right == n



# =========================================================
# ADAM NUMBER
# =========================================================

def reverse_number(n):
    """
    Reverse a number.

    Logic:
    - Extract last digit using % 10
    - Add digit to reversed number
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

    reverse = 0

    while n:

        reverse = reverse * 10 + (n % 10)

        n //= 10

    return reverse


def is_adam_number(n):
    """
    Check whether number is Adam Number.

    Logic:
    - Find square of number
    - Reverse the square
    - Reverse original number
    - Find square of reversed number
    - Compare both values

    Formula:
    reverse(n²) == (reverse(n))²

    Example:
    12

    Step 1:
    12² = 144

    Step 2:
    Reverse(144) = 441

    Step 3:
    Reverse(12) = 21

    Step 4:
    21² = 441

    Both are equal.

    So 12 is Adam Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    if n < 0:
        return False

    # Square of original number
    square = n * n

    # Reverse the square
    reversed_square = reverse_number(square)

    # Reverse original number
    reversed_number = reverse_number(n)

    # Square of reversed number
    reversed_number_square = reversed_number * reversed_number

    # Compare both values
    return reversed_square == reversed_number_square


# =========================================================
# MAGIC NUMBER
# =========================================================

def digit_sum(n):
    """
    Find sum of digits of a number.

    Logic:
    - Extract digits one by one using % 10
    - Add extracted digits
    - Remove last digit using // 10

    Example:
    1729

    1 + 7 + 2 + 9 = 19

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    total = 0

    while n:

        total += n % 10

        n //= 10

    return total


def is_magic_number(n):
    """
    Check whether number is Magic Number.

    Logic:
    - Repeatedly calculate sum of digits
    - Continue until single digit remains
    - If final digit becomes 1,
      then it is a Magic Number

    Example:
    1729

    1 + 7 + 2 + 9 = 19
    1 + 9 = 10
    1 + 0 = 1

    So 1729 is Magic Number

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    if n <= 0:
        return False

    # Repeat until single digit remains
    while n > 9:

        n = digit_sum(n)

    return n == 1




# =========================================================
# ISBN NUMBER VALIDATION (ISBN-10)
# =========================================================

"""
What is ISBN?

ISBN stands for:

International Standard Book Number

It is used to uniquely identify books.

ISBN-10 Format:
- Contains exactly 10 digits

Example:
0201314525
"""


def is_valid_isbn(isbn):
    """
    Check whether ISBN-10 number is valid.

    Logic:
    - ISBN-10 uses weighted validation
    - Multiply each digit by its position
      (positions start from 1)
    - Add all values
    - If total is divisible by 11,
      then ISBN is valid

    Formula:
    (1×d1 + 2×d2 + 3×d3 + ... + 10×d10) % 11 == 0

    Example:
    ISBN:
    0201314525

    Calculation:
    (1×0) +
    (2×2) +
    (3×0) +
    (4×1) +
    (5×3) +
    (6×1) +
    (7×4) +
    (8×5) +
    (9×2) +
    (10×5)

    = 165

    165 % 11 == 0

    So ISBN is valid.

    Validation Rules:
    - Must contain exactly 10 digits
    - All characters must be numeric

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = 10
    """

    # ISBN-10 must contain exactly 10 digits
    if len(isbn) != 10:
        return False

    total = 0

    # Enumerate provides:
    # position and digit together
    # start=1 because positions begin from 1
    for position, digit in enumerate(isbn, start=1):

        # Invalid if non-digit character exists
        if not digit.isdigit():
            return False

        # Apply weighted sum formula
        total += position * int(digit)

    # ISBN valid if divisible by 11
    return total % 11 == 0


# =========================================================
# PASCAL TRIANGLE
# =========================================================

"""
What is Pascal Triangle?

A triangular pattern where:

Every number is the sum of the
two numbers directly above it.


                1
              1   1
            1   2   1
          1   3   3   1
        1   4   6   4   1
"""


"""
Important Mathematical Relation

Pascal Triangle values are combinations:

            n!
nCr = ----------------
      r! × (n - r)!

Example:

1   3   3   1

represents:

3C0  3C1  3C2  3C3
"""


def pascal_triangle(rows):
    """
    Generate Pascal Triangle.

    Logic:
    - First and last element of every row is 1
    - Middle elements are sum of:
        previous_row[i] + previous_row[i + 1]

    Example:

    Row 0:
    [1]

    Row 1:
    [1, 1]

    Row 2:
    [1, 2, 1]

    Because:
    1 + 1 = 2

    Row 3:
    [1, 3, 3, 1]

    Because:
    1 + 2 = 3
    2 + 1 = 3

    Step-by-step:

    Previous Row:
    [1, 2, 1]

    New Row:
    Start with:
    [1]

    Add middle values:
    1+2 = 3
    2+1 = 3

    End with:
    [1]

    Final:
    [1,3,3,1]

    Time Complexity  : O(rows²)
    Space Complexity : O(rows²)
    """

    triangle = []

    # Generate rows one by one
    for row in range(rows):

        # Every row starts with 1
        current_row = [1]

        # Skip middle calculation for first row
        if triangle:

            # Get previous row
            previous_row = triangle[-1]

            # Generate middle elements
            for i in range(len(previous_row) - 1):

                current_row.append(
                    previous_row[i] + previous_row[i + 1]
                )

            # Every row ends with 1
            current_row.append(1)

        # Add current row to triangle
        triangle.append(current_row)

    return triangle




# =========================================================
# POWER OF TWO
# =========================================================

"""
A number is called Power of Two if:

It can be written as:

2^k

where k ≥ 0

Examples:
1  = 2⁰
2  = 2¹
4  = 2²
8  = 2³
16 = 2⁴
"""


# =========================================================
# POWER OF TWO - OPTIMIZED METHOD
# =========================================================

def is_power_of_two(n):
    """
    Check whether number is Power of Two
    using Bit Manipulation.

    Logic:
    - Power of Two numbers contain
      exactly one set bit (1) in binary.

    Binary Representation:

    1  -> 0001
    2  -> 0010
    4  -> 0100
    8  -> 1000

    Observation:
    n & (n - 1) removes the last set bit.

    For Power of Two:
    Result becomes 0.

    Example:
    n = 8

    Binary:
    8     = 1000
    8 - 1 = 0111

    AND Operation:
    1000 &
    0111
    ----
    0000

    Result = 0

    So 8 is Power of Two

    Example:
    n = 10

    Binary:
    1010 &
    1001
    ----
    1000

    Result ≠ 0

    So 10 is NOT Power of Two

    Time Complexity  : O(1)
    Space Complexity : O(1)
    """

    # Power of Two must be positive
    if n <= 0:
        return False

    # Check single set bit condition
    return (n & (n - 1)) == 0


# =========================================================
# POWER OF TWO - BRUTE FORCE METHOD
# =========================================================

def is_power_of_two_brute_force(n):
    """
    Check whether number is Power of Two
    using repeated division.

    Logic:
    - Keep dividing number by 2
    - If final result becomes 1,
      then it is Power of Two

    Example:
    16

    16 / 2 = 8
     8 / 2 = 4
     4 / 2 = 2
     2 / 2 = 1

    Final value = 1

    So 16 is Power of Two

    Example:
    12

    12 / 2 = 6
     6 / 2 = 3

    Final value ≠ 1

    So 12 is NOT Power of Two

    Time Complexity  : O(log n)
    Space Complexity : O(1)
    """

    # Power of Two must be positive
    if n <= 0:
        return False

    # Keep dividing by 2
    while n % 2 == 0:

        n //= 2

    # Final value must become 1
    return n == 1


## =========================================================
# COUNT SET BITS
# =========================================================

"""
What are Set Bits?

1 = Set Bit
0 = Unset Bit

Example:

Binary:
13 = 1101

Set Bits:
1 1 0 1

Total Set Bits = 3
"""


# =========================================================
# COUNT SET BITS - BASIC METHOD
# =========================================================

def count_set_bits(n):
    """
    Count total set bits using bit manipulation.

    Logic:
    - Check last bit using:
        n & 1

    - If last bit is 1,
      increment count

    - Right shift number by 1
      to process next bit

    Example:
    n = 13

    Binary:
    1101

    Step 1:
    1101 & 0001 = 1

    Count = 1

    Step 2:
    Right Shift:
    1101 >> 1 = 110

    Step 3:
    0110 & 0001 = 0

    Count = 1

    Continue until number becomes 0.

    Time Complexity  : O(number of bits)
    Space Complexity : O(1)
    """

    count = 0

    while n:

        # Check whether last bit is set
        count += n & 1

        # Right shift by 1 bit
        n >>= 1

    return count


# =========================================================
# COUNT SET BITS - OPTIMIZED METHOD
# =========================================================

"""
MOST IMPORTANT OPTIMIZED METHOD

Brian Kernighan Algorithm

Uses:

n & (n - 1)

to remove lowest set bit.

Very famous interview trick.
"""


def count_set_bits_optimized(n):
    """
    Count set bits using Brian Kernighan Algorithm.

    Logic:
    - Expression:
        n & (n - 1)

      removes the lowest set bit.

    Example:
    n = 12

    Binary:
    1100

    Step 1:
    1100 & 1011 = 1000

    Lowest set bit removed.

    Step 2:
    1000 & 0111 = 0000

    Another set bit removed.

    Total operations = total set bits

    Count = 2

    Why is this optimized?
    - Runs only for set bits
    - Faster when number contains
      fewer set bits

    Time Complexity  : O(number of set bits)
    Space Complexity : O(1)
    """

    count = 0

    while n:

        # Remove lowest set bit
        n = n & (n - 1)

        # Increment count
        count += 1

    return count


# =========================================================
# CHECK ODD OR EVEN USING BITWISE
# =========================================================

"""
Bitwise Trick:

Last bit determines whether number is:

0 -> Even Number
1 -> Odd Number

Reason:
- Even numbers are divisible by 2
- Odd numbers are not divisible by 2

Binary Examples:

8  -> 1000  -> last bit = 0 -> Even
13 -> 1101  -> last bit = 1 -> Odd
"""


def is_even(n):
    """
    Check whether number is Even
    using Bitwise AND operator.

    Logic:
    - Perform:
        n & 1

    - If result is 0:
        number is Even

    Why?
    - Even numbers always end with 0 in binary

    Example:
    n = 8

    Binary:
    1000

    1000 &
    0001
    ----
    0000

    Result = 0

    So 8 is Even

    Example:
    n = 10

    Binary:
    1010

    1010 &
    0001
    ----
    0000

    So 10 is Even

    Time Complexity  : O(1)
    Space Complexity : O(1)
    """

    return (n & 1) == 0


def is_odd(n):
    """
    Check whether number is Odd
    using Bitwise AND operator.

    Logic:
    - Perform:
        n & 1

    - If result is 1:
        number is Odd

    Why?
    - Odd numbers always end with 1 in binary

    Example:
    n = 13

    Binary:
    1101

    1101 &
    0001
    ----
    0001

    Result = 1

    So 13 is Odd

    Example:
    n = 7

    Binary:
    0111

    0111 &
    0001
    ----
    0001

    So 7 is Odd

    Time Complexity  : O(1)
    Space Complexity : O(1)
    """

    return (n & 1) == 1

# =========================================================
# SWAP TWO NUMBERS USING XOR
# =========================================================

"""
What is XOR?

XOR (^) is a Bitwise Operator.

Rules:

0 ^ 0 = 0
1 ^ 1 = 0
0 ^ 1 = 1
1 ^ 0 = 1

Important Properties:

a ^ a = 0
a ^ 0 = a

These properties help swap numbers
without using extra variable.
"""


def swap_numbers(a, b):
    """
    Swap two numbers using XOR operation.

    Logic:
    - XOR both numbers
    - Reconstruct original values using XOR properties
    - No extra variable required

    XOR Swap Steps:

    Step 1:
    a = a ^ b

    Step 2:
    b = a ^ b

    Step 3:
    a = a ^ b

    Example:
    a = 5
    b = 3

    Binary:
    5 = 0101
    3 = 0011

    Step 1:
    a = 0101 ^ 0011 = 0110

    Step 2:
    b = 0110 ^ 0011 = 0101 = 5

    Step 3:
    a = 0110 ^ 0101 = 0011 = 3

    Final:
    a = 3
    b = 5

    Why does it work?

    Because:
    x ^ y ^ y = x

    Time Complexity  : O(1)
    Space Complexity : O(1)
    """

    print("Before Swap:")

    print("a =", a)

    print("b =", b)

    # Step 1:
    # Store XOR of a and b in a
    a = a ^ b

    # Step 2:
    # Recover original a into b
    b = a ^ b

    # Step 3:
    # Recover original b into a
    a = a ^ b

    print("\nAfter Swap:")

    print("a =", a)

    print("b =", b)



# =========================================================
# Find Unique Element Using XOR
# =========================================================
def find_unique(arr):
    
    result = 0
    
    for num in arr: 
        
        result ^= num 
    
    return result
    

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

print()
print("========== Harshad Number (Niven Number) ==========")
print(is_harshad_number(18))
print(is_harshad_number(19))


print()
print("========== Spy Number ==========")
print(is_spy_number(123))
print(is_spy_number(124))

print()
print("========== Duck Number ==========")
print(is_duck_number(1023))
print(is_duck_number(1234))
print(is_duck_number(3210))

print()
print("========== Duck Number / String-Based Version ==========")
print(is_duck_number(1023))

print()
print("========== Sunny Number ==========")
print(is_sunny_number(8))
print(is_sunny_number(15))
print(is_sunny_number(10))

print()
print("========== Peterson Number ==========")
print(is_peterson_number(145))
print(is_peterson_number(123))

print()
print("========== Disarium Number ==========")
print(is_disarium_number(135))
print(is_disarium_number(89))
print(is_disarium_number(123))

print()
print("========== Happy Number ==========")
print(is_happy_number(19))
print(is_happy_number(4))

print()
print("========== Kaprekar Number ==========")
print(is_kaprekar_number(45))
print(is_kaprekar_number(9))
print(is_kaprekar_number(10))


print()
print("========== Adam Number Function ==========")
print(is_adam_number(12))
print(is_adam_number(13))
print(is_adam_number(11))


print()
print("========== Magic Number Function ==========")
print(is_magic_number(1729))
print(is_magic_number(1234))
print(is_magic_number(1235))

print()
print("========== ISBN ==========")
print(is_valid_isbn("0201314525"))
print(is_valid_isbn("1234567890"))


print()
print("========== Pascal Triangle ==========")

result = pascal_triangle(5)
for row in result:
    print(row)


print()
print("========== Check Power of Two ==========")
print(is_power_of_two(8))
print(is_power_of_two(16))
print(is_power_of_two(10))


print()
print("========== Simplest Brute Force Thinking==========")
print(is_power_of_two_brute_force(8))
print(is_power_of_two_brute_force(16))
print(is_power_of_two_brute_force(10))


print()
print("========== Count Set Bits ==========")
print(count_set_bits(13))
print(count_set_bits(10))
print(count_set_bits(7))


print()
print("========== Count Set Bits ==========")
print(count_set_bits_optimized(13))
print(count_set_bits_optimized(10))
print(count_set_bits_optimized(7))



print()
print("========== Check Odd or Even Using Bitwise ==========")
print(is_even(10))
print(is_even(13))
print(is_odd(10))
print(is_odd(13))

print()
print("========== Swap Two Number ==========")
swap_numbers(5, 3)
print()
swap_numbers(100,101)


print()
print("========== Find Unique Element Using XOR ==========")
numbers = [2, 3, 5, 4, 5, 3, 4]
print(find_unique(numbers))
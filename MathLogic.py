def count_digitv0(n):
    n = abs(n)   # Handles negative numbers
    
    if n == 0:
        return 1
    
    count = 0
    while n:
        n //= 10
        count += 1
    
    return count


print(count_digitv0(1231231))
print(count_digitv0(0))
print(count_digitv0(-9876))

def count_digitv1(n):
    return len(str(abs(n)))


print(count_digitv1(1231231))
print(count_digitv1(0))
print(count_digitv1(-9876))



def reverse_numberv0(n):
    n = abs(n)
    rev = 0
    
    while n > 0:
        digit = n % 10
        
        rev = rev * 10 + digit
        n = n // 10
    return rev

print(reverse_numberv0(54321))
print(reverse_numberv0(-12345))


def reverse_numberv1(n):
    sign = -1 if n < 0 else 1
    n = abs(n)

    rev = 0

    while n:
        rev = rev * 10 + (n % 10)
        n //= 10

    return sign * rev


print(reverse_numberv1(54321))
print(reverse_numberv1(-12345))
print(reverse_numberv1(1000))
print(reverse_numberv1(0))


# If optimization is not require
def reverse_number(n):
    sign = -1 if n < 0 else 1
    return sign * int(str(abs(n))[::-1])


def is_palindromev0(n):
    original = n 
    reverse  = 0
    
    while n > 0:
        digit = n % 10
        
        reverse = reverse * 10 + digit
        n = n // 10
    return original == reverse

print(is_palindromev0(121))
print(is_palindromev0(123))


def is_palindrome(n):
    if n < 0:
        return False

    original = n
    reverse = 0

    while n:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return original == reverse


print(is_palindrome(121))
print(is_palindrome(123))
print(is_palindrome(-121))
print(is_palindrome(0))




# Half Reversed Method
def is_palindromev2(n):
    if n < 0 or (n % 10 == 0 and n != 0):
        return False

    reverse = 0

    while n > reverse:
        reverse = reverse * 10 + (n % 10)
        n //= 10

    return n == reverse or n == reverse // 10
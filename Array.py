# =========================================================
# SUM OF ALL ELEMENTS IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array,
find the sum of all elements.

Example:
Array:
[1, 2, 3, 4, 5]

Sum:
1 + 2 + 3 + 4 + 5 = 15
"""


def sum_array(arr):
    """
    Find sum of all elements in array.

    Logic:
    - Initialize total as 0
    - Traverse array one element at a time
    - Add each element to total
    - Return final total

    Example:
    arr = [1, 2, 3, 4]

    Step 1:
    total = 0

    Step 2:
    total = 0 + 1 = 1

    Step 3:
    total = 1 + 2 = 3

    Step 4:
    total = 3 + 3 = 6

    Step 5:
    total = 6 + 4 = 10

    Final Answer:
    10

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    total = 0

    # Traverse array elements
    for num in arr:

        # Add current element to total
        total += num

    return total


# =========================================================
# FIND LARGEST ELEMENT IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array,
find the largest element.

Example:
Array:
[4, 7, 1, 9, 3]

Largest Element:
9
"""


def find_largest(arr):
    """
    Find largest element in array.

    Logic:
    - Assume first element is largest
    - Traverse remaining elements
    - Compare each element with current largest
    - Update largest when bigger element is found

    Example:
    arr = [4, 7, 1, 9, 3]

    Step 1:
    largest = 4

    Step 2:
    Compare 7 > 4
    largest = 7

    Step 3:
    Compare 1 > 7
    False

    Step 4:
    Compare 9 > 7
    largest = 9

    Step 5:
    Compare 3 > 9
    False

    Final Answer:
    9

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    # Assume first element is largest
    largest = arr[0]

    # Traverse array elements
    for num in arr:

        # Update largest if bigger element found
        if num > largest:
            largest = num

    return largest



# =========================================================
# FIND SMALLEST ELEMENT IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array,
find the smallest element.

Example:
Array:
[4, 7, 1, 9, 3]

Smallest Element:
1
"""


def find_smallest(arr):
    """
    Find smallest element in array.

    Logic:
    - Assume first element is smallest
    - Traverse remaining elements
    - Compare each element with current smallest
    - Update smallest when smaller element is found

    Example:
    arr = [4, 7, 1, 9, 3]

    Step 1:
    smallest = 4

    Step 2:
    Compare 7 < 4
    False

    Step 3:
    Compare 1 < 4
    smallest = 1

    Step 4:
    Compare 9 < 1
    False

    Step 5:
    Compare 3 < 1
    False

    Final Answer:
    1

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    # Assume first element is smallest
    smallest = arr[0]

    # Traverse array elements
    for num in arr:

        # Update smallest if smaller element found
        if num < smallest:
            smallest = num

    return smallest



# =========================================================
# FIND SECOND LARGEST ELEMENT IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array,
find the second largest element.

Example:
Array:
[10, 5, 20, 8]

Largest Element:
20

Second Largest Element:
10
"""


def find_second_largest(arr):
    """
    Find second largest element in array.

    Logic:
    - Maintain two variables:
        1. largest
        2. second_largest

    - Traverse array elements one by one

    Cases:
    1. If current number is greater than largest:
        - Move largest to second_largest
        - Update largest

    2. Otherwise:
        - Check if number is greater than second_largest
        - Also ensure it is not equal to largest
        - Update second_largest

    Example:
    arr = [10, 5, 20, 8]

    Step 1:
    largest = -∞
    second_largest = -∞

    Step 2:
    num = 10

    largest = 10
    second_largest = -∞

    Step 3:
    num = 5

    second_largest = 5

    Step 4:
    num = 20

    second_largest = 10
    largest = 20

    Step 5:
    num = 8

    No update needed

    Final Answer:
    second_largest = 10

    Why use float('-inf')?
    - Handles negative numbers correctly
    - Ensures any number can replace initial value

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    # Initialize largest and second largest
    largest = float('-inf')

    second_largest = float('-inf')

    # Traverse array elements
    for num in arr:

        # Update largest element
        if num > largest:

            second_largest = largest

            largest = num

        # Update second largest element
        elif num > second_largest and num != largest:

            second_largest = num

    return second_largest


# =========================================================
# TEST CASE
# =========================================================

arr = [10, 5, 20, 8]

print(find_second_largest(arr))# =========================================================
# FIND SECOND LARGEST ELEMENT IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array,
find the second largest element.

Example:
Array:
[10, 5, 20, 8]

Largest Element:
20

Second Largest Element:
10
"""


def find_second_largest(arr):
    """
    Find second largest element in array.

    Logic:
    - Maintain two variables:
        1. largest
        2. second_largest

    - Traverse array elements one by one

    Cases:
    1. If current number is greater than largest:
        - Move largest to second_largest
        - Update largest

    2. Otherwise:
        - Check if number is greater than second_largest
        - Also ensure it is not equal to largest
        - Update second_largest

    Example:
    arr = [10, 5, 20, 8]

    Step 1:
    largest = -∞
    second_largest = -∞

    Step 2:
    num = 10

    largest = 10
    second_largest = -∞

    Step 3:
    num = 5

    second_largest = 5

    Step 4:
    num = 20

    second_largest = 10
    largest = 20

    Step 5:
    num = 8

    No update needed

    Final Answer:
    second_largest = 10

    Why use float('-inf')?
    - Handles negative numbers correctly
    - Ensures any number can replace initial value

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    
    
Step 4 — What is float('-inf')?

It means:

negative infinity

Very very small number.

Used so any array value becomes larger initially.
    """

    # Initialize largest and second largest
    largest = float('-inf')

    second_largest = float('-inf')

    # Traverse array elements
    for num in arr:

        # Update largest element
        if num > largest:

            second_largest = largest

            largest = num

        # Update second largest element
        elif num > second_largest and num != largest:

            second_largest = num

    return second_largest





# ===================================================================================
# REVERSE AN ARRAY - TWO POINTER APPROACH - In-Place Reversal - No extra memory used
# ===================================================================================

"""
Problem Statement:

Given an array,
reverse the array in-place.

Example:
Input:
[1, 2, 3, 4, 5]

Output:
[5, 4, 3, 2, 1]
"""


def reverse_array(arr):
    """
    Reverse array using Two Pointer approach.

    Logic:
    - Use two pointers:
        1. left  -> start of array
        2. right -> end of array

    - Swap elements at left and right
    - Move:
        left  forward
        right backward

    - Continue until both pointers meet

    Example:
    arr = [1, 2, 3, 4, 5]

    Step 1:
    left = 0
    right = 4

    Swap:
    1 ↔ 5

    Array:
    [5, 2, 3, 4, 1]

    Step 2:
    left = 1
    right = 3

    Swap:
    2 ↔ 4

    Array:
    [5, 4, 3, 2, 1]

    Step 3:
    left = 2
    right = 2

    Stop because pointers meet.

    Final Output:
    [5, 4, 3, 2, 1]

    Why is this efficient?
    - No extra array used
    - In-place reversal

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    # Left pointer starts from beginning
    left = 0

    # Right pointer starts from end
    right = len(arr) - 1

    # Continue until pointers cross
    while left < right:

        # Swap elements
        arr[left], arr[right] = arr[right], arr[left]

        # Move pointers
        left += 1

        right -= 1

    return arr



# =========================================================
# LINEAR SEARCH IN ARRAY
# =========================================================

"""
Problem Statement:

Given an array and a target element,
find the index of the target element.

If element is not found,
return -1.

Example:
Array:
[10, 20, 30, 40, 50]

Target:
30

Output:
2
"""


def linear_search(arr, target):
    """
    Search target element using Linear Search.

    Logic:
    - Traverse array from beginning
    - Compare each element with target
    - If match found:
        return index
    - If loop ends:
        target does not exist

    Example:
    arr = [10, 20, 30, 40]

    target = 30

    Step 1:
    arr[0] = 10
    10 == 30 -> False

    Step 2:
    arr[1] = 20
    20 == 30 -> False

    Step 3:
    arr[2] = 30
    30 == 30 -> True

    Return index:
    2

    Why called Linear Search?
    - Elements are checked one by one
      in linear order

    Best Case:
    - Target found at first position
    - O(1)

    Worst Case:
    - Target at end or not present
    - O(n)

    Time Complexity  : O(n)
    Space Complexity : O(1)

    where n = number of elements
    """

    # Traverse array indices
    for i in range(len(arr)):

        # Check current element
        if arr[i] == target:

            return i

    # Target not found
    return -1

# =========================================================
# Move All Zeros to End
# =========================================================






# =========================================================
# TEST CASE
# =========================================================

arr = [1, 2, 3, 4, 5]

print(reverse_array(arr))

# =========================================================
# TEST CASE
# =========================================================

arr = [4, 7, 1, 9, 3]

print(find_smallest(arr))

# =========================================================
# TEST CASE
# =========================================================



print("===================== Sum of the Array==============")
arr = [1, 2, 3, 4, 5]
print(sum_array(arr))


print("===================== Largest of the Array==============")
arr = [5, 2, 9, 1, 7]
print(find_largest(arr))


print("===================== Smallest of the Array==============")
arr = [5, 2, 9, 1, 7]
print(find_smallest(arr))



print()
print("===================== Second Largest of the Array==============")
arr = [10, 5, 20, 8]
print(find_second_largest(arr))


print()
print("======================= Reverse an Array / Two Pointer ================")
arr = [1, 2, 3, 4, 5]
print(reverse_array(arr))


print()
print("Python Short-Cut")
arr = [1, 2, 3, 4, 5, 6]
arr.reverse()
print(arr)


print()
print("======================= Linear Search in Array ================")
arr = [10, 20, 30, 40, 50]
target = 30
print(linear_search(arr, target))
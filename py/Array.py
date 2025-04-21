class DSA:
    @staticmethod
    def print_array(arr):
        """Print all elements in the array."""
        for elem in arr:
            print(elem)

    @staticmethod
    def reverse_array(arr):
        """Print array elements in reverse order."""
        for i in range(len(arr) - 1, -1, -1):
            print(arr[i])

    @staticmethod
    def search_element(arr, target):
        """Search for a target element and return its index, else -1."""
        for i in range(len(arr)):
            if arr[i] == target:
                return i
        return -1

    @staticmethod
    def find_max(arr):
        """Find and return the maximum element in the array."""
        max_val = arr[0]
        for num in arr:
            if num > max_val:
                max_val = num
        return max_val

    @staticmethod
    def find_min(arr):
        """Find and return the minimum element in the array."""
        min_val = arr[0]
        for num in arr:
            if num < min_val:
                min_val = num
        return min_val

    @staticmethod
    def reverse_in_place(arr):
        """Reverse the array in place (mutate original array)."""
        left, right = 0, len(arr) - 1
        while left < right:
            arr[left], arr[right] = arr[right], arr[left]
            left += 1
            right -= 1

    @staticmethod
    def sum_of_elements(arr):
        """Return the sum of array elements."""
        total = 0
        for elem in arr:
            total += elem
        return total

    @staticmethod
    def second_largest(arr):
        """Find the second largest element in the array."""
        if len(arr) < 2:
            return None
        largest = second = float('-inf')
        for num in arr:
            if num > largest:
                second = largest
                largest = num
            elif num > second and num != largest:
                second = num
        return second if second != float('-inf') else None

    @staticmethod
    def left_rotate_by_one(arr):
        """Left rotate the array by one position."""
        if len(arr) == 0:
            return arr
        first = arr.pop(0)
        arr.append(first)
        return arr

    @staticmethod
    def right_rotate_by_one(arr):
        """Right rotate the array by one position."""
        if len(arr) == 0:
            return arr
        last = arr.pop()
        arr.insert(0, last)
        return arr
    # Check if an Array is Sorted in Aescending Order
    @staticmethod
    def is_sorted(arr):
        for i in range(len(arr) - 1):
            if arr[i] > arr[i + 1]:
                return False
        return True
    
    # Check if an Array is Sorted in Descending Order
    # Write this using recursion 
    # Count the Number of Even and Odd Elements in an Array
    # Count positive, negative, or zero?
    # Count how many numbers are greater than a given number?
    # Check if an array is strictly increasing or decreasing?
    # Rotate by K positions?
    # Remove duplicates?


# Test the DSA class
arr = [10, 20, 30, 40, 50]

print("Original Array:")
DSA.print_array(arr)

print("\nArray in Reverse Order:")
DSA.reverse_array(arr)

target = 380
index = DSA.search_element(arr, target)
print(f"\nSearch for {target}: {'Found at index ' + str(index) if index != -1 else 'Not found'}")

print("\nMaximum Element:", DSA.find_max(arr))
print("Minimum Element:", DSA.find_min(arr))

# Reverse in place and print
arr_copy = arr[:]
DSA.reverse_in_place(arr_copy)
print("\nArray After In-place Reversal:")
DSA.print_array(arr_copy)

# Sum of elements in the Array
print("\nSum of Elements in the Array: ", DSA.sum_of_elements(arr))

print("\nSecond largest element is: ", DSA.second_largest(arr))

# Left rotation
arr_left = arr[:]
print("\nBefore left_rotate_by_one:", arr_left)
rotated_left = DSA.left_rotate_by_one(arr_left)
print("After left_rotate_by_one:", rotated_left)

# Right rotation
arr_right = arr[:]
print("\nBefore right_rotate_by_one:", arr_right)
rotated_right = DSA.right_rotate_by_one(arr_right)
print("\nAfter right_rotate_by_one:", rotated_right)

print("\nIs Given Array is Sorted Or Not: ",DSA.is_sorted([10,20,30,40]))
print("\nIs Given Array is Sorted Or Not: ",DSA.is_sorted([10,50,30,40]))

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
        sum = 0
        for elem in arr:
            sum = sum + elem
        return sum 
    
    # Find the Second Largest Elements
    @staticmethod
    def second_largest(arr):
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
    
    # Left Rotate an Array by 1 Position 
    @staticmethod
    def left_rotate_by_one(arr):
        if len(arr) == 0:
            return arr 
        first = arr.pop(0)
        arr.append(first)
        return arr 
    
    # Right Rotate an Array by 1 position 
    @staticmethod
    def right_rotate_by_one(arr):
        if len(arr) == 0:
            return arr
        last = arr.pop()
        arr.insert(0,last)
        
        return arr
    

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
DSA.reverse_in_place(arr)
print("\nArray After In-place Reversal:")
DSA.print_array(arr)

# Sum of elements in the Array 
print("\nSum of Elemets in the Array: ", DSA.sum_of_elements(arr))

print("\nSecond largest element is : ", DSA.second_largest(arr))

print("\nBefore left_rotate_by_one : ",arr)
rotated = DSA.left_rotate_by_one(arr)
print("After left_rotate_by_one : ",rotated)

print("\nBefore right_rotate_by_one : ",arr)
rotated = DSA.right_rotate_by_one(arr)
print("After right_rotate_by_one : ",rotated)




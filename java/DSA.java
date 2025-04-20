import java.util.Arrays;

public class DSA {

    // Print array elements
    public static void printArray(int[] arr) {
        for (int elem : arr) {
            System.out.println(elem);
        }
    }

    // Alternate method to print array elements
    public static void printArrayV0(int[] arr) {
        for (int elem : arr) {
            System.out.println(elem);
        }
    }

    // Print array in reverse order
    public static void reverseArray(int[] arr) {
        for (int i = arr.length - 1; i >= 0; i--) {
            System.out.println(arr[i]);
        }
    }

    // Search for a target element and return index
    public static int searchElement(int[] arr, int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1;
    }

    // Find maximum element
    public static int findMax(int[] arr) {
        int max = arr[0];
        for (int num : arr) {
            if (num > max) {
                max = num;
            }
        }
        return max;
    }

    // Find minimum element
    public static int findMin(int[] arr) {
        int min = arr[0];
        for (int num : arr) {
            if (num < min) {
                min = num;
            }
        }
        return min;
    }

    // Reverse array in-place
    public static void reverseInPlace(int[] arr) {
        int left = 0;
        int right = arr.length - 1;
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }

    // Calculate sum of elements
    public static int sumOfElements(int[] arr) {
        int total = 0;
        for (int num : arr) {
            total += num;
        }
        return total;
    }

    // Right rotate array by one
    public static void rightRotateByOne(int[] arr) {
        if (arr.length == 0) return;

        int last = arr[arr.length - 1];
        for (int i = arr.length - 1; i > 0; i--) {
            arr[i] = arr[i - 1];
        }
        arr[0] = last;
    }

    // Find second largest element
    public static Integer secondLargest(int[] arr) {
        if (arr.length < 2) return null;

        int largest = Integer.MIN_VALUE;
        int second = Integer.MIN_VALUE;

        for (int num : arr) {
            if (num > largest) {
                second = largest;
                largest = num;
            } else if (num > second && num != largest) {
                second = num;
            }
        }
        return (second == Integer.MIN_VALUE) ? null : second;
    }

    // Left rotate array by one
    public static void leftRotateByOne(int[] arr) {
        if (arr.length == 0) return;

        int first = arr[0];
        for (int i = 0; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr[arr.length - 1] = first;
    }

    // Main method to test
    public static void main(String[] args) {
        int[] arr = {10, 20, 30, 40, 50};

        System.out.println("Original Array:");
        printArray(arr);

        System.out.println("\nOriginal Array (printArrayV0):");
        printArrayV0(arr);

        System.out.println("\nArray in Reverse Order:");
        reverseArray(arr);

        System.out.println("\nSearching for element 30:");
        int index = searchElement(arr, 30);
        System.out.println(index != -1 ? "Found at index: " + index : "Not Found");

        System.out.println("\nMaximum Element in the Array: " + findMax(arr));
        System.out.println("Minimum Element in the Array: " + findMin(arr));

        int[] arr1 = {90, 20, 34, 45, 56};
        System.out.println("\nBefore In-Place Reverse: " + Arrays.toString(arr1));
        reverseInPlace(arr1);
        System.out.println("After In-Place Reverse:  " + Arrays.toString(arr1));

        System.out.println("\nSum of the Array Elements is: " + sumOfElements(arr));

        Integer result = secondLargest(arr);
        System.out.println("\nSecond Largest Element is: " + (result != null ? result : "Not Found"));

        int[] arr2 = {10, 20, 30, 40, 50};
        System.out.println("\nBefore Left Rotation: " + Arrays.toString(arr2));
        leftRotateByOne(arr2);
        System.out.println("After Left Rotation:  " + Arrays.toString(arr2));

        int[] arr3 = {10, 20, 30, 40, 50};
        System.out.println("\nBefore Right Rotation: " + Arrays.toString(arr3));
        rightRotateByOne(arr3);
        System.out.println("After Right Rotation:  " + Arrays.toString(arr3));
    }
}

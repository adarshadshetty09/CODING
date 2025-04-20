
import java.util.Arrays;

public class DSA {

    // Print array elements
    public static void printArray(int[] arr) {
        for (int elem : arr) {
            System.out.println(elem);
        }
    }

    // Alternate method to print array elements (same as above)
    public static void printArrayV0(int[] arr) {
        for (int elem : arr) {
            System.out.println(elem);
        }
    }

    // Print array elements in reverse order
    public static void reverseArray(int[] arr) {
        for (int i = arr.length - 1; i >= 0; i--) {
            System.out.println(arr[i]);
        }
    }

    // Search for a target element and return its index, else return -1
    public static int searchElement(int[] arr, int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1;
    }

    // Find the maximum element in the array
    public static int findMax(int[] arr) {
        int max = arr[0];
        for (int num : arr) {
            if (num > max) {
                max = num;
            }
        }
        return max;
    }

    // Find the minimum element in the array
    public static int findMin(int[] arr) {
        int min = arr[0];
        for (int num : arr) {
            if (num < min) {
                min = num;
            }
        }
        return min;
    }

    // Reverse the Array in In-Place
    public static void reverseInPlace(int[] arr){
        int left  = 0;
        int right = arr.length - 1;
        while (left < right){
            arr[left]  = arr[right];
            arr[right] = arr[left];
            left++;
            right--;
        }
    }

    // Main method to test functionality
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
        if (index != -1) {
            System.out.println("Found at index: " + index);
        } else {
            System.out.println("Not Found");
        }

        System.out.println("\nMaximum Element in the Array: " + findMax(arr));
        System.out.println("Minimum Element in the Array: " + findMin(arr));
        int[] arr1 = {90,20,34,45,56};
        System.out.println("\nBefore: " + Arrays.toString(arr1));
        reverseInPlace(arr1);
        System.out.println("\nAfter: "+ Arrays.toString(arr1));
    }
}

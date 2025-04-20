### Big-O Notation (Performance Measure)

#### Time Complexity

#### O(1) - Constant (access first element)

#### O(n) - Linear ( Loop through all element )

#### O(n2) - Quadratic (Nested Loops)

### What is Big-O?

Big-O describes **how the runtime (or memory) of an algorithm grows** with the size of the input (`n`).

Think of it like this:

> *“As the number of elements increases, how much longer will my code take to run?”*

#### ⏱️ Common Time Complexities


| Big-O | Description | Example |
| ----- | ----------- | ------- |


| O(1) | Constant time | Accessing first element |
| ---- | ------------- | ----------------------- |


| O(n) | Linear time | Loop through all elements |
| ---- | ----------- | ------------------------- |


| O(n²) | Quadratic time | Nested loops |
| ------ | -------------- | ------------ |


| O(log n) | Logarithmic time | Binary search |
| -------- | ---------------- | ------------- |


| O(n log n) | Efficient sorts (Merge) | Merge sort, Quick sort |
| ---------- | ----------------------- | ---------------------- |


| O(2^n) | Exponential time | Recursion in brute-force |
| ------ | ---------------- | ------------------------ |


## An **array** is a **collection of elements** stored in **contiguous memory**. All elements are of the **same type**.


#### In Python

arr = [10 , 20 ,30 ,40]


#### In Java

int[] arr = {10 ,20, 30, 40};

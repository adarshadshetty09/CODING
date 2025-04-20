# O(1) - constant time

arr = [10, 20, 30]
print(arr[0])     # Dierectly accessing the first element of the array , Always takes the same time

# O(n) - Linear Time 

for num in arr:
    print(num)
    
#  O(n^2) - Quadratic time
for i in arr: 
    for j in arr:
        print(i,j)
    

import pdb
import trace

# pdb.set_trace()

# print
name = "Adarsha"
print("Hello", name)

a = 12
b = 12
print(a+b)

# input() lets the user type something, like this:
name = input("Enter your name: ")
print("Hello",name)

# Converting input to numbers (input is always a string by default):
a = int(input("Enter a number: "))
b = int(input("Enter the another number: "))
print("Sum is ", a+b)    

# Ask for User’s Name , Take the user's name using input() and greet the
name = input("Enter your name: ")
print("Hello", name)

#  Problem 4: Add Two Numbers from User Input
a = int(input("Enter the number1: "))
b = int(input("Enter the number2: "))
print("The sum number1 and number2 is: ", a+b)

'''
Use input() to take user input

Convert input strings to integers using int()

Display output using print()
'''

# Conditions & Loops

# if

age = int(input("Enter your age: "))
if age >= 18:
    print("You are an adult.")
else:
    print("Your are a minor.")

'''
Task: Ask the user to enter a number. Print:
Even" if it's divisible by 2
Odd" if it is not
'''

number = int(input("Enter the number: "))
if number%2 != 0:
    print("Odd")
else:
    print("Even")
    
# Task: Ask the user to enter two numbers, and print the larger one.

num1 = int(input("Enter the number1: "))
num2 = int(input("Enter the number2: "))

if num1 > num2:
    print("The largest number b/w number1 and number2 ",num1)
elif num2 > num1:
    print("The largest number b/w number1 and number2 ",num2)
else: 
    print("Both the numbers are equal")
    
# for Loops for and while loops

for i in range(1,6):
    print(i)

# Task: Ask the user to enter N, then print numbers from 1 to N using a for loop.

number = int(input("Enter the number: "))
for i in range(1,number+1):
    print(i)

# Task: Ask the user to enter a number, then print its multiplication table from 1 to 10.

number  = int(input("Enter the multiplication number: "))
for i in range(1,11):
    print(f"{number} x {i} = { number * i } ")
    
    
    
#  Print 1 to N using while loop

N = int(input("Enter the number: "))
i = 1
while i <= N:
    print(i)
    i += 1
    
# Multiplication Table using while loop

X = int(input("Enter the number X: "))
i = 1
while i <= 10:
    print(f"{X} x {i} = {X * i}")
    i += 1


# Fucntion in Python 

'''
def function_name():
    # code block
'''

def greeting():
    print("Hello from the function greeting!!!!")

greeting()
greeting()

# Task: Define a function say_hello() that prints "Hello, World" and call it.

def say_hello():
    print("Hello World")

say_hello()
say_hello()

# Problem 12: Function to Add Two Numbers
'''
Task:

Define a function add(a, b) that returns the sum.

Ask the user to input two numbers and pass them to the function.

Print the result.
'''

a = int(input("Enter first number: "))
b = int(input("Enter second number: "))

def add(a,b):
    print(f"The sum of {a} and {b} is : {a+b}")

add(a,b)
add(a,b)

# Bonus (Optional Improvement):
def add_0(a, b):
    return a + b

result = add_0(a, b)
print("Sum is:", result)


# Function to Add Two Numbers

def add_1():
    a = int(input("Enter first number: "))
    b = int(input("Enter second number: "))
    c = int(input("Enter third number: "))
    
    print(f"The sum of first , second , third number is:  {a+b+c}")

add_1()
add_1()
add_1()
    

'''
Best Practice Suggestion
You can also pass the values as arguments instead of taking input inside the function. 
This separates logic and I/O — a good practice in real-world coding.
'''
def add_2(a, b, c):
    print(f"The sum is: {a + b + c}")

x = int(input("Enter first number: "))
y = int(input("Enter second number: "))
z = int(input("Enter third number: "))

add_2(x, y, z)    # not as am expected


# Function to Check Even or Odd

def check_even_odd():
    number = int(input("Enter the number: "))
    if number % 2 == 0:
        print("Even")
    else:
        print("Odd")
check_even_odd()
check_even_odd()
check_even_odd()

#  Function to Find the Maximum of Three Numbers

def find_max():
    number1 = int(input("Enter the number1: "))
    number2 = int(input("Enter the number2: "))
    
    if number1 > number2:
        print(f"The number1 {number1} is Greater.")
    elif number2 > number1: 
        print(f"The number2 {number2} is Greater.")
    else:
        print(f"The both {number1} and {number2} are Equal.")

find_max()
find_max()
find_max()


# find_max() for Three Numbers

def find_max():
    a = int(input("Enter first number: "))
    b = int(input("Enter second number: "))
    c = int(input("Enter third number: "))
    
    if a >= b and a >= c:
        print(f"The largest number is: {a}")
    elif b >= a and b >= c: 
        print(f"The largest number is: {b}")
    else: 
        print(f"The Largest number is: {c}") 
find_max()
find_max()


#  Python’s built-in max() function:
def find_max():
    a = int(input("Enter first number: "))
    b = int(input("Enter second number: "))
    c = int(input("Enter third number: "))
    
    print(f"The largest number is : {max(a,b,c)}")
find_max()
find_max()

# Strings in Python
# A string is a sequence of characters like "hello", "Python", "123abc"

s = "Hello World"

print(len(s))
print(s.lower())
print(s.upper())
print(s[0])
print(s[-1])
print(s[0:5])



'''
Task:

Ask the user to enter a string

Print:

Length of the string

All characters in uppercase

All characters in lowercase

First 3 characters

Last 3 characters

'''

stringSentence = input("Enter a string: ")

print(len(stringSentence))
print(stringSentence.upper())
print(stringSentence.lower())
print(stringSentence[0:3])
print(stringSentence[-3:])


'''
Problem 16: Reverse a String
Task:

Ask the user for a string

Print the string in reverse

Hint: Use slicing like s[::-1]
'''

s = input("Enter a string: ")
print("Reverse: ", s[::-1])


# Lists in Python 

# 📘 Creating and Using Lists:

fruits = ["apple", "banana", "cherry"]

print(fruits[0])
print(fruits[-1])

print(len(fruits))

fruits.append("Mango")
print(fruits)
fruits.remove("banana")
print(fruits)
fruits.sort()


'''
Task:

Create a list with at least 5 numbers.

Print:

The full list

First and last elements

Length of the list
'''

number = [1, 2 , 3 , 4, 5]

print(number)

print(number[0])
print(number[-1])
print(len(number))


'''
Task:

Start with a list of colors: ["red", "blue", "green"]

Add "yellow"

Remove "blue"

Sort the list

Print the final list
'''

color = ["red" , "blue", "green"]

color.append("yellow")

print(color)

color.sort()
print(color)



# 🧠 Loops with Lists

number = [10 , 20  ,30 ]

for num in number:
    print(num)


'''
Sum of Elements in a List
Task:

Create a list of numbers: [5, 10, 15, 20, 25]

Use a loop to calculate and print the sum of the elements
'''

number = [5 , 10, 15 , 20 , 25]
sum = 0
for num in number:
    sum = sum + num

# print(sum)
    
'''
Count Even and Odd Numbers in a List
Task:

Use the same list: [5, 10, 15, 20, 25]

Count how many numbers are even and how many are odd using a loop
'''

number = [5 , 10, 15 ,20 ,25]


even = 0
odd  = 0

for num in number:
    if num % 2 == 0:
        even += 1
    else:
        odd+=1
        
print(f"The count of even number is: {even}")
print(f"The count of odd number is : {odd}")



'''
🧠 Problem 21: Sum of All Elements in a List
Task:

Use the list [5, 10, 15, 20, 25]

Use a loop to calculate the total sum

🔁 Bonus: Also try with sum() built-in function
'''


number = [ 5 , 10 , 15 , 20 ,25 ]

total  = 0
for num in number:
    total = total + num
print(f"Sum using loop: ", {total})

# or 

print("Sum using the built-in sum(): ",sum(number))

'''
🧠 Problem 22: Find Maximum and Minimum in a List
Task:

Use the same list

Find:

Largest number using a loop

Smallest number using a loop
'''

number = [ 5 , 10 , 15 , 20 , 25 ]
print(f"The maximum number in the list: ",max(number))
print(f"The minimum number number in the list: ",min(number))

# using the logic
number = [ 5 , 10 , 15 , 20 , 25 ]

max_number = number[0]
min_number = number[0]

for num in number:
    if num > max_number:
        max_number = num
    
    if num < min_number:
        min_number = num

print(f"The minimum number in the list: {min_number}")
print(f"The maximum number in the list is : {max_number}")
        
        
# Tuples and Sets in Python
# A tuple is like a list, but it’s immutable (cannot be changed after creation)

my_tuple = (10 , 20 ,30)
print(my_tuple[0])
print(len(my_tuple))

        

'''
✅ Problem 24: Tuple Practice
Task:

Create a tuple with 5 numbers.

Print:

First and last elements

Length of the tuple
'''  

number = (1, 2 , 3, 4, 5)
print(number)
print(len(number))


'''
✅ Problem 25: Iterate Over Tuple
Task:

Loop through a tuple and print each value.
'''

number = (1, 2 ,3 ,4 ,5)
for num in number: 
    print(num)
    

'''
🧱 Part 2: Sets
A set is an unordered collection of unique elements.
'''
my_set = {1,2,3,4,5,4}  # Removes the duplicate
print(my_set)

my_set.add(6)
my_set.add(4)
print(my_set)


'''
✅ Problem 26: Set Practice
Task:

Create a set with some duplicate numbers.

Print the set (you’ll see duplicates are gone).

Add a new number to the set.

Remove a number from the set.
'''

my_set = {1,2,3,2,4,3,5,2,5}
print(my_set)

my_set.add(12)
print(my_set)

my_set.remove(2)  # From the unique element it removes the 2 , does't from original sets
print(my_set)



'''
🧠 What is a Dictionary?
A dictionary stores data in key-value pairs:
'''


# Syntax
'''
student = {
    "name": "Adarsha",
    "age": 25,
    "course": "Python"
}
'''

import random
student = {
    "name": "Adarsha",
    "age": random.randint(25,32),
    "course":"Python"
}

print(student["name"])
print(student.get("age"))

'''
✅ Problem 27: Create and Access a Dictionary
🧠 Task:
Create a dictionary person with:

"name" → "Adarsha"

"age" → 25

"city" → "Bangalore"

Then:

Print the entire dictionary

Print just the "name" and "city"
'''

person = {
    "name": "Adarsha",
    "age":25,
    "city":"Bangalore"
}

print(person)

print(person.get("name"))
print(person.get("city"))




'''
✅ Problem 28: Add and Update Dictionary
🧠 Task:
Add a new key: "profession" → "Engineer"

Update "age" to 26

Print the updated dictionary
'''


person = {
    "name": "Adarsha",
    "age":25,
    "city":"Bangalore"
}

person["profession"] = "Engineer"
person["age"] = 26

print("Updated dictionary: ",person)





'''
🔁 Looping Through a Dictionary
✅ You can loop through:
Keys

Values

Key-Value Pairs
'''

person = {
    "name": "Adarsha",
    "age": 26,
    "city": "Bangalore",
    "profession": "Engineer"
}


# Loop through keys:
for key in person:
    print(key)
    
    
# Loop through values:
for value in person.values():
    print(value)

for key , value in person.items():
    print(key, ":" , value)



'''
✅ Problem 30: Check if a Key Exists in Dictionary
🧠 Task:
Check if "email" key exists in the dictionary. If not, add it.
'''

if "email" not in person:
    person["email"] = "adarshadshetty09@gmail.com"

print(person)



if "Job_Role" not in person:
    person["Job_Role"] = "SoftWare Engineer"
    
print(person)


'''
🚀 Final Step: Nested Dictionaries
Would you like to move on to:

✅ Problem 31: Nested Dictionary —
A dictionary inside another dictionary (like a JSON object)?
'''

# Nested dictionary
students = {
    "SDE": {"name": "Adarsha", "age": 26},
    "SRE": {"name": "Raj", "age": 24},
    "IAC": {"name": "Sneha", "age": 25}
}


# Print the full dictionary 
print("All students: ", students)


# Print name and age of each student
for roll, details in students.items():
    print(f"Roll: {roll}")
    print(f"Name: {details['name']}")
    print(f"Age: {details['age']}")
    print("---")

'''
🎉 Congratulations! You’ve now completed:

Input/output

If/else

Loops (for, while)

Functions

Strings

Lists

Tuples

Sets

Dictionaries

Nested dictionaries
'''




'''
🧪 Project 1: Simple Calculator App
🧠 Features:
Ask the user to enter:

Two numbers

An operation (+, -, *, /)

Perform the calculation

Print the result
'''

def simple_calculator():
    print("===================== Simple Calulator ===================")
    num1 = int(input("Enter the first number: "))
    operator = input("Enter the any operation you want to perform in this '+' , '-' , '*' , '/' , '%' ")
    num2 = int(input("Enter the second number: "))
    
    if operator == "+":
        print(f" The Addition of {num1} and {num2} is the: {num1 +  num2}")
    elif operator == "-":
        print(f" The Substraction of {num1} and {num2} is the: {num1 - num2}")
    elif operator == "*":
        print(f" The Multiplication of {num1} and {num2} is the: {num1 *  num2}")
    elif operator == "/":
        if num1 != 0:
            print(f" The Division of {num1} and {num2} is the: {num1 /  num2}")
        else: 
            print("Error: Division By Zero.")
    elif operator == "%":
        if num1 != 0:
            print(f" The Mod of {num1} and {num2} is the: {num1 %  num2}")
        else: 
            print("Error: Division By Zero.")
    else:
        print("Invalid Operator")

# Loop to keep asking the user

while True: 
    simple_calculator()
    again = input("Do you want to calculate again ? (yes/no): ")
    if again.lower() != "yes":
        print("Calculator is closed. GoodBye!")
        break




'''
🧪 Mini Project 2: Contact Book (Dictionary Based)
This is a console-based contact manager where you can:

Add new contacts

View all contacts

Search by name

Delete contacts

Exit the program
'''

def display():
    print("============= Contact Book ===============")
    print("1. Add New Contact: ")
    print("2. View all the Contact: ")
    print("3. Search the contact by name: ")
    print("4. Delete the contact ")
    print("5. Exit the Contact Book ")
    print("6. Update the contact number ")
    
contact = {}

try:
    with open("contact.txt", "r") as file:
        for line in file:
            if ": " in line:
                name, number = line.strip().split(": ", 1)
                contact[name] = number
except FileNotFoundError:
    print("Contact file not found. Starting with an empty contact book.")


while True:
    display()
    print("========== Enter Your Choice ========== ")
    choice = input("Enter the your choice between the (1-5): ")
    
    if choice == "1":
        name = input("Enter the name of the contact: ")
        number = input("Enter the contact number: ")
        contact[name] = number
        print("Contact Number Added")
    
    elif choice == "2":
        if not contact:
            print("Contact number list is Empty")
        else:
            print("View all the contact number: ")
            for name, number in contact.items():
                print(f"{name} -> {number}")
    
    elif choice == "3":
        name = input("Enter the name to search: ")
        if name in contact:
            print(f"{name} -> {contact[name]}")
        else:
            print("Contact not found. ")
    elif choice == "4":
        name = input("Enter the contact name to delete: ")
        if name in contact:
            del contact[name]
            print("Contact deleted")
        else:
            print("Contact not found.")
    
    elif choice == "6":
        name = input("Enter the namr to update: ")
        if name in contact:
            new_number = input("Enter the new phone number: ")
            contact[name] = new_number
            print(f"Contact updated: {name} -> {new_number}")  
        else:
            print("Contact not found. Cannot update.")
    
    elif choice == "5":
        print("Exiting the contact book. GoodBye")
        break
    
    else:
        print("Invalid Choice . Please enter 1-5.")
    
    with open("contact.txt", "w") as file:
        for name, number in contact.items():
            file.write(f"{name}: {number}\n")
            
  

# 🔹 1. len(), max(), min(), sum()

number = [10, 20 ,30, 40, 50]

print("Length of the list: ", len(number))
print("Maximum number in the list: ", max(number))
print("Minimum number in the list: ", min(number))
print("Sum of the list: ", sum(number))

name = "Adarsha"
print(len(name))


nums = [5, 3 , 9, 1]

print(sorted(nums))
print(sorted(nums, reverse=True))

rev = list(reversed(nums))
print(rev)


# ✅ 1. List of Numbers

numbers = [15, 42, 8, 23]

print("Length:", len(numbers))        # 4
print("Sum:", sum(numbers))           # 88
print("Max:", max(numbers))           # 42
print("Min:", min(numbers))           # 8
print("Sorted:", sorted(numbers))     # [8, 15, 23, 42]
print("Reversed:", list(reversed(numbers)))  # [23, 8, 42, 15]





# ✅ 2. List of Strings


names = ["Adarsha", "Raj", "Sneha", "Zara"]

print("Length:", len(names))                  # 4
print("Max:", max(names))                     # Zara (alphabetically last)
print("Min:", min(names))                     # Adarsha (alphabetically first)
print("Sorted:", sorted(names))               # ['Adarsha', 'Raj', 'Sneha', 'Zara']
print("Reversed:", list(reversed(names)))     # ['Zara', 'Sneha', 'Raj', 'Adarsha']



# ✅ 3. Dictionary (.keys() / .values())

student = {
    "math": 85,
    "science": 90,
    "english": 78
}

# Length of dictionary
print("Length:", len(student))  # 3

# Sorted keys
print("Sorted Keys:", sorted(student.keys()))        # ['english', 'math', 'science']

# Sorted values
print("Sorted Marks:", sorted(student.values()))     # [78, 85, 90]

# Sum of values (total marks)
print("Total Marks:", sum(student.values()))         # 253

# Highest and lowest marks
print("Highest:", max(student.values()))             # 90
print("Lowest:", min(student.values()))              # 78



'''
✅ Step 6 (contd.): Powerful Python Built-ins
🔹 3. enumerate() – Index + Value while looping
'''

fruits = ["apple", "banana" , "cherry"]

for index , value , in enumerate(fruits):
    print(f"{index}: {value}")
    
    
# 📌 enumerate() is super useful when you want the position + value while looping.

# 🔹 4. zip() – Combine two or more lists

names = ["Adarsha" , "Raj" , "Sneha"]
scores = [85 , 90 , 78]

for name, score in zip(names,scores):
    print(f"{name} scored {score}")
    
print(list(zip(names,scores)))



# ✍️ Practice Task (Try This):

students = ["Anil", "Priya", "Sana"]
marks = [88, 92, 76]

# Print "Anil got 88 marks" using zip
# Print with index like "1. Priya got 92 marks" using enumerate + zip

for student, mark in zip(students, marks):
    print(f"{student} got {mark} marks")
    

# ✅ With enumerate() + zip():

students = ["Anil", "Priya", "Sana"]
marks = [88, 92, 76]

for i , (student, mark) in enumerate(zip(students,marks), start=1):
    print(f"{i} {student} got {mark}")
    


# 🔹 1. map() – Apply a function to every element in a list

numbers = [1, 2, 3, 4]

def double(x):
    return x * 2

result =list(map(double,numbers))
print(result)


# ✅ Shorter version using lambda:

result_1 = list(map(lambda x:x*2, numbers))
print(result_1)

'''
🔹 2. filter() – Keep only values that match a condition
Example: Keep only even numbers
'''

numbers = [1,2,3,4,5,6]

def is_even(x):
    return x % 2 == 0

result = list(filter(is_even,numbers))
print(result)

# ✅ Shorter version using lambda:

result_2= list(filter(lambda x: x % 2 == 0, numbers))
print(result_2)
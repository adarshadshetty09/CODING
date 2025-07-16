# Creating the String

name = "Adarsha"
greeting = "Hello"
multiline = """ This is 
a multiline 
string."""

print(name)
print(greeting)
print(multiline)



# String Indexing 
word  = "Python"

print(word)
print(word[0])
print(word[-1])
print(word[2])


# Slicing String

text = "Developer"
print(text[0:4]) # Deve
print(text[:4]) # Deve
print(text[4:]) # loper
print(text[-3:]) # per
print(text[:-3]) # Develo


word = "PYTHON"
print(f"The first letter {word[0]}")
print(f"The last letter {word[-1]}")

print(f"Print YTH is {word[1:4]}")

# Reverse the string using the slicing 
word = "PYTHON"
reverseString = word[::-1]
print(reverseString)


# ✅ Exercise 4: Print only every second character (alternate chars)

word = "Adarsha D Shetty"
print(word[::2])
print(word[::3])


# ✅ Step 2: String Operations in Python

first = "Hello"
second = "Adarsha"

result = first + " " + second
print(result)

# Repetition 
line  = "Hi ! " * 3
print(line) 



# Membership: in / not in 

text = "Python Programming"
print("Python" in text)

print("java" not in text)


# String Comparison 
a = "apple"
b = "banana"

print(a==b)
print(a < b)
print(a != b)

name = "Adarsha"
print("Hello My Name Is ", name)

word = "DevOps Engineer"
print("Dev" in word)

print("Learn " * 4)

# ✅ Step 3.1: Case Conversion Methods in Strings

name = "Adarsha D Shetty"
print(name.upper())

print(name.lower())

print(name.capitalize())


name = "adarsha shetty"
text = "hello PYTHON world"

print(name.title())
print(text.lower())
print(text.upper())
print(text.capitalize())


# ➡️ Next Up: Let’s Learn About String Cleaning and Replacing
# These are super handy in real-world text processing:


# ✅ Step 3.2: Cleaning and Replacin

# 🔹 1. strip() – Remove spaces from both ends

msg = "   Hello Adarsha          "
print(msg.strip())
print(msg.lstrip())
print(msg.rstrip())


# replace (old, new)

text = "Python is fun"
print(text.replace("fun","dum"))

word = "banana"
print(word.count("a"))


data = "  Welcome to Python Class  "
msg = "Python is powerful and Python is easy"

print(data.strip())
print(msg.replace("Python", "Java"))
print(msg.count("Python"))

# ✅ Step 3.3: Search & Check Methods

# 🔹 1. startswith() / endswith()

s = "Hello Python"
print(s.startswith("Hello"))
print(s.endswith("Java"))

text = "Data Science with Python"
print(text.find("Python"))
print(text.find("Java"))

print(text.index("Science"))

line = "Python is fun and powerful."

print(line.startswith("Python"))
print(line.endswith("powerful."))
print(line.find("fun"))
print(line.index("is"))


# ✅ Step 4: split() and join()

# 🔹 1. split() – Split a string into a list

sentence = "Python is fun"
words = sentence.split()
print(words)

# You can also split by a custom separator:
csv = "apple, banana, grape"
fruit = csv.split(",")
print(fruit)

# 🔹 2. join() – Join a list into a string

word = ["Learn", "Python", "Fast"]
sentence = "".join(word)
print(sentence)

sentence1 = ",".join(word)
print(sentence1)

sentence1 = "-".join(word)
print(sentence1)

# 1. Split the string into words
line = "Python makes coding fun"

# 2. Split the string "a:b:c" by ":"
# 3. Join the list ["Dev", "Ops", "Engineer"] with "-"

print(line.split())
line1 = "a:b:c"
print(line1.split(":"))

word = ["Dev", "Ops", "Engineer"]

result = "-".join(word)
print(result)


# 🔥 Next: Step 5 – String Validations

print("Adarsha123".isalnum())   # True
print("Adarsha".isalpha())      # True
print("1234".isdigit())         # True
print("adarsha".islower())      # True
print("   ".isspace())          # True


'''
word1 = "Python3"
word2 = "hello"
word3 = "12345"
word4 = "   "

'''

word1 = "Python3"
word2 = "hello"
word3 = "12345"
word4 = "   "


print(word1.isalnum())   # True → contains only letters and digits (no special chars)
print(word2.islower())   # True → all lowercase
print(word3.isdigit())   # True → all are digits
print(word4.isspace())   # True → only spaces

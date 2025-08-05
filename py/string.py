# ✅ Step 1: Creating Strings

name = "Adarsha"
greeting = "Hello"
multiline = """This is 
a multiline 
string."""

print(name)
print(greeting)
print(multiline)

# ✅ Step 2: String Indexing

word = "Python"
print(word)         # Python
print(word[0])      # P
print(word[-1])     # n
print(word[2])      # t

# ✅ Step 3: Slicing Strings

text = "Developer"
print(text[0:4])    # Deve
print(text[:4])     # Deve
print(text[4:])     # loper
print(text[-3:])    # per
print(text[:-3])    # Develo

word = "PYTHON"
print(f"The first letter is {word[0]}")
print(f"The last letter is {word[-1]}")
print(f"Characters YTH: {word[1:4]}")

# ✅ Step 4: Reverse String with Slicing

reverse_string = word[::-1]
print(reverse_string)  # NOHTYP

# ✅ Step 5: Alternate Characters (Slicing with Step)

word = "Adarsha D Shetty"
print(word[::2])  # Every 2nd char
print(word[::3])  # Every 3rd char

# ✅ Step 6: String Operations

# Concatenation
first = "Hello"
second = "Adarsha"
result = first + " " + second
print(result)

# Repetition
line = "Hi ! " * 3
print(line)

# Membership (in / not in)
text = "Python Programming"
print("Python" in text)       # True
print("java" not in text)     # True

# String Comparison
a = "apple"
b = "banana"
print(a == b)                 # False
print(a < b)                  # True
print(a != b)                 # True

name = "Adarsha"
print("Hello My Name Is", name)

word = "DevOps Engineer"
print("Dev" in word)          # True

print("Learn " * 4)

# ✅ Step 7: Case Conversion Methods

name = "Adarsha D Shetty"
print(name.upper())           # All caps
print(name.lower())           # All lowercase
print(name.capitalize())      # First letter capital

name = "adarsha shetty"
text = "hello PYTHON world"

print(name.title())           # Capitalize each word
print(text.lower())
print(text.upper())
print(text.capitalize())

# ✅ Step 8: String Cleaning and Replacing

msg = "   Hello Adarsha          "
print(msg.strip())            # Remove spaces both ends
print(msg.lstrip())           # Left strip
print(msg.rstrip())           # Right strip

text = "Python is fun"
print(text.replace("fun", "dum"))  # Replace words

word = "banana"
print(word.count("a"))        # Count occurrences

data = "  Welcome to Python Class  "
msg = "Python is powerful and Python is easy"

print(data.strip())
print(msg.replace("Python", "Java"))
print(msg.count("Python"))

# ✅ Step 9: Search & Check Methods

s = "Hello Python"
print(s.startswith("Hello"))     # True
print(s.endswith("Java"))        # False

text = "Data Science with Python"
print(text.find("Python"))       # Position or -1
print(text.find("Java"))         # -1
print(text.index("Science"))     # Will error if not found

line = "Python is fun and powerful."
print(line.startswith("Python"))    # True
print(line.endswith("powerful."))   # True
print(line.find("fun"))             # 10
print(line.index("is"))             # 7

# ✅ Step 10: split() and join()

sentence = "Python is fun"
words = sentence.split()
print(words)                      # ['Python', 'is', 'fun']

csv = "apple, banana, grape"
fruit = csv.split(",")
print(fruit)

word_list = ["Learn", "Python", "Fast"]
print("".join(word_list))         # LearnPythonFast
print(",".join(word_list))        # Learn,Python,Fast
print("-".join(word_list))        # Learn-Python-Fast

# More Examples
line = "Python makes coding fun"
print(line.split())               # ['Python', 'makes', 'coding', 'fun']

line1 = "a:b:c"
print(line1.split(":"))           # ['a', 'b', 'c']

roles = ["Dev", "Ops", "Engineer"]
result = "-".join(roles)
print(result)                     # Dev-Ops-Engineer

# ✅ Step 11: String Validations

print("Adarsha123".isalnum())     # True
print("Adarsha".isalpha())        # True
print("1234".isdigit())           # True
print("adarsha".islower())        # True
print("   ".isspace())            # True

# More validation examples

word1 = "Python3"
word2 = "hello"
word3 = "12345"
word4 = "   "

print(word1.isalnum())            # True
print(word2.islower())            # True
print(word3.isdigit())            # True
print(word4.isspace())            # True

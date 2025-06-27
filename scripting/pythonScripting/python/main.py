
'''
Write a script convert.py that:

Takes input from the user

Converts it to int, float, and str

Prints all conversions
'''





'''
value  = input("Enter a number: ")

try: 
    i = int(value)
    f = float(value)
    s = str(value)
    
    print("Integer: ", i)
    print("Float: ",f)
    print("String: ", s)
    
except ValueError:
    print("Cannot covert that to int or float")
    
    
print("Hello, World")
'''


'''
import sys
print(sys.version)
'''


'''
Global Variables

we can define the global variable inside the function also 

 'global'  **
 
'''


'''
Text Type:	str

Numeric Types:	int, float, complex

Sequence Types:	list, tuple, range

Mapping Type:	dict

Set Types:	set, frozenset

Boolean Type:	bool

Binary Types:	bytes, bytearray, memoryview

None Type:	NoneType

'''

# str
x = "Hello World"
print(type(x))


# int 
x = 20
print(type(x))

# float
x = 20.5
print(type(x))


# Complex
x = 1j
print(type(x))

# list
x = ["apple", "banana","cherry"]
print(type(x)) 

# tuple
x = ("apple","banana","cherry")
print(type(x))

# range
x = range(6)
print(type(x))

# dict
x = {"name":"John","age":36}
print(type(x))

# set
x = {"apple","banana","cherry"}
print(type(x))

# frozenset
x = frozenset({"apple","banana","cherry"})
print(type(x))

# bool
x = True
print(type(x))

# bytes
x = b"Hello"
print(type(x))

# bytearray
x = bytearray(5)
print(x)
print(type(x))

# memoryview
x = memoryview(bytes(5))
print(x)
print(type(x))

x = None
print(x)
print(type(x))


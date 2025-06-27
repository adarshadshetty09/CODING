# print("Hello, Adarsha! Welcome to Pythoin Scritping.")

# hello_variable.py

 name = "Adarsha"
 age = 25
 is_devops = True
 height = 5.6

 print("Name: ", name)
 print("Age: ", age)
 print("DevOps Engineer ?", is_devops)
 print("Height", height)


 # user_input.py 

 naam = input("Enter your name: ")
 age1 = input("Enter your age: ")

 print("Hello", naam + "!")
 print("You are", age1, "years old")


 # age_check.py

 age2 = int(input("Enter your age: "))  # variable age2 string to int 

 if age2 >= 18: 
     print("Your are an adult.")
 else: 
     print("Your are not an adult yet.")



 # grade_check.py


 marks = int(input("Enter your marks: "))

 if marks >= 90: 
     print("Grade: A")
 elif marks >= 75: 
     print("Grade: B")
 elif marks >= 60: 
     print("Grade: C")
 else: 
     print("Grade: F")



 # weather.py

 temp = float(input("Enter the temperature in degree celsius: "))

 if temp > 30:
     print("It's hot")
 elif 20 <= temp <= 30:
     print("Nice weather.")
 else: 
     print("It's cool")

 # for_loop_example.py


 for i in range(1,6):
     print("Number:", i)

 # while_loop_example.py

 n = 5
 while n > 0:
     print("CountDown: ", n)
     n -= 1
 print("Liftoff")


 for i in range(1,6):
     if i == 3:
         break
     print("Value:",i)


 # multiplication_table.py

 num = int(input("Enter the number: "))
 for i in range(1,11):
     print(num ,"*", i ,"=", num*i)


 # multiplication_table.py (improved)

 num = int(input("Enter the number: "))
 for i in range(1,11):
     print(f"{num} x {i} = {num * i}")


 # 🐍 Python Scripting – Lesson 4: Functions


 def function_name():
     # code block
     print("This is a function.")

 def greet():
     print("Hello, Adarsha! Welcome Back.")

 function_name()
 greet()


 def greet_user(name): #  Function with parameters
     print(f"Hello, {name}")
 greet_user("Adarsha")

 def add(a, b): # Function with return value
     return a + b
 result = add(10,20)
 print("Sum is: ", result)


 # Multiplication Table with Function

 def print_table(number):
     for i in range(1,11):
         print(f"{number} x {i} = {number * i}")

 num = int(input("Enter a number: "))
 print_table(num)



 # calculator.py

 def add(a,b):
     return a + b

 def substract(a,b):
     return a - b

 def multiply(a,b):
     return a * b

 def divide(a,b):
     if a == 0:
         return "Cannot divide by zero!"
     return a / b

 print("Select Operation: ")
 print("1. Add")
 print("2. Substract")
 print("3. Multiply")
 print("4. Divide")

 choice = input("Enter choice (1/2/3/4): ")

 # Input two numbers

 num1 = float(input("Enter first number: "))
 num2 = float(input("Enter second number: "))

 # Call appropriate function 

 if choice == '1':
     print("Result: ", add(num1, num2))
 elif choice == '2':
     print("Result: ", substract(num1, num2))
 elif choice == '3':
     print("Result: ", multiply(num1, num2))
 elif choice == '4':
     print("Result: ", divide(num1, num2))
 else: 
     print("Invalid choice")

 # 🔹 Example 1: Writing to a File

 with open("notes.txt","w") as file:
     file.write("This is your first Python file.\n")
     file.write("File handling is powerful !\n")


 # 🔹 Example 3: Appending to a File

 with open("notes.txt", "a") as file1:
     file1.write("I am learning the Python script \n")
     file1.write("File Handling is one of the powerfull tool \n")



 # 🔹 Example 2: Reading from a File

 with open("notes.txt","r") as file:
     content = file.read()
     print("File Content: \n", content)


 # log_user_input.py

 hesaru = input("Enter the name: ")
 technology = input("Enter the DevOps Technology: ")

 hesaru_1 = input("Enter the name: ")
 technology_1 = input("Enter the DevOps Technology: ")

 with open("user_log.txt", "a") as file3:
     file3.write(f"Name: {hesaru} | Tech: {technology}\n")
     file3.write(f"Name: {hesaru_1} | Tech: {technology_1}\n")







 # log_user_input_loop.py

 while True:
     name = input("Enter the name: ")
     tech = input("Enter the DevOps Technology: ")

     with open("user_log.txt", "a") as file:
         file.write(f"Name: {name} | Tech: {tech}\n")

     more = input("Do you want to add another? (yes/no): ")
     if more.lower() != "yes":
         print("Exiting and saving all entries...")
         break


 import csv 

 with open ('devops_log.csv', mode='w',newline='') as file:
     writer = csv.writer(file)
     writer.writerow(['Name','Technology'])
     writer.writerow(['Adarsha','Docker'])
     writer.writerow(['Adarsha', 'Kubernetes'])
    
 import csv 

 with open('devops_log.csv', mode='w',newline='') as file1:
     writer = csv.writer(file1)
     writer.writerow(['Adarsha','Ansible'])
     writer.writerow(['Adarsha','Database'])
     writer.writerow(['Adarsha','Cloud'])



 # read_csv.py

 import csv
 # import os
 with open('devops_log.csv', mode='r') as file:
     reader = csv.reader(file)
     for row in reader:
         print(row)
        

 🔹 Example 3: Appending User Input to CSV

 # log_to_csv.py
##                                   ERROR
 import csv

 print("📄 DevOps Technology Logger\n")

 with open('devops_log.csv', mode='a', newline='') as file:
     writer = csv.writer(file)

     while True:
         print("------ New Entry ------")
         name = input("Enter your full name: ").strip()
         tech = input("Enter your DevOps Technology: ").strip()

         if name and tech:
             writer.writerow([name, tech])
             print("✅ Entry saved.")
         else:
             print("⚠️ Both fields are required. Try again.")
             continue

         more = input("\nDo you want to add another? (yes/no): ").strip().lower()
         if more != "yes":
             print("\n🚀 Exiting. All entries saved to devops_log.csv")
             break


 🔹 Importing the JSON Module
 🔹 Example 1: Converting Python → JSON (json.dump / json.dumps)

 import json 

 data = {
     "name": "Adarsha",
     "technology": "Docker"
 }

 data1 = {
     "name": "Shetty",
     "technology": "K8s"                
 }

 data2 = {
     "name": "Anisha",
     "technology": "Terraform" 
 }
 data3 = {
     "name": "Shobha",
     "technology": "Ansible"
 }

 # Write JSON to file 
 with open("devops.json","w") as file:
     json.dump(data,file,indent=4)
    
 with open("devops.json","w") as file:
     json.dump(data1, file,indent=4)
    
 with open("devops.json","w") as file:
     json.dump(data2, file, indent=4)

 with open("devops.json","w") as file:
     json.dump(data3, file,indent=4)

 # important
 all_data = [data, data1, data2, data3]

 with open("devops.json","w") as file:
     json.dump(all_data,file,indent=4)
    


 # 🔹 Example 2: Reading JSON → Python (json.load / json.loads)

 import json 

 # Read JSON from file

 with open("devops.json", "r") as file: 
     data = json.load(file)

 for records in data: 
     print("Name: ",records["name"])
     print("Tech: ",records["technology"])
     print() 
    
# Don't run 
 import json

 devops_team = [
     {"name": "Adarsha", "technology": "Docker"},
     {"name": "Ravi", "technology": "Kubernetes"}
 ]

 with open("team.json", "w") as file:
     json.dump(devops_team, file, indent=4)


 # Logging DevOps Users to a JSON File 

 import json

 print("DevOps Team Logger (JSON Format)\n")

 devops_team = []

 while True:
     print("------ New Entry ------")
     name = input("Enter your full name: ").strip()
     tech = input("Enter DevOps Technology: ").strip()

     if name and tech:
         devops_team.append({"name": name, "technology": tech})
         print("Entry added to list.")
     else:
         print("Both fields are required. Try again.")
         continue

     more = input("\nDo you want to add another? (yes/no): ").strip().lower()
     if more != "yes":
         break

 # Save the list to JSON file
 with open("team_log.json", "w") as file:
     json.dump(devops_team, file, indent=4)

     print("\nExiting. All entries saved to team_log.json")


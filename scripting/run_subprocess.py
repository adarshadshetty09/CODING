# import subprocess

# result = subprocess.run(["ls", "-l"], capture_output=True, text=True)

# print("Return Code:", result.returncode)
# print("Output:\n", result.stdout)
# print("Error:\n", result.stderr)




# command_0 = ["ping","-n","2","google.com"]

# result_0 = subprocess.run(command_0, capture_output=True, text=True)

# if result_0.returncode == 0: 
#   print("Ping Successfull! ")
#   print(result_0.stdout)
# else: 
#   print("Ping failed")
#   print(result_0.stderr)



# command_1 = input("Enter a shell command to run: ").split()

# result_1 = subprocess.run(command_1, capture_output=True, text=True)

# print("Output: \n", result_1.stdout)
# print("Error: \n", result_1.stderr)
#
#
#import logging 
#
#logging.basicConfig(level=logging.INFO)
#logging.info("Script Started")
#logging.warning("This is just a warning")
#logging.error("Something went wrong")
#
#

import logging

logging.basicConfig(
    filename='app.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logging.info("Script started")
logging.warning("Be careful!")
logging.error("Something failed!")


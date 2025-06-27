import subprocess

def run_command(description, command):
    print(f"\n🔹 {description}")
    result = subprocess.run(command, capture_output=True, text=True)
    
    if result.returncode == 0:
        print(result.stdout.strip())
    else:
        print("❌ Error:")
        print(result.stderr.strip())

# Run system commands
run_command("Current User (whoami):", ["whoami"])
run_command("System Uptime:", ["uptime"])
run_command("Disk Usage (df -h):", ["df", "-h"])


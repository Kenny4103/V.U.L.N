import subprocess
import schedule
import time
from datetime import datetime

def run_script_b():
    try:
        # Run script_b.py using subprocess
        subprocess.Popen(['sudo', 'python3', 'CustomDirScan.py'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
        print("Schedule Started!")
    except subprocess.CalledProcessError as e:
        print(f"Error executing script_b.py: {e}")

def job():
    print(f"Running job at {datetime.now()}")
    run_script_b()

if __name__ == "__main__":
    # Take user input for the desired time of day
    user_time = input("Enter the time in HH:MM format (24-hour clock): ")
    try:
        # Convert user input to datetime object
        scheduled_time = datetime.strptime(user_time, "%H:%M")
    except ValueError:
        print("Invalid time format. Please use HH:MM.")
        exit()

    # Schedule the job to run every day at the specified time
    schedule.every().day.at(user_time).do(job)

    print(f"Scheduled task set for {user_time}")

    # Keep the script running to allow the scheduler to work
    while True:
        schedule.run_pending()
        time.sleep(30)
        print ("waiting")
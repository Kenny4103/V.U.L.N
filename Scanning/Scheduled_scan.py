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
    schedule.every().day.at("18:26").do(job)
    

    # Keep the script running to allow the scheduler to work
    while True:
        schedule.run_pending()
        time.sleep(1)
        print ("waiting")
import subprocess

def run_schedule():
    try:
        # Run the command and redirect output and error to null
        with open('scan_output.log', 'w') as out_file, open('scan_error.log', 'w') as err_file:
            subprocess.Popen(['python3', 'Scheduled_scan.py'], stdout=out_file, stderr=err_file, text=True, close_fds=True)
        print("Program started in the background.")
    except Exception as e:
        print(f"Error executing the command: {e}")

if __name__ == "__main__":
    run_schedule()
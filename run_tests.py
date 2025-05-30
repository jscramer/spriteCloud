from dotenv import load_dotenv
import subprocess

# Load environment variables from .env file
load_dotenv()

# Run the tests
subprocess.run(["robot", "testsuites/"])
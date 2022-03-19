
# Basic structure
All APM files provided my the course instructor, Tool.sh(main script) and KillAllApm.sh reside in /home/student/Project.  
CPU and MEM monitor scripts resid in ~/Project1/monitor.
The monitor logs reside in ~/Project1/log.

# Basic fucntionality
The Toll.sh script starts all provided APM services.  it also kills them by calling the KillAllApm.sh script. 
All monitor scripts are started by the Tool.sh script once all APM services are started.  these monitor scripts continuously loop and write CPU and MEM info to a log file.  they are killed when Tool.sh is stopped.

command ``` ./Tool.sh ``` is all that is needed to trigger and stop all events.  it is currently set to run for 20 seconds but can be adjusted






















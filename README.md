# contest-template

# run.sh usage
1. `create [problem]`  
Creates the directory structure for `problem` including the problem statement format.  
Example: `./run.sh create 3`

2. `cases [problem] [start] [end]`  
Creates blank test case input files for `problem` from `start` to `end`.
Example: `./run.sh cases 3 0 5`

3. `generator [problem] [file without .cpp] [start] [end]`  
Compiles the test case generator `file` for `problem` and generates test case input files from `start` to `end`.
Example: `./run.sh generator m 3 0 5`

4. `solution [problem] [file without .cpp] [start] [end]`  
Compiles the author solution `file` for `problem` and generates test case output files from `start` to `end`.
Example: `./run.sh solution m 3 0 5`

5. `zip [problem]`  
Zips the test cases for `problem`.
Example: `./run.sh zip 3`

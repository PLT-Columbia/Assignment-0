# COMS W4115: Programming Assignment 0
## Setting up Environment for Programming Assignments.


### Logistics
- **Announcement Date:** September 9th, 2020
- **Due Date:** September 20th, 2020 by 11.59pm. **No extension!!**
- **Total Points:** 10

### Setting up Github classroom.

Throughout the semester, we will be using [github classroom](https://classroom.github.com/) 
for programming assignment submission.
- Create a github account where the username **exactly matches your UNI**. 
Use that account for all the programming assignment submission fot this class. 
We will be using autogradingin in most cases, this step makes the submissions tractable.
- For each assignment, you will receive an github classroom invitation through gradescope/coursework.
- Login to github with your **UNI username** and accept the invitation. 
- This will create a repository foryou where you have the write access.
- After you have done your assignment, push. Once your assignment is graded, 
you will find reviews inthat same repository in the form of a pull request.


### Build Clang and LLVM
- Create Ubuntu 18.04.3 Virtual Machine You can use either Vmware Workstation 
15 Player or Virtualbox to install Ubuntu 18.04.3. 
    - For grading, we will be using 
    - At least 8GB memory is required for the virtual machine, 12GB memory is recommended. 
    - 120GB hard disk isrequired, 
- Install necessary packages
    - ``sudo apt update``
    - ``sudo apt upgrade``
    - ``sudo apt install build-essential subversion cmake python3-dev``
    - ``sudo apt install libncurses5-dev libxml2-dev libedit-dev swig``
    - ``sudo apt install doxygen graphviz xz-utils git``
- Build clang and llvm by following the instructions in the 
[Clang/LLVM website](http://clang.llvm.org/get_started.html).
    - You need to build Clang and LLVM from source in debug mode. It will take hours for building to finish.
    - In this repository, we added LLVM source from [this commit](https://github.com/llvm/llvm-project/tree/d1be928d23fe6b6770be007c7fd0753ca4d17516). 
    You may use this for all future assignemnts.

#### Note: Here is a <ins>**non-exhaustive list**</ins> of problems you might face during the setup process.

- If you face a problem with `cmake` version compatibility, follow 
[this solution](https://askubuntu.com/a/829311/).
- Before building Clang and LLVM, add 8G swap space in Ubuntu 
because building Clang and LLVM will take all the memory. 
    - [This blog](https://linuxize.com/post/how-to-add-swap-space-on-ubuntu-18-04/) 
    shows how to add swap space. Run `sudo swapoff -a` to disable swap first before creating swapfile.
- In case of out of memory issue during linking, add the following parameter 
in cmake `-DLLVM_USE_LINKER=gold` to use gold linker. 
    - Gold linker is faster and uses less memory.
- If there is any error during building Clang and LLVM, you can just run `make` again to doincremental build.
- Use `make -j 4` to take advantage of multiple cores of CPU, but it may take more memory.
- Play (and familiarize yourself) with the [clang/llvm examples.](http://clang.llvm.org/get_started.html#driver)


# Classroom 50 Tools

## What is this toolkit in a nutshell?

This repository is a collection of tools created to help instructors manage programming courses that use [Classroom 50](https://github.com/foundation50/classroom50/wiki). _Classroom 50_ and _GitHub_ cover most of the needs of a typical programming course. However, these platforms leave a few small gaps that this toolkit aims to fill.

## The Missing Pieces

### Classroom Setup

_Classroom 50_ handles the distribution of programming exercises and the collection of students' work very well. To do this, it needs to be configured with a list of students (a _roster_). Adding this list to _Classroom 50_ is straightforward: simply drag and drop a CSV file containing the students' email addresses.

Problems arise when this list changes. During the first few weeks of a course, it is common for students to join, leave, or change groups. Ideally, once an updated student list is available, it could simply be dragged and dropped again so that _Classroom 50_ would detect and apply the changes automatically. However, _this is not_ how it works:  uploading a new CSV _only adds new_ students; it never removes or updates existing ones. Such changes must be made manually, one student at a time.

In practice, however, the real problem is not making the changes manually, since there are usually not many group changes or departures. The real problem is _knowing which students_ have changed. This requires manually comparing both CSV files: the one currently in _Classroom 50_ and the new one. While this may be easy for courses with few students, it is tedious and error-prone for large classes. [roster50](https://github.com/raul-izquierdo/roster50) carry out this task automatically, detecting changes between both lists. Visit its [repository](https://github.com/raul-izquierdo/roster50) for more information on how to use it.

### Distributing Solutions

_Classroom 50_ does not provide a way to distribute assignment solutions to students, so this must be done directly through _GitHub_.

To grant students access to solutions on a group-by-group basis, you need a GitHub _team_ for each student group.
- [teams50](https://github.com/raul-izquierdo/teams50) makes it easy to create and maintain GitHub _teams_ from a _Classroom 50_ roster. Visit its [repository](https://github.com/raul-izquierdo/teams50) for more information on how to use it.
- Once the _teams_ have been created, [solutions50](https://github.com/raul-izquierdo/solutions50) lets you distribute solutions to students much more easily and quickly than through the GitHub web interface. Visit its [repository](https://github.com/raul-izquierdo/solutions50) for more information on how to use it.


## Tools included in this toolkit

The toolkit includes the following applications:
- [roster50.jar](https://github.com/raul-izquierdo/roster50). Creates and maintains the _Classroom 50_ roster.
- [sies2csv.jar](https://github.com/raul-izquierdo/sies2csv). Extracts data from a SIES Excel file and converts it to a CSV file to be used by `roster50.jar`. This tool is only intended for instructors at the University of Oviedo, who use SIES to manage their courses. It is not useful for instructors at other universities.
- [teams50.jar](https://github.com/raul-izquierdo/teams50). Creates and updates teams in GitHub using the _Classroom 50_ roster.
- [solutions50.jar](https://github.com/raul-izquierdo/solutions50). Specially designed for granting immediate access to solutions for each student group _during_ the session.

> Although they are not part of this toolkit because they serve more general purposes, the following tools may also be useful for simplifying common repository management tasks:
> - [merge-gits.jar](https://github.com/raul-izquierdo/merge-gits). A tool for merging the starter code of an assignment with its solution.
> - [repos-status](https://github.com/raul-izquierdo/repos-status). A script that recursively scans all Git repositories in a local directory tree and reports their synchronization status.
> - [grant](https://github.com/raul-izquierdo/grant). A tool for granting repository permissions to GitHub users or teams in batch.
>
> You may want to consult these projects after reading this documentation. Their usage is simpler, and they are not tied to a specific workflow.

These tools are written in Java and require JDK 21 or later.


## Toolkit Installation

> ⚠️ If you prefer to use only one or a few individual tools, follow the installation instructions in that tool's repository. However, installing all the tools in this toolkit is recommended. In that case, follow the instructions below instead of those in the individual tool documentation to simplify the process.

Follow these steps to install all the tools at once:

1. Clone this repository:
   ```bash
   git clone https://github.com/raul-izquierdo/classroom-50-tools.git
   cd classroom-50-tools
   ```

2. Run the script for the appropriate operating system to download (**or update**) the tools' JARs. These scripts will download the latest release of each tool from its repository.
   ```bash
   # Windows
   get-jars.cmd

   # Linux/Mac
   ./get-jars.sh
   ```

## Toolkit Configuration

> ⚠️ If you prefer to use only one or a few individual tools, follow the configuration instructions in that tool's repository. However, configuring all the tools in this toolkit is recommended. In that case, follow the instructions below instead of those in the individual tool documentation to simplify the process.

To configure all the tools at once, follow these steps:

1. (Optional) Create a `.env` file with the following variables:
    ```env
    CLASSROOM_NAME=<name of the _Classroom 50_ classroom>
    CLASSROOM_ORG=<organization associated with the _Classroom 50_ instance>
    SOLUTIONS_ORG=<organization that contains the repositories with the solutions>
    GITHUB_TOKEN=<GitHub token - see below for instructions>
    ```

    This step is optional but _highly_ recommended, as it allows you to run the tools without specifying command-line flags. This repository includes a `.env.example` file that you can copy and edit.

    Here's how to obtain values for the above variables:
    - `CLASSROOM_NAME` and `CLASSROOM_ORG` can be obtained from the _Classroom 50_ web interface. In the following image, the `CLASSROOM_ORG` is indicated by the red arrow (_MyC50Test_), and the `CLASSROOM_NAME` by the blue arrow (_TestClassroom_).

        ![alt text](img/parameters.png)

    - The organization specified in `SOLUTIONS_ORG` should **contain the solution repositories**. This may differ from the organization linked to _Classroom 50_. Some instructors prefer storing solutions in a separate organization from assignments (recommended). In that case, specify the organization containing the solutions here. Otherwise, you can use the same organization as `CLASSROOM_ORG`.
    - `GITHUB_TOKEN` should contain a GitHub personal access token with the `repo` and `admin:org` scopes. See the [GitHub documentation: Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic) for instructions.



2. Edit the `groups.csv` file with the schedules for your assigned groups (it initially contains sample data). This file will be used by [solutions50.jar](https://github.com/raul-izquierdo/solutions50) to automatically grant access to the solution repositories. The columns are: group name, day of the week, start time, and duration. If no duration is specified, a default of 2 hours is assumed. Example:
    ```csv
    01, monday, 21:00
    02, tuesday, 14:00, 3h
    i01, wednesday, 16:00, 45m
    ```

    For more information about the format of this file, see [groups file format](https://github.com/raul-izquierdo/roster#groups-file-format).

3. (Optional but highly recommended) Create a desktop shortcut to `solutions.cmd` (Windows) or `solutions.sh` (Linux/Mac). This lets you launch the program quickly and easily during class without opening a terminal or typing commands. See [solutions50](https://github.com/raul-izquierdo/solutions50) for more information about using this tool.



## License

See `LICENSE`.
Copyright (c) 2026 Raul Izquierdo Castanedo

# Classroom 50 Tools

## What is this toolkit in a nutshell?

This repository contains a set of tools designed to help instructors manage programming courses that use [Classroom 50](https://github.com/foundation50/classroom50/wiki). _Classroom 50_ and _GitHub_ cover most of the needs of a typical programming course. However, these platforms leave a few gaps that this toolkit aims to fill.

## The Missing Pieces

### Classroom Setup

_Classroom 50_ handles the distribution of programming exercises and the collection of students' work very well. To do this, it needs to be configured with a list of students (a _roster_). Adding this list to _Classroom 50_ is straightforward: simply drag and drop a CSV file containing at least the students' email addresses.

Problems arise when this list changes. During the first few weeks of a course, it is common for students to join, leave, or switch groups. _Ideally_, once an updated student list is available, it could simply be dragged and dropped again so that _Classroom 50_ would detect and apply the changes automatically. However, **that is not** how it works: uploading a new CSV _only adds new_ students; it never removes or updates existing ones. Such changes must be made manually, one student at a time.

In practice, though, the real problem is not making those changes manually, since there are usually not many group changes or departures. The real issue is _knowing which students_ have changed. This requires manually comparing both CSV files: the one currently in _Classroom 50_ and the new one. While this may be easy for courses with few students, it becomes tedious and error-prone for large classes. [roster50](https://github.com/raul-izquierdo/roster50) carries out this task automatically by detecting changes between both lists. Visit its [repository](https://github.com/raul-izquierdo/roster50) for more information on how to use it.

### Distributing Solutions

_Classroom 50_ does not provide a way to distribute assignment solutions to students, so this must be done directly through _GitHub_.

To grant students access to solutions on a group-by-group basis, you need a GitHub _team_ for each student group.
- [teams50](https://github.com/raul-izquierdo/teams50) makes it easy to **create and maintain** GitHub _teams_ from a _Classroom 50_ roster. Visit its [repository](https://github.com/raul-izquierdo/teams50) for more information on how to use it.
- Once the _teams_ have been created, [solutions50](https://github.com/raul-izquierdo/solutions50) lets you **distribute solutions** to students much more easily and quickly than through the GitHub web interface. Visit its [repository](https://github.com/raul-izquierdo/solutions50) for more information on how to use it.

## TL;DR - Quick summary of when to use each tool

Although it is recommended to read the documentation for each tool to understand how it works, the following is a quick summary of when to use each one. This section assumes that the [installation](#toolkit-installation) and [configuration](#toolkit-configuration) of the toolkit have already been completed.

- Whenever the list of students for a course changes (which is most common at the beginning of the course), the Classroom 50 roster should be updated. To do this, assuming the new list is in `new_roster.csv`, run:
    ```bash
    java -jar roster50.jar
    ```
    [roster50](https://github.com/raul-izquierdo/roster50) will show which changes the new list introduces and, therefore, what needs to be updated in the _Classroom 50_ roster.

    If the instructor has access to SIES (University of Oviedo), the easiest way to obtain `new_roster.csv` is to use [sies2csv](https://github.com/raul-izquierdo/sies2csv). Before running `roster50.jar`, download `alumnosMatriculados.xsl` and then run:
    ```bash
    java -jar sies2csv.jar
    ```

- Whenever there are changes in the Classroom 50 roster, the GitHub teams used to provide group-by-group access to exercise solutions must be updated. To do this, simply run:
    ```bash
    java -jar teams50.jar
    ```

    [teams50](https://github.com/raul-izquierdo/teams50) updates the teams by adding students, removing them, or changing their group membership so that they end up synchronized with the current state of the Classroom 50 roster (in Classroom 50, each student's group is in the _section_ column).

- During class, when the instructor wants to give access to the solution of the exercise being explained only to the students in the group attending that class, they only need to run:
    ```bash
    java -jar solutions50.jar
    ```
    [solutions50](https://github.com/raul-izquierdo/solutions50) will infer which group is in class at that moment and which solution has been explained, and will grant access automatically.

## Toolkit Installation

> ⚠️ If you prefer to use only one or a few individual tools, follow the installation instructions in that tool's repository. However, installing all the tools in this toolkit is recommended. In that case, follow the steps below instead of the instructions in each individual tool's documentation to simplify the process.

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

> ⚠️ If you prefer to use only one or a few individual tools, follow the configuration instructions in that tool's repository. However, configuring all the tools in this toolkit is recommended. In that case, follow the steps below instead of the instructions in each individual tool's documentation to simplify the process.

To configure all the tools at once, follow these steps:

1. (Optional) Create a `.env` file with the following variables:
    ```env
    CLASSROOM_NAME=<name of the _Classroom 50_ classroom>
    CLASSROOM_ORG=<organization associated with the _Classroom 50_ instance>
    SOLUTIONS_ORG=<organization that contains the repositories with the solutions>
    GITHUB_TOKEN=<GitHub token - see below for instructions>
    ```

    This step is optional but _highly_ recommended, because it allows you to run the tools without specifying command-line flags. This repository includes a `.env.example` file that you can copy and edit.

    Here is how to obtain values for the variables above:
    - `CLASSROOM_NAME` and `CLASSROOM_ORG` can be obtained from the _Classroom 50_ web interface. In the following image, `CLASSROOM_ORG` is indicated by the red arrow (_MyC50Test_), and `CLASSROOM_NAME` by the blue arrow (_TestClassroom_).

        ![alt text](img/parameters.png)

    - The organization specified in `SOLUTIONS_ORG` should **contain the solution repositories**. This may differ from the organization linked to _Classroom 50_. Some instructors prefer to store solutions in a separate organization from assignments (recommended). In that case, specify the organization containing the solutions here. Otherwise, you can use the same organization as `CLASSROOM_ORG`.
    - `GITHUB_TOKEN` should contain a GitHub personal access token with the `repo` and `admin:org` scopes. See the [GitHub documentation: Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic) for instructions.

2. Edit the `groups.csv` file to define the schedule for each assigned group (the file initially contains sample data). [solutions50](https://github.com/raul-izquierdo/solutions50) uses this file to determine which group is currently in the classroom. The columns are: group name, day of the week, start time, and duration. If no duration is specified, a default of 2 hours is assumed. Example:
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

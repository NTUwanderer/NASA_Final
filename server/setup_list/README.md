## Purpose

Count the number of users and list them all in a file.

## Compile
```bash
$ g++ main.cpp -std=c++11 -o main.out
```

## Execute
```bash
$ ./main.out < input > output
```

## Inputs
number of groups, number of individuals

#### Groups
prefix, start index, end index

#### Individuals
id of the individual

### Example
3 2<br>
b03902 1 3<br>
b04902 1 3<br>
b05902 1 3<br>
b03901018<br>
b03901078

## Outputs
The first line contains u, number of users, and the second line contains all u users' ids.
The fourth line contains g, number of groups, and g following lines contain u_i number of users in the group, group name (prefix), and all u_i users' ids.


### Example
11<br>
b03902/b03902001 b03902/b03902002 b03902/b03902003 b04902/b04902001 b04902/b04902002 b04902/b04902003 b05902/b05902001 b05902/b05902002 b05902/b05902003 others/b03901018 others/b03901078

4<br>
3 b03902 b03902001 b03902002 b03902003<br>
3 b04902 b04902001 b04902002 b04902003<br>
3 b05902 b05902001 b05902002 b05902003<br>
2 others b03901018 b03901078

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
The first line contains number of users, and the second line contains all users' ids.

### Example
11<br>
b03902001 b03902002 b03902003 b04902001 b04902002 b04902003 b05902001 b05902002 b05902003 b903901018 b03901078

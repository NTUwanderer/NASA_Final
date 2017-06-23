## Purpose

Redistribute the grouping based on the previous distribution and number of add/remove nfs servers

## Compile
```bash
$ g++ main.cpp -std=c++11 -o main.out
```

## Execute
```bash
$ ./main.out add <prev_dist> <dist> <modified>
$ ./main.out remove <prev_dist> <dist> <modified>
```
Add: give number to add as standard input<br>
Remove: give r, number to remove and r following index (0, 1, ..., n-1)

### Description
<prev_dist> is the previous distribution.

<dist> is the new distribution.

<modified> is a file recording all modifications that should be handle.

### Example of dist
3<br>
4 b03902001 b03902002 b03902003 b04902001<br>
4 b04902002 b04902003 b05902001 b05902002<br>
3 b05902003 b03901018 b03901078<br>

#### Format
The first line contains number of nfs.

The following lines contain n_i, number of users in the i-th nfs, and n_i user ids.

### Example of modified
3<br>

Move 1<br>
b03902003 1 0<br>

#### Format
The first line contains k, number of nfs.

The number m after "Move" is number of user transitions, and m lines following, each contains the user id, prev nfs index, and new nfs index.


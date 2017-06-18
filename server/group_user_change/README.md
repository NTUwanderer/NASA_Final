## Purpose

Check changes of groups and users in groups between the previous user_list and the current user_list, so that we can mkdir and rmdir of groups and users in nfs servers.

## Compile
```bash
$ g++ main.cpp -std=c++11 -o main.out
```

## Execute
```bash
$ ./main.out <prev_user_list> <user_list> > changes
```

### Description
<prev_user_list> is the previous user_list.

<user_list> is the current user_list.

We can redirect the standard output to file "changes".

### Example
prev_user_list, user_list, changes are the example of inputs, outputs.

#### Format of changes
The line after "Modified" contains m, number of modified groups.<br>
Three following lines of each modified groups. The first line contains the group name. The second line contains m_r_i, number of removed users, and m_r_i user ids. The third line contains m_a_i, number of added users, and m_a_i user ids.

The line after "Remove" contains r, number of removed groups.<br>
There are r following lines, for each containing r_i, number of users in the i-th removed group, the group name, and r_i user ids.

The line after "Add" contains a, number of removed groups.<br>
There are a following lines, for each containing a_i, number of users in the i-th added group, the group name, and a_i user ids.


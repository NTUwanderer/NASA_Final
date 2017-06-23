#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <ctype.h>
#include <algorithm>

using namespace std;

int main(int argc, char** argv) {

	if (argc != 5) {
		printf("Please specify add or remove, <prev_dist>, <dist>, <modified>\n");
		return 0;
	}

	string firstArg = string(argv[1]);
	transform(firstArg.begin(), firstArg.end(), firstArg.begin(), ::tolower);

	int number;

	if (firstArg == "add" || firstArg == "remove") {
		cin >> number;
		if (number <= 0) {
			printf("Please give number to add > 0\n");
			return 0;
		}
	} else {
		printf("Please use add or remove as the first argument\n");
	}

	fstream prev_dist (argv[2], fstream::in);
	fstream dist (argv[3], fstream::out);
	fstream modified (argv[4], fstream::out);

	vector<vector<string> > nfs;
	int numOfNfs;
	prev_dist >> numOfNfs;
	int totalNum = 0;
	for (int i = 0; i < numOfNfs; ++i) {
		vector<string> group;
		int groupSize;
		prev_dist >> groupSize;
		totalNum += groupSize;
		for (int j = 0; j < groupSize; ++j) {
			string user;
			prev_dist >> user;
			group.push_back(user);
		}
		nfs.push_back(group);
	}

	string modifiedString = "";

	if (firstArg == "add") {
		int newNum = numOfNfs + number;
		modified << newNum << "\n\nMove ";
		int* sizes = new int[newNum];
		int average = totalNum / newNum;
		int numOfRemainder = totalNum % newNum;

		for (int i = 0; i < newNum; ++i) {
			if (i < numOfRemainder)
				sizes[i] = average + 1;
			else
				sizes[i] = average;
		}

		for (int i = 0; i < number; ++i)
			nfs.push_back(vector<string>());

		int s = 0, i_s = sizes[s], e = numOfNfs, i_e = 0;

		int moveCount = 0;
		while (s != numOfNfs && e != newNum) {
			if (i_s == nfs[s].size()) {
				nfs[s].resize(sizes[s]);
				++s;
				i_s = sizes[s];
				continue;
			}

			if (i_e == sizes[e]) {
				++e;
				i_e = 0;
				continue;
			}

			string user = nfs[s][i_s];
			nfs[e].push_back(user);
			++i_s;
			++i_e;
			++moveCount;

			modifiedString += user + " " + to_string(s) + " " + to_string(e) + "\n";
		}

		modified << moveCount << "\n" << modifiedString;

		dist << newNum << "\n";
		for (int i = 0; i < newNum; ++i) {
			dist << nfs[i].size();
			for (int j = 0; j < nfs[i].size(); ++j) {
				dist << " " << nfs[i][j];
			}
			dist << "\n";
		}

		delete[] sizes;
	} else if (firstArg == "remove") {
		int newNum = numOfNfs - number;
		modified << newNum << "\n\nMove ";
		int* sizes = new int[newNum];
		int average = totalNum / newNum;
		int numOfRemainder = totalNum % newNum;

		for (int i = 0; i < newNum; ++i) {
			if (i < numOfRemainder)
				sizes[i] = average + 1;
			else
				sizes[i] = average;
		}

		int* rIndex = new int[number];
		int* index = new int[newNum];
		vector<vector<string> > removed;

		for (int i = 0; i < number; ++i) {
			cin >> rIndex[i];
			removed.push_back(nfs[rIndex[i]]);
			nfs[rIndex[i]].clear();
		}

		for (int i = 0, count = 0; i < nfs.size(); ++i) {
			if (! nfs[i].empty()) {
				index[count++] = i;
			}
		}

		int s = 0, i_s = nfs[index[s]].size(), e = 0, i_e = 0;

		int moveCount = 0;
		while (s != newNum && e != number) {
			if (i_s == sizes[index[s]]) {
				nfs[s].resize(sizes[s]);
				++s;
				i_s = nfs[index[s]].size();
				continue;
			}

			if (i_e == removed[e].size()) {
				++e;
				i_e = 0;
				continue;
			}
			string user = removed[e][i_e];
			nfs[index[s]].push_back(user);
			++i_s;
			++i_e;
			++moveCount;

			modifiedString += user + " " + to_string(rIndex[e]) + " " + to_string(index[s]) + "\n";

		}

		modified << moveCount << "\n" << modifiedString;

		dist << newNum << "\n";
		for (int i = 0; i < newNum; ++i) {
			int k = index[i];
			dist << nfs[k].size();
			for (int j = 0; j < nfs[k].size(); ++j) {
				dist << " " << nfs[k][j];
			}
			dist << "\n";
		}

		delete[] sizes;
		delete[] rIndex;
	}

	prev_dist.close();
	dist.close();
	modified.close();
	return 0;
}

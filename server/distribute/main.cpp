#include <iostream>
#include <string>
#include <vector>
#include <fstream>

using namespace std;

void removeOverlap(vector<string>& t_users, vector<string>& group, vector<string>& new_group) {
	for (unsigned i = 0; i < group.size(); ++i) {
		for (unsigned j = 0; j < t_users.size(); ++j) {
			if (group[i] == t_users[j]) {
				new_group.push_back(group[i]);
				group.erase(group.begin() + i);
				t_users.erase(t_users.begin() + j);
				--i;
				break;
			}
		}
	}
}

int main(int argc, char** argv) {

	if (argc != 5) {
		cout << "Four input filenames: user_list, prev_dist, dist, modified\n";
		return 0;
	}

	fstream user_list (argv[1], fstream::in);
	fstream prev_dist (argv[2], fstream::in);
	fstream dist (argv[3], fstream::out);
	fstream modified (argv[4], fstream::out);

	vector<string> users;
	int sizeOfUsers;
	user_list >> sizeOfUsers;
	for (int i = 0; i < sizeOfUsers; ++i) {
		string user;
		user_list >> user;
		users.push_back(user);
	}

	vector<vector<string> > nfs;
	vector<vector<string> > new_nfs;
	int numOfNfs;
	prev_dist >> numOfNfs;
	for (int i = 0; i < numOfNfs; ++i) {
		vector<string> group;
		int groupSize;
		prev_dist >> groupSize;
		for (int j = 0; j < groupSize; ++j) {
			string user;
			prev_dist >> user;
			group.push_back(user);
		}
		nfs.push_back(group);
		new_nfs.push_back(vector<string>());
	}
	
	vector<string> t_users = users;
	vector<vector<string> > t_nfs = nfs;

	for (int i = 0; i < numOfNfs; ++i) {
		removeOverlap(t_users, t_nfs[i], new_nfs[i]);
	}


	int average = users.size() / numOfNfs;
	int numOfRemainder = users.size() % numOfNfs;

	int* sizes = new int[numOfNfs];
	for (int i = 0; i < numOfNfs; ++i) {
		if (i < numOfRemainder)
			sizes[i] = average + 1;
		else
			sizes[i] = average;
	}

	modified << numOfNfs << "\n\nMove ";

	int modifiedCount = 0;
	string pairs = "";

	for (int i = 0; i < numOfNfs; ++i) {
		while (new_nfs[i].size() > sizes[i]) {
			int extra = new_nfs[i].size() - sizes[i];
			int j, space = 0, amountToMove;
			for (j = 0; j < numOfNfs; ++j) {
				if (new_nfs[j].size() < sizes[j]) {
					space = sizes[j] - new_nfs[j].size();
					break;
				}
			}
			amountToMove = min(extra, space);
			modifiedCount += amountToMove;

			for (int k = new_nfs[i].size() - amountToMove; k < new_nfs[i].size(); ++k) {
				pairs += new_nfs[i][k] + " " + to_string(i) + " " + to_string(j) + "\n";
				new_nfs[j].push_back(new_nfs[i][k]);
			}
			new_nfs[i].erase(new_nfs[i].end() - amountToMove, new_nfs[i].end());
		}
	}

	modified << modifiedCount << "\n" << pairs;

	modified << "\nRemove\n";

	for (int i = 0; i < numOfNfs; ++i) {
		modified << t_nfs[i].size();
		for (int j = 0; j < t_nfs[i].size(); ++j) {
			modified << " " << t_nfs[i][j];
		}
		modified << "\n";
	}

	modified << "\nAdd\n";

	for (int i = 0; i < numOfNfs; ++i) {
		int amount = sizes[i] - new_nfs[i].size();
		if (amount > 0) {
			modified << amount;
			for (int j = 0; j < amount; ++j) {
				modified << " " << t_users[j];
				new_nfs[i].push_back(t_users[j]);
			}
			t_users.erase(t_users.begin(), t_users.begin() + amount);
			modified << "\n";
		} else if (amount == 0) {
			modified << "0\n";
		} else {
			printf("Error. i: %i, new_nfs[i].size(): %u, sizes[i]: %i\n", i, new_nfs[i].size(), sizes[i]);
		}
	}
	
	dist << numOfNfs << "\n";
	for (int i = 0; i < numOfNfs; ++i) {
		dist << new_nfs[i].size();
		for (int j = 0; j < new_nfs[i].size(); ++j) {
			dist << " " << new_nfs[i][j];
		}
		dist << "\n";
	}

	user_list.close();
	prev_dist.close();
	dist.close();
	modified.close();
	delete[] sizes;

	return 0;
}

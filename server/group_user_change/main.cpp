#include <iostream>
#include <string>
#include <vector>
#include <fstream>

using namespace std;

void removeOverlap(vector<string>& t_users, vector<string>& group) {
	for (unsigned i = 0; i < group.size(); ++i) {
		for (unsigned j = 0; j < t_users.size(); ++j) {
			if (group[i] == t_users[j]) {
				group.erase(group.begin() + i);
				t_users.erase(t_users.begin() + j);
				--i;
				break;
			}
		}
	}
}

int main(int argc, char** argv) {

	if (argc != 3) {
		cout << "Two input filenames: prev_user_list, user_list\n";
		return 0;
	}

	fstream prev_user_list (argv[1], fstream::in);
	fstream user_list (argv[2], fstream::in);

	int size;
	string redundant;
	prev_user_list >> size;
	for (int i = 0; i < size; ++i)
		prev_user_list >> redundant;
	
	user_list >> size;
	for (int i = 0; i < size; ++i)
		user_list >> redundant;

	int num_prevGroup, num_group;
	vector<vector<string> > prevGroups, groups;

	int modifiedCount = 0;
	string modified;

	prev_user_list >> num_prevGroup;
	for (int i = 0; i < num_prevGroup; ++i) {
		int groupSize;
		prev_user_list >> groupSize;
		++groupSize;

		vector<string> group;
		for (int j = 0; j < groupSize; ++j) {
			string id;
			prev_user_list >> id;
			group.push_back(id);
		}
		prevGroups.push_back(group);
	}

	user_list >> num_group;
	for (int i = 0; i < num_group; ++i) {
		int groupSize;
		user_list >> groupSize;
		++groupSize;

		vector<string> group;
		for (int j = 0; j < groupSize; ++j) {
			string id;
			user_list >> id;
			group.push_back(id);
		}
		groups.push_back(group);
	}

	for (int i = 0; i < prevGroups.size(); ++i) {
		for (int j = 0; j < groups.size(); ++j) {
			if (prevGroups[i][0] == groups[j][0]) {
				string groupName = prevGroups[i][0];

				removeOverlap(prevGroups[i], groups[j]);
				if (prevGroups[i].empty() && groups[j].empty()) {
					prevGroups.erase(prevGroups.begin() + i);
					--i;
					groups.erase(groups.begin() + j);
					j = groups.size();
					continue;
				}

				++modifiedCount;
				modified += groupName + "\n";
				modified += to_string(prevGroups[i].size());
				for (int k = 0; k < prevGroups[i].size(); ++k)
					modified += " " + prevGroups[i][k];
				
				modified += "\n";

				modified += to_string(groups[j].size());
				for (int k = 0; k < groups[j].size(); ++k)
					modified += " " + groups[j][k];
				
				modified += "\n\n";
				prevGroups.erase(prevGroups.begin() + i);
				--i;
				groups.erase(groups.begin() + j);
				j = groups.size();
			}
		}
	}

	cout << "Modified\n" << modifiedCount << "\n" << modified;

	cout << "Remove\n" << prevGroups.size() << "\n";
	for (int i = 0; i < prevGroups.size(); ++i) {
		cout << prevGroups[i].size() - 1;
		for (int j = 0; j < prevGroups[i].size(); ++j)
			cout << " " << prevGroups[i][j];
		cout << "\n";
	}
	
	cout << "\nAdd\n" << groups.size() << "\n";
	for (int i = 0; i < groups.size(); ++i) {
		cout << groups[i].size() - 1;
		for (int j = 0; j < groups[i].size(); ++j)
			cout << " " << groups[i][j];
		cout << "\n";
	}

	user_list.close();
	prev_user_list.close();

	return 0;
}

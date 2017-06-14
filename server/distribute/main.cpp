#include <iostream>
#include <string>
#include <vector>
#include <fstream>

using namespace std;

int main(int argc, char** argv) {

	if (argc != 4) {
		cout << "Four input filenames: user_list, prev_dist, dist, modified\n";
	}

	fstream user_list (argv[0], fstream::in);
	fstream prev_dist (argv[1], fstream::in);
	fstream dist (argv[2], fstream::out);
	fstream modified (argv[3], fstream::out);

	vector<string> users;
	int sizeOfUsers;
	user_list >> sizeOfUsers;
	for (int i = 0; i < sizeOfUsers; ++i) {
		string user;
		user_list >> user;
		users.push_back(user);
	}

	vector<vector<string> > nfs;
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
	}
	
	

	user_list.close();
	prev_dist.close();
	dist.close();
	modified.close();
}

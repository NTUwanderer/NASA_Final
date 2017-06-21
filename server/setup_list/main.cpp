#include <iostream>
#include <string>

using namespace std;

int main() {
	int groups, inds, count = 0;
	string output("");
	string group_list("");
	cin >> groups >> inds;

	count += inds;

	for (int i = 0; i < groups; ++i) {
		string prefix;
		int start, end;
		cin >> prefix >> start >> end;
		count += end - start + 1;
		group_list += to_string(end - start + 1) + " " + prefix;
		for (int j = start; j <= end; ++j) {
			string number = to_string(j);
			while (number.size() < 3)
				number = '0' + number;

			output += prefix + "/" + prefix + number + " ";
			group_list += " " + prefix + number;
		}
		group_list += "\n";
	}

	if (inds != 0) {
		++groups;
		group_list += to_string(inds) + " others";
		for (int i = 0; i < inds; ++i) {
			string individual;
			cin >> individual;
			output += "others/" + individual + " ";
			group_list += " " + individual;
		}
	}

	cout << count << "\n" << output << "\n\n" << groups << "\n" << group_list;
	
}

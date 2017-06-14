#include <iostream>
#include <string>

using namespace std;

int main() {
	int groups, inds, count = 0;
	string output("");
	cin >> groups >> inds;

	count += inds;

	for (int i = 0; i < groups; ++i) {
		string prefix;
		int start, end;
		cin >> prefix >> start >> end;
		count += end - start + 1;
		for (int j = start; j <= end; ++j) {
			string number = to_string(j);
			while (number.size() < 3)
				number = '0' + number;

			output += prefix + number + " ";
		}
	}

	for (int i = 0; i < inds; ++i) {
		string individual;
		cin >> individual;
		output += individual + " ";
	}

	cout << count << "\n" << output;
	
}

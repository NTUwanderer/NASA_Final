#include <iostream>
#include <cstdio>
#include <random>
#include <chrono>
#include <vector>
using namespace std;
int main(int argc, char** argv)
{
   if (argc < 5) {
      fprintf(stderr, "Usage: %s <prefix> <start_num> <last_num> <num_of_NFS>\n", argv[0]);
      exit(1);
   }
   int i=0,j=0,k=0;
   int numNFS = stoi(argv[4]);
   unsigned seed = chrono::system_clock::now().time_since_epoch().count();
   int start_num = stoi(argv[2]);
   int last_num = stoi(argv[3]);
   int* usernum = new int [numNFS];
   vector<int> userlist; 
   for (i=start_num;i<=last_num;++i)
      userlist.push_back(i);
   shuffle(userlist.begin(), userlist.end(), default_random_engine(seed));
   for (i=1;i<=numNFS;++i) {
      sort(userlist.begin()+j, userlist.begin()+i*userlist.size()/numNFS+1);      
      for (;j<=i*userlist.size()/numNFS;++j)
         printf("%s%03d\tnfs%d\n",argv[1],userlist[j],i);
   }
}

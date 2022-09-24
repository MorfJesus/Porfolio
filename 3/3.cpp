#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

int level(int val)
{
    int lev = 1;
    while(val > 1)
    {
        val = val/2;
        lev++;
    }
    return(lev);
}

int main()
{
	int Q, N, i = 0;
    string str;
	cin>>N>>Q;

    vector<char> tree;

    cout<<N<<' ';
	return(0);
}
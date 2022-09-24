#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

string FirstThree(string str)
{
    string out;
    if (str.length() >= 3)
    {
        out = string(str.begin(), str.begin()+3);
        out = string(out.rbegin(), out.rend());
    }
    else
    {
        for(int i = 0; i < 3 - str.length(); i++)
        {
            out += '0';
        }
        out += string(str.rbegin(), str.rend());
    }
    return out;
}

string DecToHexRev(int val)
{
    string str;
    char temp;
    while (val > 0)
    {
        temp = val % 16;
        if (temp > 9)
            temp = temp - 10 + 'A';
        else
            temp = temp + '0';
        str.push_back(temp);
        val /= 16;
    }
    
    return str;
}

short alphNum(char c)
{
    if (c > 'Z')
        return(c - 'a' + 1);
    return(c - 'A' + 1);
}

short sum(string s1)
{
    short val = stoi(s1);
    return(val / 10 + val % 10);
} 

int charCount(string s1, string s2, string s3)
{
    unordered_map<char, int> m; 
    string s = s1 + s2 + s3;

    for (int i = 0; i < s.length(); i++)
    { 
        m[s[i]]++; 
    }
    return(m.size());
}

vector<string> tokenize(string s, string del = ",")
{
    vector<string> info;
    int start, end = -1*del.size();
    do {
        start = end + del.size();
        end = s.find(del, start);
        info.push_back(s.substr(start, end - start));
    } while (end != -1);
    return(info);
}

string cypher(string str)
{
    string cyp;
    int temp;
    vector<string> info;
    info = tokenize(str, ",");
    temp = charCount(info[0], info[1], info[2]) + (sum(info[3])+sum(info[4]))*64 + alphNum(info[0][0]) * 256;
    cyp = FirstThree(DecToHexRev(temp));
    return(cyp);
}

int main()
{
	int N, i = 0;
    string str;
	cin>>N;
	while (i < N)
    {
        cin>>str;
        cout<<cypher(str)<<' ';
        i++;
    }
	return(0);
}
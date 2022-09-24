#include <iostream>
#include <vector>
#include <bits/stdc++.h>
#include <fstream>

using namespace std;

class log_elem
{
    public:
        int start;
        int end;
        int cost;
    log_elem(int x, int y, int z)
    {
        start = x;
        end = y;
        cost = z;
    }
    log_elem()
    {
        
    }
};

bool by_start(log_elem a, log_elem b)
{
    return a.start < b.start;
}

bool by_end(log_elem a, log_elem b)
{
    return a.end < b.end;
}

void query(int start, int end, char type, vector<log_elem> &log, int N)
{
    int sum = 0;
    if (type == '1')
    {
        sort(log.begin(), log.end(), by_start);
        for(int i = 0; i < N; i++)
        {
            if (log[i].start < start)
            {
                continue;
            }
            if (log[i].start >= start && log[i].start <= end)
            {
                sum+=log[i].cost;
            }
            else
            {
                break;
            }
        }
        cout<<sum<<'\n';
        return;
    }
    else
    {
        sort(log.begin(), log.end(), by_end);
        for(int i = 0; i < N; i++)
        {
            if (log[i].end < start)
                continue;
            if (log[i].end >= start && log[i].end <= end)
            {
                sum+=log[i].end-log[i].start;
            }
            else
            {
                break;
            }
        }
        cout<<sum<<' ';
        return;
    }
}

//#include <chrono>
//using namespace std::chrono;

int main()
{
    //auto start1 = high_resolution_clock::now();
    ios::sync_with_stdio(false);
	cin.tie(nullptr);
    //ifstream cin("input.txt");
    //ofstream cout("output.txt");
	int N, Q, i = 0;
    int start, end, cost;
    char type;
	cin>>N;
    vector<log_elem> log;
    while (i < N)
    {
        cin>>start>>end>>cost;
        log.push_back(log_elem(start, end, cost));
        i++;
    }
    cin>>Q;
    i = 0;
    while (i < Q)
    {
        cin>>start>>end>>type;
        query(start, end, type, log, N);
        i++;
    }
    //auto stop = high_resolution_clock::now();
    //auto duration = duration_cast<milliseconds>(stop - start1);
    //cout << '\n'<< duration.count() << '\n';
	return(0);
}
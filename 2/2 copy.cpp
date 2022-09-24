#include <iostream>
#include <vector>
#include <bits/stdc++.h>

using namespace std;

class log_elem
{
    public:
        int day;
        int hour;
        int minute;
        int id;
        char status;
    log_elem(int x, int y, int z, int xx, char yy)
    {
        day = x;
        hour = y;
        minute = z;
        id = xx;
        status = yy;
    }
    log_elem()
    {
        
    }
};

bool log_comp(log_elem a, log_elem b)
{
    if (a.id != b.id)
        return a.id < b.id;
    
    if (a.day != b.day)
        return a.day < b.day;

    if (a.hour != b.hour)
        return a.hour < b.hour;
    
    return a.minute < b.minute;
}

int calc_time(log_elem l1, log_elem l2)
{
    return((l2.day*24*60+l2.hour*60+l2.minute)-(l1.day*24*60+l1.hour*60+l1.minute));
}

/*
void disp_log(log_elem l, string mess)
{
    cout<<mess+": "<<l.day<<' '<<l.hour<<' '<<l.minute<<' '<<l.id<<' '<<l.status<<'\n';
}
*/
int main()
{
	int N, i = 0;
    int day, hour, minute, id;
    char status;
    string str;
    vector<log_elem> log;
	cin>>N;
	while (i < N)
    {
        cin>>day>>hour>>minute>>id>>status;
        log.push_back(log_elem(day, hour, minute, id, status));
        //cout<<log[i].id<<'\n';
        i++;
    }
    sort(log.begin(), log.end(), log_comp);
    i = 0;
    cout<<"___LOG___\n";
    while (i < N)
    {
        cout<<log[i].day<<' '<<log[i].hour<<' '<<log[i].minute<<' '<<log[i].id<<' '<<log[i].status<<'\n';
        i++;
    }
    i = 0;
    log_elem f_log;
    log_elem l_log;
    while (i < N - 1)
    {
        int sum = 0;
        f_log = log[i];
        //disp_log(f_log, "FIRST");
        while (i < N - 1 && log[i].id == log[i+1].id)
        {
            if (log[i+1].status == 'A')
            {
                f_log = log[i+1];
                //disp_log(f_log, "FIRST");
            }
            else if (log[i+1].status == 'S' || log[i+1].status == 'C')
            {
                l_log = log[i+1];
                //disp_log(l_log, "LAST");
                //cout<<"TIME CALCULATED: "<<calc_time(f_log, l_log)<<'\n';
                sum+=calc_time(f_log, l_log);
            }
            i++;
        }
        cout<<sum<<' ';
        i++;
    }
    //vector<vector<string>> logs = structurise(log);
	return(0);
}
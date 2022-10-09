#include <iostream>

using namespace std;

int main()
{
    int a, b, c, d;
    int ans;

    cin>>a>>b>>c>>d;
    if (a == 0 && b == 0)
    {
        cout<<"INF";
        return 0;
    }
    if ((b != 0 && max(abs(a), abs(b)) % min(abs(a),abs(b)) != 0) || (a == 0 && b != 0) || (c >= a && d >= b && c / a == d / b && c % a == 0 && d % b == 0))
    {
        cout<<"NO";
        return 0;
    }
    ans = -b/a;
    if (c*ans+d != 0)
        cout<<ans;
    else
        cout<<"NO";
    return 0;
}
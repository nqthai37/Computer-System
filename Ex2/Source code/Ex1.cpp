#include <iostream>
#include <cmath>
#include <vector>
using namespace std;

void dumpFloat(float* p)
{
    unsigned int* p1 = (unsigned int*)p;
    vector<int> a(32);
    for (int i = 31; i >= 0; i--)
    {
        a[i] = *p1 & 1;
        *p1 = *p1 >> 1;
    }
    for (int i = 0; i < 32; i++)
    {
        cout << a[i];
        if(i == 0 || i == 8)
            cout << " ";
    }
}

int main()
{
    float f = 6.0;
    cout<< "Enter a float number: ";
    cin >> f;
    dumpFloat(&f);
    return 0;
}   
#include <iostream>
#include <cmath>
#include <limits.h>
#include<vector>
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
        if (i == 0 || i == 8)
            cout << " ";
    }
}
void forceFloat(float* p, const char* s)
{

    *p = 0;
    unsigned int* p1 = (unsigned int*)p;
    int i = 0;
    while (s[i])
    {
        *p1 = *p1 << 1;
        if (s[i] == '1')
            *p1 = *p1 | 1;
        i++;
    }
    *p = *(float*)p1;
}

int main()
{

    float f;
    cout << "Float: ";
    forceFloat(&f, "1");
    cout << f << endl;
    cout << "Binary: ";
    dumpFloat(&f);

    return 0;
}


#include <iostream>
#include <vector>

using namespace std;


float forceFloat(float* p, const char* s)
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
    p = (float*)p1;
    return *p;

}

int main()
{
    float x;
    cout << "Binary: 01000100001101100001000000000000:" << endl;
    cout << "Float:" << forceFloat(&x, "01000100001101100001000000000000") << endl;
    cout << "Binary: 10100011001101011000000000000000:" << endl;
    cout << "Float:" << forceFloat(&x, "10100011001101011000000000000000") << endl;
    cout << "Binary: 00111101110011001100110011001101:" << endl;
    cout << "Float:" << forceFloat(&x, "00111101110011001100110011001101") << endl;
    cout << "Binary: 01111111100000000000000000000000:" << endl;
    cout << "Float:" << forceFloat(&x, "01111111100000000000000000000000") << endl;
    cout << "Binary: 01111111110000000000000000000000:" << endl;
    cout << "Float:" << forceFloat(&x, "01111111110000000000000000000000") << endl;
    return 0;
}
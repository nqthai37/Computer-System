#include <iostream>

using namespace std;

void ques1()
{
    float a = 3.7;
    int b = int(a);
    float c = float(b);
    cout << "float = " << a << endl;
    cout << "float -> int = " << b << endl;
    cout << "floar -> int -> float = " << c << endl;
}

void ques2()
{
    int a = 5;
    float b = float(a);
    int c = int(b);
    cout << "int = " << a << endl;
    cout << "int -> float = " << b << endl;
    cout << "int -> float -> int = " << c << endl;
}

void ques3()
{
    float a = 3.7, b = 5.2, c = 2.3;
    if ((a + b) + c == a + (b + c))
        cout << "(x+y)+z == x+(y+z) \nCo tinh ket hop" << endl;
    else
        cout << "(x+y)+z != x+(y+z) \nKhong co tinh ket hop" << endl;
}
void ques4()
{
    int i = 1;
    float f = 2.5;
    i = (int)(3.14159 * f);
    cout << "i = " << i << endl;
}
void ques5()
{
    int i = 1;
    float f = 2.5;
    f = f + (float)i;
    cout << "f = " << f << endl;
}

void ques6()
{
    int i = 1;
    if (i == (int)(float)i)
        cout << "true" << endl;
    else
        cout << "false" << endl;
}

void ques7()
{
    int i = 1;
    if (i == (int)(double)i)
        cout << "true" << endl;
    else
        cout << "false" << endl;
}

void ques8()
{
    float i = 1.5;
    if (i == (float)(int)i)
        cout << "true" << endl;
    else
        cout << "false" << endl;
}

void ques9()
{
    float i = 1.5;
    if (i == (double)(int)i)
        cout << "true" << endl;
    else
        cout << "false" << endl;
}

int main()
{
    cout << "1: " << endl;
    ques1();
    cout << "2: " << endl;
    ques2();
    cout << "3: " << endl;
    ques3();
    cout << "4: " << endl;
    ques4();
    cout << "5: " << endl;
    ques5();
    cout << "6: " << endl;
    ques6();
    cout << "7: " << endl;
    ques7();
    cout << "8: " << endl;
    ques8();
    cout << "9: " << endl;
    ques9();

    return 0;
}
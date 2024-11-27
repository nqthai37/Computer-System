#include <iostream>
#include <cmath>
#include <vector>   
using namespace std;

vector<int> decToBinary(int n, int length);
// int BinaryToDec(vector<int> a, int n);
vector<int> Sum(vector<int> a, vector<int> b);
vector<int> Minus(vector<int> a, vector<int> b);
vector<int> Multiply(vector<int> a, vector<int> b);
void Devide(vector<int> a, vector<int> b);


vector<int> decToBinary(int n, int length)
{
    vector <int > a(length);
    for (int i = length - 1; i >= 0; i--)
    {
        //bitwise AND operation
        a[i] = n & 1;
        n = n >> 1;

    }
    return a;
}


// int BinaryToDec(vector<int> a, int n)
// {
//     int dec = 0, carry = 1;
//     vector<int> tmp(n);
//     for (int i = 0; i < n; i++)
//     {
//         tmp[i] = a[i];
//     }
//     if (tmp[0] == 1)
//     {
//         carry = -1;
//         for (int i = 0; i < n; i++)
//         {
//             tmp[i] = tmp[i] == 1 ? 0 : 1;
//         }
//         tmp = Sum(tmp, decToBinary(1, n));
//     }
//     for (int i = n - 1; i >= 0; i--)
//     {
//         // cout << tmp[i];
//         dec += (tmp[i] * pow(2, n - 1 - i));
//     }

//     return dec * carry;
// }


vector<int> Sum(vector<int> a, vector<int> b) {
    vector<int> idx(b.size());

    int carry = 0;
    for (int i = b.size() - 1; i >= 0; i--)
    {
        // cout << i;
        idx[i] = a[i] + b[i] + carry;
        carry = idx[i] / 2;
        idx[i] %= 2;
    }

    return idx;
}
vector<int> Minus(vector<int> a, vector<int> b) {
    vector<int> tmp;
    for (int i = 0; i < b.size(); i++)
    {
        tmp.push_back(b[i] == 1 ? 0 : 1);
    }
    tmp = Sum(tmp, decToBinary(1, 8));

    return Sum(a, tmp);


}

vector<int> Multiply(vector<int> a, vector<int> b) {

    vector<int> right(b.size());
    right = b;
    vector<int> left = decToBinary(0, 8);
    int k = 8, tail = 0;
    while (k > 0)
    {
        if (right[7] == 0 && tail == 1)
        {
            left = Sum(left, a);
        }
        else if (right[7] == 1 && tail == 0)
        {
            left = Minus(left, a);
        }
        tail = right[7];
        for (int i = 7; i > 0; i--)
            right[i] = right[i - 1];
        right[0] = left[7];

        for (int i = 7; i > 0; i--)
            left[i] = left[i - 1];
        left[0] = 1 ? left[0] == 1 : 0;
        k--;
    }
    vector<int> idx;
    for (int i = 0; i < 8; i++)
    {
        idx.push_back(left[i]);
    }
    for (int i = 0; i < 8; i++)
    {
        idx.push_back(right[i]);
    }

    return idx;
}

void Devide(vector<int> a, vector<int> b)
{
    vector<int>subb = b;
    if (b[0] == 1) {
        for (int i = 0; i < b.size(); i++)
        {
            subb[i] = !b[i];
        }
        subb = Sum(subb, decToBinary(1, 8));
    }
    vector <int> tmp = decToBinary(0, 8);
    vector<int> q = a;
    int k = b.size();

    while (k > 0)
    {
        for (int i = 0; i < tmp.size() - 1; i++)
            tmp[i] = tmp[i + 1];
        tmp[7] = q[0];
        for (int i = 0; i < q.size() - 1; i++)
            q[i] = q[i + 1];
        q[7] = 0;
        tmp = Minus(tmp, subb);
        if (tmp[0] == 1) {
            q[7] = 0;
            tmp = Sum(tmp, subb);
        }
        else q[7] = 1;
        k--;
    }
    if (b[0] == 1) {
        for (int i = 0; i < 8; i++)
        {
            q[i] = !q[i];
        }
        q = Sum(q, decToBinary(1, 8));
    }
    cout << "Result: ";
    for (int i = 0; i < 8; i++)
    {
        cout << q[i];
    }
    cout << endl;
    cout << "Remainder: ";
    for (int i = 0; i < 8; i++)
    {
        cout << tmp[i];
    }
    cout << endl;

}

void menu()
{
    int select = 0;
    while (select != 5)
    {
        system("cls");
        cout << "Menu" << endl;
        cout << "1. Sum" << endl;
        cout << "2. Minus" << endl;
        cout << "3. Multiply" << endl;
        cout << "4. Devide" << endl;
        cout << "5. Exit" << endl;
        cout << "Select: ";
        cin >> select;
        if (select == 1)
        {
            string a, b;
            cout << "Enter a: ";
            cin >> a;
            cout << "Enter b: ";
            cin >> b;
            vector<int> suba, subb;
            for (int i = 0; i < 8; i++)
            {
                suba.push_back(a[i] - '0');
                subb.push_back(b[i] - '0');
            }
            vector<int> c = Sum(suba, subb);
            cout << "Result: ";
            for (int i = 0; i < 8; i++)
            {
                cout << c[i];
            }
            cout << endl;
        }
        else if (select == 2)
        {
            string a, b;
            cout << "Enter a: ";
            cin >> a;
            cout << "Enter b: ";
            cin >> b;
            vector<int> suba, subb;
            for (int i = 0; i < 8; i++)
            {
                suba.push_back(a[i] - '0');
                subb.push_back(b[i] - '0');
            }
            vector<int> c = Minus(suba, subb);
            cout << "Result: ";

            for (int i = 0; i < 8; i++)
            {
                cout << c[i];
            }
            cout << endl;
        }
        else if (select == 3)
        {
            string a, b;
            cout << "Enter a: ";
            cin >> a;
            cout << "Enter b: ";
            cin >> b;
            vector<int> suba, subb;
            for (int i = 0; i < 8; i++)
            {
                suba.push_back(a[i] - '0');
                subb.push_back(b[i] - '0');
            }
            vector<int> c = Multiply(suba, subb);
            cout << "Result: ";

            for (int i = 0; i < 16; i++)
            {
                cout << c[i];
            }
            cout << endl;
        }
        else if (select == 4)
        {
            string a, b;
            cout << "Enter a: ";
            cin >> a;
            cout << "Enter b: ";
            cin >> b;
            vector<int> suba, subb;
            for (int i = 0; i < 8; i++)
            {
                suba.push_back(a[i] - '0');
                subb.push_back(b[i] - '0');
            }
            Devide(suba, subb);
        }
        system("pause");
    }
}

int main()

{
    menu();
    return 0;
}

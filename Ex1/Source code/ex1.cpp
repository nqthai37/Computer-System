#include <iostream>
#include <cmath>
#include <vector>
using namespace std;

void decToBinary(int n)
{
    vector <int > a(32);
    for (int i = 32 - 1; i >= 0; i--)
    {
        a[i] = n & 1;
        n = n >> 1;
    }
    for (int i = 0; i < 32; i++)
    {
        cout << a[i];
        if (i % 4 == 3)
            cout << " ";
    }
    cout << endl;
}


void BinaryToDec(string a)
{
    int dec = 0;
    vector<int> tmp(32);
    for (int i = 0; i < 32; i++)
    {
        tmp[i] = a[i] - '0';
    }
    for (int i = 0; i < 32; i++)
    {
        if (tmp[i] == 1)
            dec = dec | (1 << (31 - i));

    }
    cout << dec << endl;
}



void menu()
{
    string arr;
    int sel = 0;
    while (sel != 3)
    {
        system("cls");
        cout << "Select an option: " << endl;
        cout << "1. Show binary with bit" << endl;
        cout << "2. Binary to Dec" << endl;
        cout << "3. Exit" << endl;
        cout << "Select: ";
        cin >> sel;
        switch (sel)
        {
        case 1:
            cout << "Enter a number: ";
            int n; cin >> n;
            decToBinary(n);
            break;
        case 2:
            cin.ignore();
            cout << "Enter a binary number: ";
            getline(cin, arr);
            BinaryToDec(arr);
            break;
        case 3:
            break;
        default:
            cout << "Invalid option" << endl;
            break;
        }
        system("pause");
    }

}
int main()
{
    menu();
    return 0;
}
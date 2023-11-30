// c++ program
#include <bits/stdc++.h>
using namespace std;
vector<int> int_to_bin(int n)
{
    vector<int> V(4, 0);
    int i = 3;
    while (n != 0)
    {
        V[i] = n % 2;
        n /= 2;
        i--;
    }
    return V;
}
void print_unique(vector<string> V)
{
    set<string> S;
    for (auto i : V)
        S.insert(i);
    for (auto i : S)

        cout << i << " " << endl;
}

int main() {
    map<int, string> hash1;
    hash1[0] = "W";
    hash1[1] = "X";
    hash1[2] = "Y";
    hash1[3] = "Z";
    map<string, int> hash2;
    hash2["W"] = 0;
    hash2["X"] = 1;
    hash2["Y"] = 2;
    hash2["Z"] = 3;
    map<string, string> M;
    M["XYZ"] = "W";
    M["XY"] = "WZ";
    M["X"] = "WYZ";
    /*
    M["W"]= "";
    M["X"]= "Y";
    M["Y"]= "Z";
    M["Z"]= "X";
    */
    string closure[4] = {"W", "X", "Y", "Z"};
    for (int i = 0; i <= 3; i++)
    {
        string temp = closure[i];
        while (M[temp] != "" && closure[i].length() <= 4)
        {
            closure[i] += M[temp];
            temp = M[temp];
        }
        string temp2 = closure[i];
        set<char> S;
        for (auto j : temp2)
            S.insert(j);
        string temp3;
        for (auto j : S)
            temp3 += j;
        closure[i] = temp3;
    }

    vector<string> cand, super;
    for (int ij = 1; ij <= 15; ij++)
    {
        vector<int> V = int_to_bin(ij);
        string str;
        for (int j = 0; j <= 3; j++)
        {
            if (V[j] == 1)
            {
                str += hash1[j];
            }
        }
        sort(str.begin(), str.end());
        string temp;
        for (int i = 0; i < str.length(); i++)
            temp += closure[hash2[str.substr(i, 1)]];
        set<char> S;
        for (auto j : temp)
            S.insert(j);
        string temp2;
        for (auto j : S)
            temp2 += j;
        sort(temp2.begin(), temp2.end());
        if (temp2 == "WXYZ")
            super.push_back(str);
    }
    int min_length = INT_MAX;
    for (auto i : super)
    {
        if (i.length() < min_length)
        {
            min_length = i.length();
        }
    }
    for (auto i : super)
    {
        if (i.length() == min_length)
        {
            cand.push_back(i);
        }
    }
    cout << "The candidate keys are-" << endl;
    print_unique(cand);
    cout << "The super keys are-" << endl;
    print_unique(super);
    return 0;
}

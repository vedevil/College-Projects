#include <fstream>
#include <iostream>
#include <bits/stdc++.h>

using namespace::std;

void splitString(string s, vector<string> &v){
	
	string temp = "";
	for(int i=0;i<s.length();++i){
		
		if(s[i]=='\t'){
			v.push_back(temp);
			temp = "";
		}
		else{
			temp.push_back(s[i]);
		}
		
	}
	v.push_back(temp);
	
}

int main(){
	std::ifstream file("DlRlcStats.txt");
	int sum =0;
	if (file.is_open()) {
	    std::string line;
	    while (std::getline(file, line)) {
	        // using printf() in all tests for consistency
	        vector<string> v;
	        splitString(line,v);	        
	        //cout<<v[9]<<"\n";
	        sum = sum + stoi(v[9]);
	    }
	    cout<<"SUM IS: "<<sum<<"\n\n";
	    file.close();
	}
}

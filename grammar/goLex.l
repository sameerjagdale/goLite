%{
#include<iostream>
extern "C" int yywrap(){}
%}

%%
[ \t\n] std::cout<<"WHITESPACE"<<std::endl; 


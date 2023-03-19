clear all
syms D3;
%Flow rate
Q1= 9; Q2= 3; Q3 =2;
%Length of pipe
L1=300 ; L2=500 ; L3= 400;
%Head node of pipe
HA=100; HC= 85.5; HD= 81;
%Equations for diameters of pipe
K1= 4.457*10^8* L1*Q1^1.85;  K2= 4.457*10^8* L2*Q2^1.85; K3= 4.457*10^8* L3*Q3^1.85;
D1= (K1/(HA-HD- K3/D3^4.87))^(1/4.87);    D2=(K2/(HD-HC +K3/D3^4.87))^(1/4.87);
%Cost function
cost= 1.265* (L1*D1^(1.327)+ L2*D2^(1.327)+ L3*D3^(1.327));



%Defining extreme points
a=150; b=190;
lo= b-a;
gamma= 1.618;

key=0;
%Defining random fx values
fx1=0; fx2=100;
i=0;
%defining array for storage
x1_store=[];
x2_store=[];
fx1_store=[];
fx2_store=[];

while abs(a-b)>0.05
    
    l_star= lo/gamma^(2+i);
    if key==1
        x1= a+l_star;
    elseif key==2
        x2= b-l_star;
    else
        x1= a+l_star; x2= b-l_star;
    end    
    
    fx1= subs(cost, D3, x1);
    fx2= subs(cost, D3, x2);

    disp("Step:"+(i+1));
    disp("a: "+a);
    disp("b: "+b);
    disp("X1: "+x1);
    disp("X2: "+x2);
    disp("f(x1): "+double(fx1));
    disp("f(x2): "+double(fx2));
    
    x1_store=[x1_store,x1];
    x2_store=[x2_store,x2];
    fx1_store=[fx1_store,double(fx1)];
    fx2_store=[fx2_store,double(fx2)];


    if fx1<fx2
        key=2;
        if x1<x2
            b=x2;
        elseif x1>x2
            a=x2; 
        end
    elseif fx1> fx2
        key=1;
        if x1<x2
            a=x1;
        elseif x1>x2
            b=x1;
        end
    end
    i=i+1;
end



plot(x1_store(:),fx1_store(:),'.', 'LineWidth', 2);
hold on; 
plot(x2_store(:),fx1_store(:),'.', 'LineWidth', 2);
legend("X1 Vs Fx1", "X2 Vs Fx2")
xlabel("Distance");
ylabel("Cost");


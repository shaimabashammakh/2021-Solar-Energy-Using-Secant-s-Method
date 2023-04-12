function  rimAngle = rimAngleWithSecant()

%This program is designed and used to find the Rim Angle(A) of a Solar-Energy collector with some prespecified parameters.
% Using Secant Method
% Concerntration factor (C)= 1200
% Fractional Coverage (F)=0.8
% Diameter of the collector's field (D)= 14
% Height of the collector(H)= 300

fprintf('----------welcome to rim angle calculator using secant method------------------ \n\n');

% We decided to make our program user-friendly + interactive 
%let the user enter the required arguments to calculate the Rim Angle(A)

fprintf(' ------------------- Entering required input ------------------ \n');
concentration_factor = input('Please enter the geometrical concentration factor (C): '); %the needed concentration_factor 
fractional_converage = input('Please enter the fractional converge (F): '); 
diameter = input('Please enter the diameter of collector (D): ');
height = input('Please enter the height of collector (H): ');
%let the user choose the two guesses
fprintf('the two guesses prefer to be in the range [0, pi/2]\n');
x1 = input('Please enter the first guess x0: ');
x2 = input('Please enter the second guess x1: ');
%let the user enter the accuracy
e= input("Enter the accuracy: ");

% calculate the equation at x0, x1
fx1=((0.5*diameter^2*concentration_factor)/(height^2*fractional_converage))*(1+sin(x1)-0.5*cos(x1))*(cos(x1))^2-1;
fx2=((0.5*diameter^2*concentration_factor)/(height^2*fractional_converage))*(1+sin(x2)-0.5*cos(x2))*(cos(x2))^2-1;
% if fx1< fx2 swap the values , to avoid negative number
if abs(fx1) < abs (fx2)
    temp = x1; x1 = x2; x2 = temp;
    temp = fx1; fx1 = fx2; fx2 = temp;
end

%check if solution found by error tolerance 
%check if one of the guesses is the root
if abs(fx1)<e
    rimAngle=x1;
    fprintf('\n\n------------------The root is: %f----------------------\n',x1);
    return;%solution is found 
elseif abs(fx2)<e
    rimAngle=x2;
    fprintf('\n\n------------------The root is: %f----------------------\n',x2);
    return;%solution is found 
end


%start calculation the root
fprintf('----------------------------------------------------------------------------\n');
fprintf('                     START FINDING THE ROOT\n');
fprintf('----------------------------------------------------------------------------\n');
fprintf('%-21s%-20s%-15s%-15s\n','iteration :','A','f(A)','relative error |∈a|% ');
% variable to count the iteration
iteration_number=0;
%put the max iteration as 20
MAX_iteration =20;

while iteration_number<MAX_iteration
    iteration_number=iteration_number+1;
    %calculate new x
    x=x2-fx2*(x2-x1)/(fx2-fx1);
    % find f(x)
    fx=((0.5*diameter^2*concentration_factor)/(height^2*fractional_converage))*(1+sin(x)-0.5*cos(x))*(cos(x))^2-1;
    fprintf('\t%2d%18.5f\t\t%8.5f\t\t%8.2f %%\n',iteration_number,x,fx, abs((x-x2)/x)*100);
    % check if its less than error tolerance 
    if (abs(fx)<e) || abs((x-x2)/x)< e
         %if yes , print it's found and return
         fprintf('\n--------------------------------------------------------\n');
         fprintf('\t\tthe root is: %.5f\n',x);
         fprintf('--------------------------------------------------------\n');
         fprintf('A graph will appear to illustrate C(A) ,thank you for using the program.');
         % plot functio by given inputs in the range [0 pi/2]
         t =[0 : .00001 :pi/2];
         f =(49/30).*(1+sin(t)-0.5*cos(t)).*(cos(t)).^2-1;
         plot(t,f,'-k','LineWidth',2);
         hold on 
         %plot a point to indicate the root 
         plot(x,fx,'ro','LineWidth',4)
         hold off
         grid 
         title('the Zero of the given function');
         xlabel('Rim Angle');
         ylabel ('f(A)');
         rimAngle=x;
         return; %the solution is founded
    else %otherwies,update the values of x1,x2
        x1 = x2;
        x2 = x; 
        fx1=((0.5*diameter^2*concentration_factor)/(height^2*fractional_converage))*(1+sin(x1)-0.5*cos(x1))*(cos(x1))^2-1;
        fx2=((0.5*diameter^2*concentration_factor)/(height^2*fractional_converage))*(1+sin(x2)-0.5*cos(x2))*(cos(x2))^2-1;
    end
    
end
% if the root does not found after 20 iteration an error message appear
warning('secant: maximum number of iterations exceeded.');
x= []; MAX_iteration = 'No zeros in given interval';
rimAngle =x;
end

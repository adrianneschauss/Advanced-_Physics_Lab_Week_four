B= []
A= []
%empty vectors that accept arrays in the for loop for 10 trials 

for ii= 1:10
    B=[B;sumx]
    A= [A;sumy]
    

 number_screens= 8 
%the number of screens arranged in the positive z-direction, through which
%the particle flies

screen_distances= linspace(200, 900, number_screens)
%there are 8 screens each of them is 100 units apart

maxangle= 45/2
%to make sure the particle hits all the screens we have an maximum angle at which the
%particle is able to depart


a= 0; 
b= 1; 
r1= (b-a).*rand(1,1)+a 
              
c= 0;
d= 1; 
r2= (d-c).*rand(1,1)+c 
%value r1 and r2 are used to randomise the angle at which the particle
%departs in the next part 

xangle= ((r1*maxangle*2-maxangle)*(pi/180))
yangle= ((r2*maxangle*2-maxangle)*(pi/180))
%random angle in radians for x and y in relation to the z axis 

x_hit= tan(xangle)*screen_distances
y_hit = tan(yangle)*screen_distances 
%trigonometry used to find the coordinate of where the particle hit the screens

screen_size= 1000 ;
pixels= 100;
%screen size is 1000*1000 large and has 100*100 pixels 

hit_x_pixel = ceil((x_hit/(screen_size/2)*pixels));
hit_y_pixel= ceil((y_hit/(screen_size/2)*pixels));
%the screen size is divided by two in order to make the coordinate system go from -500
%to 500 
%this determines the pixel that is hit 

e= 0; 
f= 1; 
r3= (f-e).*rand(1,1); 

for ii= 1:length(hit_x_pixel);
    r3(ii)= (f-e).*rand(1,1); 
    if r3(ii) <= 0.1
        hit_x_pixel(ii)= hit_x_pixel(ii)+randi([1 2],1,1) 
        hit_y_pixel(ii)= hit_y_pixel(ii)+randi([1 2],1,1) 
end 
end 
%probability of the particle being in the adjacent pixel is set to 10% and
%when the random value (r3) has a value larger or equal to 0.1 then 1 or 2
%is added to the array to move the detection to the adjacent particle 


x = hit_x_pixel
y = hit_y_pixel


[X,Y] = meshgrid(1:100);
figure;
plot (x,y,'square')
grid on 
title('Trajectory of Particle 10% Variation')
xlabel('X-pixel in which Particle is found')
ylabel('Y-pixel in which Particle is found') 
   
%figure that shows the particles location with x against y (2-D plot
%instead of 3-D here) 


%chi squared test 
z_det = screen_distances
x_det = ceil(hit_x_pixel*screen_size/pixels-screen_size/2)
y_det = ceil(hit_y_pixel*screen_size/pixels-screen_size/2)

%for the chi squared test we go back to a coordinate system rather than
%pixels


figure_1= plot(z_det, y_det, 'red')
hold on 
figure_1= plot(z_det, x_det, 'blue')
%trajectory in terms of the x and y axis in relation to z axis are plotted 

p1 = polyfit(z_det,x_det,1)
p2 = polyfit(z_det,y_det,1)
%the polyfit function is used in order to determine the line of best fit
%with the degree of the polynomial set to 1 

p_1= p1(1)*(z_det)+p1(2)
p_2= p2(1)*(z_det)+p2(2)
%y=ax+b used in order to graph the two lines of best fit with a and b
%obtained from p1 and p2 

plot(z_det, p_1)
plot(z_det, p_2)
title('Trajectory of Particle')
xlabel('Screen distances')
ylabel('x and y coordinate in plane') 
%plots that show the actual trajectory and lines of best fit

sigma_2 = (screen_size/pixels)^2
%variance which is equivalent to pixel dimension 

    sumx = 0
    for i=1:8
        sumx=((x_det(i)-p_1(i)))^2/sigma_2
    end 

     sumy = 0
    for i=1:8
        sumy=((y_det(i)-p_2(i))^2)/sigma_2
    end 
 
%chi-squared test using equation for straight line, iterate for all screens


end 
   chi_squared_sum_x= B
   chi_squared_sum_y= A
   
   histogram(chi_squared_sum_x); hold on;
   histogram(chi_squared_sum_y);
   h = findobj('-property','FaceColor');
   set(h(1),'FaceColor',[1 0 0],'EdgeColor',[1 0 0],'facealpha',0.5);
   title('Frequency of Chi-squared Values for several Trials')
   xlabel('Value of Chi-Squared')
   ylabel('Frequency of Chi-squared') 
   

%degrees of freedom are 8-3 since we have 8 measurements and 3 degrees of
%spatial movement 
dof=5
Chi_squared_dof_x= A/dof 
Chi_squared_dof_y= B/dof
%histograms are again produced 
   
   histogram(Chi_squared_dof_x); hold on;
   histogram(Chi_squared_dof_y);
   h = findobj('-property','FaceColor');
   set(h(1),'FaceColor',[1 0 0],'EdgeColor',[1 0 0],'facealpha',0.5);
   title('Frequency of Chi-squared Values for several Trials')
   xlabel('Value of Chi-Squared')
   ylabel('Frequency of Chi-squared') 


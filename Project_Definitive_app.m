
% Fetching Data from the Excel File
data = xlsread('Data2.xlsx')
% Data Size
len_data=size(data)
%--------------------------------------------------------------------------
% prompt = {'Enter the discount rate:','Enter the number of years:','Enter the growth rate:','Enter the gross rent multiplier for Building A:','Enter the gross rent multiplier for Building B:','Enter the gross rent multiplier for Building C:'};
%         dlgtitle = 'Input';
%         dims = [1 50];
%         definput = {'','','','','',''};
%         answer = inputdlg(prompt,dlgtitle,dims,definput)
%         %------------------------------------------------------------------
%         r=str2double(answer{1})
%         Y=str2double(answer{2});
%         GR=str2double(answer{3});
%         GRA=str2double(answer{4})
%         GRB=str2double(answer{5});
%         GRC=str2double(answer{6});
%--------------------------------------------------------------------------
% Calculating Rental Object Properties for Building A
%--------------------------------------------------------------------------
Number_Of_Rental_Objects_For_Building_A=8
%Calculating Gross Rental Multiplier
GRM_A = GRA + zeros(1, Number_Of_Rental_Objects_For_Building_A);
%Fetching and Building Data for Building A
Code_A=['A1','A2','A3','A4','A5','A6','A7','A8']
Surface_Per_Rental_Object_For_Building_A=data(1:8,3)
Rent_Per_Rental_Object_For_Building_A=data(1:8,4)
Total_Rent_Per_Rental_Object_For_Building_A=Surface_Per_Rental_Object_For_Building_A.*Rent_Per_Rental_Object_For_Building_A
Property_Value_Per_Rental_Object_For_Building_A=GRM_A.*Total_Rent_Per_Rental_Object_For_Building_A'
% Calculating Properties for Building A
Total_Surface_For_Building_A=sum(Surface_Per_Rental_Object_For_Building_A)
Total_Rent_For_Building_A=sum(Total_Rent_Per_Rental_Object_For_Building_A)
Total_Property_Value_For_Building_A=sum(Property_Value_Per_Rental_Object_For_Building_A)
%--------------------------------------------------------------------------
% Calculating Building Properties for Building B
%--------------------------------------------------------------------------
Number_Of_Rental_Objects_For_Building_B=4
%Calculating Gross Rental Multiplier
GRM_B = GRB + zeros(1, Number_Of_Rental_Objects_For_Building_B);
%Fetching and Building Data for Building B
Code_B=['B1','B2','B3','B4']
Surface_Per_Rental_Object_For_Building_B=data(1:Number_Of_Rental_Objects_For_Building_B,10)
Rent_Per_Rental_Object_For_Building_B=data(1:Number_Of_Rental_Objects_For_Building_B,11)
Total_Rent_Per_Rental_Object_For_Building_B=Surface_Per_Rental_Object_For_Building_B.*Rent_Per_Rental_Object_For_Building_B
Property_Value_Per_Rental_Object_For_Building_B=GRM_B.*Total_Rent_Per_Rental_Object_For_Building_B'
% Calculating Properties for Building B
Total_Rent_For_Building_B=sum(Total_Rent_Per_Rental_Object_For_Building_B)
Total_Surface_For_Building_B=sum(Surface_Per_Rental_Object_For_Building_B)
Total_Property_Value_For_Building_B=sum(Property_Value_Per_Rental_Object_For_Building_B)
%--------------------------------------------------------------------------
% Calculating Building Properties for Building C
%--------------------------------------------------------------------------
Number_Of_Rental_Objects_For_Building_C=6
%Calculating Gross Rental Multiplier
GRM_C = GRC + zeros(1, Number_Of_Rental_Objects_For_Building_C);
%Fetching and Building Data for Building C
Code_C=['C1','C2','C3','C4','C5','C6']
Surface_Per_Rental_Object_For_Building_C=data(1:Number_Of_Rental_Objects_For_Building_C,17)
Rent_Per_Rental_Object_For_Building_C=data(1:Number_Of_Rental_Objects_For_Building_C,18)
Total_Rent_Per_Rental_Object_For_Building_C=Surface_Per_Rental_Object_For_Building_C.*Rent_Per_Rental_Object_For_Building_C
Property_Value_Per_Rental_Object_For_Building_C=GRM_C.*Total_Rent_Per_Rental_Object_For_Building_C'
% Calculating Properties for Building C
Total_Rent_For_Building_C=sum(Total_Rent_Per_Rental_Object_For_Building_C)
Total_Surface_For_Building_C=sum(Surface_Per_Rental_Object_For_Building_C)
Total_Property_Value_For_Building_C=sum(Property_Value_Per_Rental_Object_For_Building_C)
%-------------------------------------------------------------------------
%Calculating the total quantities of the project before the devs
%--------------------------------------------------------------------------
GRM=[GRM_A,GRM_B,GRM_C]
Total_Surface_Per_Building=[Total_Surface_For_Building_A,Total_Surface_For_Building_B,Total_Surface_For_Building_C]
Total_Rent_Per_Building=[Total_Rent_For_Building_A,Total_Rent_For_Building_B,Total_Rent_For_Building_C]
Total_Property_Value_Per_Building=[Total_Property_Value_For_Building_A,Total_Property_Value_For_Building_B,Total_Property_Value_For_Building_C]
%Building Matrices
Surface_Array=[Surface_Per_Rental_Object_For_Building_A;Surface_Per_Rental_Object_For_Building_B;Surface_Per_Rental_Object_For_Building_C]
Rent_Array=[Total_Rent_Per_Rental_Object_For_Building_A;Total_Rent_Per_Rental_Object_For_Building_B;Total_Rent_Per_Rental_Object_For_Building_C]
Property_Value_Array=[Property_Value_Per_Rental_Object_For_Building_A';Property_Value_Per_Rental_Object_For_Building_B';Property_Value_Per_Rental_Object_For_Building_C']
New_Rent_Array=Rent_Array
New_Property_Value_Array=Property_Value_Array

%--------------------------------------------------------------------------
UnDiscounted_Cash_Flow_Per_Rental_Object=[Total_Rent_Per_Rental_Object_For_Building_A;Total_Rent_Per_Rental_Object_For_Building_B;Total_Rent_Per_Rental_Object_For_Building_C]
%--------------------------------------------------------------------------
% Discounted Cash Flow Model for Original Assets -- Method 1
%--------------------------------------------------------------------------
% r=5
% Y=30
% GR=2
[Total_Discounted_Cash_Flow_Per_Year,Y_array]=myfunction(r,Y,GR,Total_Rent_Per_Building)
Total_Discounted_Cash_Flow=sum(Total_Discounted_Cash_Flow_Per_Year)
%--------------------------------------------------------------------------
%Plotting the Discounted Cash Flows
figure(1)
plot(Y_array,Total_Discounted_Cash_Flow_Per_Year)
title('Discounted Cash Flow per Year before devs')
xlabel('Time (Years)') 
ylabel('DCF per Year (CHF)') 

%--------------------------------------------------------------------------
% Discounted Cash Flow Model for Original Assets -- Method 2
%--------------------------------------------------------------------------
[Total_Discounted_Cash_Flow_Per_Year_2,Discounted_Cash_Flow_Per_Rental_Object,Y_array]=myfunction2(r,Y,GR,UnDiscounted_Cash_Flow_Per_Rental_Object)
Total_Discounted_Cash_Flow_2=sum(Total_Discounted_Cash_Flow_Per_Year_2)
Internal_Rate_Of_Return=irr(Total_Discounted_Cash_Flow_Per_Year_2)
%--------------------------------------------------------------------------
%Plotting the Discounted Cash Flows
figure(2)
plot(Y_array,Total_Discounted_Cash_Flow_Per_Year_2)
title('Discounted Cash Flow per Year before devs (Check)')
xlabel('Time (Years)') 
ylabel('DCF per Year (CHF)') 
%--------------------------------------------------------------------------
% Discounted Cash Flow Model for Developed Assets -- Method 3
%--------------------------------------------------------------------------
%Options Menu
list = {'Tear Down and Build New','Building a new building in an already free space',...                   
    'Renovation','Adding a new floor on top of an existing building'};
    [indx,tf] = listdlg('PromptString',{'Please, select the type of intervention.',...
    'Only one type of intervention can be selected at a time.',''},...
    'SelectionMode','single','ListString',list);
%--------------------------------------------------------------------------
if indx==1
    prompt = {'enter the number of Rental Objects to destroy and rebuild:'};
    dlgtitle = 'Input';
    dims = [1 50];
    definput = {''};
    nrotd_text = inputdlg(prompt,dlgtitle,dims,definput)
    nrotd=str2double(nrotd_text)
    if nrotd>0    
            [New_Surface_Per_Rental_Object_For_Building_A,New_Surface_Per_Rental_Object_For_Building_B,New_Surface_Per_Rental_Object_For_Building_C,New_Total_Rent_Per_Rental_Object_For_Building_A,New_Total_Rent_Per_Rental_Object_For_Building_B,New_Total_Rent_Per_Rental_Object_For_Building_C,UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New]=myfunction3(UnDiscounted_Cash_Flow_Per_Rental_Object,Y,Code_A,Code_B,Code_C,Surface_Per_Rental_Object_For_Building_A,Surface_Per_Rental_Object_For_Building_B,Surface_Per_Rental_Object_For_Building_C,Total_Rent_Per_Rental_Object_For_Building_A,Total_Rent_Per_Rental_Object_For_Building_B,Total_Rent_Per_Rental_Object_For_Building_C,nrotd)
            [Total_Discounted_Cash_Flow_Per_Year_3,Y_array]=myfunction4(r,Y,GR,UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New)
            Total_Discounted_Cash_Flow_3=sum(Total_Discounted_Cash_Flow_Per_Year_3)
            Internal_Rate_Of_Return_Dev=irr(Total_Discounted_Cash_Flow_Per_Year_3)
            
            %--------------------------------------------------------------------------
            %Plotting the Discounted Cash Flows
            figure(3)
            plot(Y_array,Total_Discounted_Cash_Flow_Per_Year_3)
            title('Discounted Cash Flow per Year after devs')
            xlabel('Time (Years)') 
            ylabel('DCF per Year (CHF)') 
            %--------------------------------------------------------------------------
            Outcomes=[Total_Surface_Per_Building;Total_Rent_Per_Building;Total_Property_Value_Per_Building]
            print(Outcomes,Internal_Rate_Of_Return)
            %--------------------------------------------------------------------------
            New_Total_Surface_For_Building_A=sum(New_Surface_Per_Rental_Object_For_Building_A)
            New_Total_Surface_For_Building_B=sum(New_Surface_Per_Rental_Object_For_Building_B)
            New_Total_Surface_For_Building_C=sum(New_Surface_Per_Rental_Object_For_Building_C)
            New_Total_Rent_For_Building_A=sum(New_Total_Rent_Per_Rental_Object_For_Building_A)
            New_Total_Rent_For_Building_B=sum(New_Total_Rent_Per_Rental_Object_For_Building_B)
            New_Total_Rent_For_Building_C=sum(New_Total_Rent_Per_Rental_Object_For_Building_C)
            New_Property_Value_Per_Rental_Object_For_Building_A=GRM_A.*New_Total_Rent_Per_Rental_Object_For_Building_A'
            New_Property_Value_Per_Rental_Object_For_Building_B=GRM_B.*New_Total_Rent_Per_Rental_Object_For_Building_B'
            New_Property_Value_Per_Rental_Object_For_Building_C=GRM_C.*New_Total_Rent_Per_Rental_Object_For_Building_C'
            New_Property_Value_For_Building_A=sum(New_Property_Value_Per_Rental_Object_For_Building_A)
            New_Property_Value_For_Building_B=sum(New_Property_Value_Per_Rental_Object_For_Building_B)
            New_Property_Value_For_Building_C=sum(New_Property_Value_Per_Rental_Object_For_Building_C)
            New_Total_Surface_Per_Building=[New_Total_Surface_For_Building_A;New_Total_Surface_For_Building_B;New_Total_Surface_For_Building_C]
            New_Total_Rent_Per_Building=[New_Total_Rent_For_Building_A;New_Total_Rent_For_Building_B;New_Total_Rent_For_Building_C]
            New_Property_Value_Per_Building=[New_Property_Value_For_Building_A;New_Property_Value_For_Building_B;New_Property_Value_For_Building_C]
            Outcomes_Dev=[New_Total_Surface_Per_Building';New_Total_Rent_Per_Building';New_Property_Value_Per_Building']
            print_dev(Outcomes_Dev,Internal_Rate_Of_Return_Dev)
            Outcomes_diff=Outcomes_Dev-Outcomes
            Internal_Rate_Of_Return_diff=Internal_Rate_Of_Return_Dev-Internal_Rate_Of_Return
            print_diff(Outcomes_diff,Internal_Rate_Of_Return_diff)
    % elseif nrotd==1
    %     message='Working in Progress'
    %     f = msgbox(message)
    else nrotd==0
        message='You have selected a number of intervantions equal to zero'
        f = msgbox(message)
    end
else indx==2 | indx==3 | indx==4
    message='This option is not available yet'
        f = msgbox(message)
end











%--------------------------------------------------------------------------
function print_diff(Outcomes_diff,Internal_Rate_Of_Return_diff)
    col_header={'Building A','Building B','Building C'}
    row_header={'Surface Per Building Difference (m^2)','Total Rent Per Building Per Year Difference (CHF)','Property Value Per Building Difference (CHF)'}
    xlswrite('Outcomes_Difference.xls',Outcomes_diff,'sheet','B2')
    xlswrite('Outcomes_Difference.xls',col_header,'sheet','B1')
    xlswrite('Outcomes_Difference.xls',row_header','sheet','A2')
    % Writing the total quantities in the same Excel File
    Total_Surface_Per_Building_diff=Outcomes_diff(1,:)
    Total_Rent_Per_Building_diff=Outcomes_diff(2,:)
    Total_Property_Value_Per_Building_diff=Outcomes_diff(3,:)
    Total_Outcomes_diff=[sum(Total_Surface_Per_Building_diff),sum(Total_Rent_Per_Building_diff),sum(Total_Property_Value_Per_Building_diff),Internal_Rate_Of_Return_diff]
    col_header={'Total Surface Difference (m^2)','Total Rent Per Year Difference (CHF)','Total Property Value Difference (CHF)','Internal Rate of Return Difference'}
    xlswrite('Outcomes_Difference.xls',Total_Outcomes_diff,'sheet','H2')
    xlswrite('Outcomes_Difference.xls',col_header,'sheet','H1')
end
%--------------------------------------------------------------------------
function print(Outcomes,Internal_Rate_Of_Return)
    col_header={'Building A','Building B','Building C'}
    row_header={'Surface Per Building (m^2)','Total Rent Per Building Per Year (CHF)','Property Value Per Building (CHF)'}
    xlswrite('Outcomes_before_devs.xls',Outcomes,'sheet','B2')
    xlswrite('Outcomes_before_devs.xls',col_header,'sheet','B1')
    xlswrite('Outcomes_before_devs.xls',row_header','sheet','A2')
    % Writing the total quantities in the same Excel File
    Total_Surface_Per_Building=Outcomes(1,:)
    Total_Rent_Per_Building=Outcomes(2,:)
    Total_Property_Value_Per_Building=Outcomes(3,:)
    Total_Outcomes=[sum(Total_Surface_Per_Building),sum(Total_Rent_Per_Building),sum(Total_Property_Value_Per_Building),Internal_Rate_Of_Return]
    col_header={'Total Surface (m^2)','Total Rent Per Year (CHF)','Total Property Value (CHF)','Internal Rate of Return'}
    xlswrite('Outcomes_before_devs.xls',Total_Outcomes,'sheet','H2')
    xlswrite('Outcomes_before_devs.xls',col_header,'sheet','H1')
end
%--------------------------------------------------------------------------
function print_dev(Outcomes_Dev,Internal_Rate_Of_Return)
    col_header={'Building A','Building B','Building C'}
    row_header={'Surface Per Building (m^2)','Total Rent Per Building Per Year (CHF)','Property Value Per Building (CHF)'}
    xlswrite('Outcomes_after_devs.xls',Outcomes_Dev,'sheet','B2')
    xlswrite('Outcomes_after_devs.xls',col_header,'sheet','B1')
    xlswrite('Outcomes_after_devs.xls',row_header','sheet','A2')
    % Writing the total quantities in the same Excel File
    Total_Surface_Per_Building=Outcomes_Dev(1,:)
    Total_Rent_Per_Building=Outcomes_Dev(2,:)
    Total_Property_Value_Per_Building=Outcomes_Dev(3,:)
    Total_Outcomes_Dev=[sum(Total_Surface_Per_Building),sum(Total_Rent_Per_Building),sum(Total_Property_Value_Per_Building),Internal_Rate_Of_Return]
    col_header={'Total Surface (m^2)','Total Rent Per Year (CHF)','Total Property Value (CHF)','Internal Rate of Return'}
    xlswrite('Outcomes_after_devs.xls',Total_Outcomes_Dev,'sheet','H2')
    xlswrite('Outcomes_after_devs.xls',col_header,'sheet','H1')
end
%----------Method 1--------------------------------------------------------
function [Total_Discounted_Cash_Flow_Per_Year,Y_array]=myfunction(r,Y,GR,Total_Rent_Per_Building)
    GF=1+GR/100
    Y_array=1:Y
    Total_Discounted_Cash_Flow=zeros(1,Y)
    Undiscounted_Cash_Flow_Per_Year=sum(Total_Rent_Per_Building)
        for i =1:Y
            Total_Discounted_Cash_Flow_Per_Year(i)=(Undiscounted_Cash_Flow_Per_Year*(GF^(i-1)))/(1+r/100)^i
        end    
%     Total_Discounted_Cash_Flow=sum(Total_Discounted_Cash_Flow_Per_Year)
end

%-----------Method 2-------------------------------------------------------
function [Total_Discounted_Cash_Flow_Per_Year_2,Discounted_Cash_Flow_Per_Rental_Object,Y_array]=myfunction2(r,Y,GR,UnDiscounted_Cash_Flow_Per_Rental_Object)
GF=1+GR/100
Y_array=1:Y
Discounted_Cash_Flow_Per_Rental_Object=zeros(18,Y)
for i =1:18
    for j=1:Y
        Discounted_Cash_Flow_Per_Rental_Object(i,j)=(UnDiscounted_Cash_Flow_Per_Rental_Object(i)*(GF^(j-1)))/(1+r/100)^j
    end
end
Total_Discounted_Cash_Flow_Per_Rental_Object=sum(Discounted_Cash_Flow_Per_Rental_Object)
Total_Discounted_Cash_Flow_Per_Year_2=sum(Discounted_Cash_Flow_Per_Rental_Object,1)
end

%-----------Method 3-------------------------------------------------------
function [Total_Discounted_Cash_Flow_Per_Year_3,Y_array]=myfunction4(r,Y,GR,UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New)
GF=1+GR/100
Y_array=1:Y
Discounted_Cash_Flow_Per_Rental_Object_3=zeros(18,Y)
for i =1:18
    for j=1:Y
        Discounted_Cash_Flow_Per_Rental_Object_3(i,j)=(UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New(i,j)*(GF^(j-1)))/(1+r/100)^j
    end
end
Total_Discounted_Cash_Flow_Per_Rental_Object_3=sum(Discounted_Cash_Flow_Per_Rental_Object_3)
Total_Discounted_Cash_Flow_Per_Year_3=sum(Discounted_Cash_Flow_Per_Rental_Object_3,1)
end



%Developments
%--------------------------------------------------------------------------
function [New_Surface_Per_Rental_Object_For_Building_A,New_Surface_Per_Rental_Object_For_Building_B,New_Surface_Per_Rental_Object_For_Building_C,New_Total_Rent_Per_Rental_Object_For_Building_A,New_Total_Rent_Per_Rental_Object_For_Building_B,New_Total_Rent_Per_Rental_Object_For_Building_C,UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New]=myfunction3(UnDiscounted_Cash_Flow_Per_Rental_Object,Y,Code_A,Code_B,Code_C,Surface_Per_Rental_Object_For_Building_A,Surface_Per_Rental_Object_For_Building_B,Surface_Per_Rental_Object_For_Building_C,Total_Rent_Per_Rental_Object_For_Building_A,Total_Rent_Per_Rental_Object_For_Building_B,Total_Rent_Per_Rental_Object_For_Building_C,nrotd)
    investment_matrix=zeros(18,Y)
    development_rent_matrix=zeros(18,Y)
    UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix=repmat(UnDiscounted_Cash_Flow_Per_Rental_Object,1,Y)
    UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New=zeros(18,Y)
    New_Surface_Per_Rental_Object_For_Building_A=Surface_Per_Rental_Object_For_Building_A
    New_Surface_Per_Rental_Object_For_Building_B=Surface_Per_Rental_Object_For_Building_B
    New_Surface_Per_Rental_Object_For_Building_C=Surface_Per_Rental_Object_For_Building_C
    New_Total_Rent_Per_Rental_Object_For_Building_A=Total_Rent_Per_Rental_Object_For_Building_A
    New_Total_Rent_Per_Rental_Object_For_Building_B=Total_Rent_Per_Rental_Object_For_Building_B
    New_Total_Rent_Per_Rental_Object_For_Building_C=Total_Rent_Per_Rental_Object_For_Building_C
    if nrotd==1
        %Taking the rental object code input
        prompt = {'enter the rental object code you want to destroy and rebuild:'};
        dlgtitle = 'Input';
        dims = [1 50];
        definput = {''};
        code_old = inputdlg(prompt,dlgtitle,dims,definput)
        code=code_old{1} 
        %Checking if the rental object code exists
        checkA=contains(Code_A,code)
        checkB=contains(Code_B,code)
        checkC=contains(Code_C,code)
        if checkA==1
            disp('Good. You have picked Building A.')
        elseif checkB==1
            disp('Good. You have picked Building B.')
        elseif checkC==1
            disp('Good. You have picked Building C.')
        else
            disp('Sorry. Such a Building/Rental Object doesnt exist')
            
        end
        prompt = {'enter the project start in years from today:','enter the project duration (Years):','enter the investment amount (CHF):','enter the updated rentable surface (m^2):','enter the projected rentable price per m^2 (CHF):'};
        dlgtitle = 'Input';
        dims = [1 50];
        definput = {'','','','',''};
        answer = inputdlg(prompt,dlgtitle,dims,definput)
        %------------------------------------------------------------------
        project_start=str2double(answer{1})
        project_duration=str2double(answer{2});
        investment=str2double(answer{3});
        updated_rentable_surface=str2double(answer{4});
        projected_rental_price=str2double(answer{5});
        development_array_1=[project_start,project_duration,investment,updated_rentable_surface,projected_rental_price]
        development_rent=updated_rentable_surface*projected_rental_price
        development_array_2=[project_start,project_duration,investment,development_rent]
        investment_start_time=project_start
        investment_end_time=project_start+project_duration
        rental_start_time=investment_end_time
        if code=='A1' 
                 investment_matrix(1,investment_start_time)=investment
                 development_rent_matrix(1,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(1,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(1)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(1)=projected_rental_price
        elseif code=='A2'
                 investment_matrix(2,investment_start_time)=investment
                 development_rent_matrix(2,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(2,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(2)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(2)=projected_rental_price
        elseif code=='A3'
                 investment_matrix(3,investment_start_time)=investment
                 development_rent_matrix(3,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(3,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(3)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(3)=projected_rental_price
        elseif code=='A4'
                 investment_matrix(4,investment_start_time)=investment
                 development_rent_matrix(4,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(4,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(4)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(4)=projected_rental_price
        elseif code=='A5'
                 investment_matrix(5,investment_start_time)=investment
                 development_rent_matrix(5,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(5,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(5)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(5)=projected_rental_price
        elseif code=='A6'
                 investment_matrix(6,investment_start_time)=investment
                 development_rent_matrix(6,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(6,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(6)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(6)=projected_rental_price
        elseif code=='A7'
                 investment_matrix(7,investment_start_time)=investment
                 development_rent_matrix(7,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(7,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(7)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(7)=projected_rental_price
        elseif code=='A8'
                 investment_matrix(8,investment_start_time)=investment
                 development_rent_matrix(8,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(8,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(8)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(8)=projected_rental_price
        elseif code=='B1'
                 investment_matrix(9,investment_start_time)=investment
                 development_rent_matrix(9,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(9,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(9)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(9)=projected_rental_price
        elseif code=='B2'
                 investment_matrix(10,investment_start_time)=investment
                 development_rent_matrix(10,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(10,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(10)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(10)=projected_rental_price
        elseif code=='B3'
                 investment_matrix(11,investment_start_time)=investment
                 development_rent_matrix(11,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(11,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(11)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(11)=projected_rental_price
        elseif code=='B4'
                 investment_matrix(12,investment_start_time)=investment
                 development_rent_matrix(12,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(12,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(12)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(12)=projected_rental_price
        elseif code=='C1'
                 investment_matrix(13,investment_start_time)=investment
                 development_rent_matrix(13,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(13,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(13)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(13)=projected_rental_price
        elseif code=='C2'
                 investment_matrix(14,investment_start_time)=investment
                 development_rent_matrix(14,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(14,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(14)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(14)=projected_rental_price
        elseif code=='C3'
                 investment_matrix(15,investment_start_time)=investment
                 development_rent_matrix(15,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(15,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(15)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(15)=projected_rental_price
        elseif code=='C4'
                 investment_matrix(16,investment_start_time)=investment
                 development_rent_matrix(16,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(16,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(16)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(16)=projected_rental_price
        elseif code=='C5'
                 investment_matrix(17,investment_start_time)=investment
                 development_rent_matrix(17,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(17,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(17)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(17)=projected_rental_price
        else code=='C6'
                 investment_matrix(18,investment_start_time)=investment
                 development_rent_matrix(18,rental_start_time:Y)=development_rent
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(18,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(18)=updated_rentable_surface
                 New_Total_Rent_Per_Rental_Object_For_Building_A(18)=projected_rental_price
            end
        
        
        UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New=UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix-investment_matrix+development_rent_matrix
    else
        code_array=strings([1,nrotd])
        sum_code=''
        for i = 1:nrotd
            %Taking the rental object code input
            prompt = {'enter the rental object code you want to destroy and rebuild:'};
            dlgtitle = 'Input';
            dims = [1 50];
            definput = {''};
            code_old = inputdlg(prompt,dlgtitle,dims,definput)
            code=code_old{1}  
            sum_code=strcat(code,sum_code)
            code_array(1,i)=code
            if i>1
                check=contains(sum_code(3:length(sum_code)),code)
                if check==1
                    disp('Stop here. You cannot destroy a building twice!!')
                    break
                end
                
            end
            %storing the rental object code input       
            %Checking if the rental object code exists
            checkA=contains(Code_A,code)
            checkB=contains(Code_B,code)
            checkC=contains(Code_C,code)
            if checkA==1
                disp('Good. You have picked Building A.')
            elseif checkB==1
                disp('Good. You have picked Building B.')
            elseif checkC==1
                disp('Good. You have picked Building C.')
            else
                disp('Sorry. Such a Building/Rental Object doesnt exist')
                break
            end
          
            %------------------------------------------------------------------
            prompt = {'enter the project start in years from today:','enter the project duration (Years):','enter the investment amount (CHF):','enter the updated rentable surface (m^2):','enter the projected rentable price per m^2 (CHF):'};
            dlgtitle = 'Input';
            dims = [1 50];
            definput = {'','','','',''};
            answer = inputdlg(prompt,dlgtitle,dims,definput)
            %------------------------------------------------------------------
            project_start=str2double(answer{1})
            project_start_array(i)=project_start
            project_duration=str2double(answer{2});
            project_duration_array(i)=project_duration
            investment=str2double(answer{3});
            investment_array(i)=investment
            updated_rentable_surface=str2double(answer{4});
            updated_rentable_surface_array(i)=updated_rentable_surface
            projected_rental_price=str2double(answer{5});
            projected_rental_price_array(i)=projected_rental_price
            %------------------------------------------------------------------
        end
        %Building the development matrix
        development_matrix_1=[project_start_array.',project_duration_array.',investment_array.',updated_rentable_surface_array.',projected_rental_price_array.']
        development_rent=updated_rentable_surface_array.*projected_rental_price_array
        development_matrix_2=[project_start_array.',project_duration_array.',investment_array.',development_rent.']
        %Building a Cell object to include strings and nums in the same "matrix"
        D = cell(nrotd, 2);
        for i =1:nrotd
            D{i, 1} = code_array(i);
            D{i, 2} = development_matrix_2(i,:);
        end
        D{1,1}(1)
        %Update discounted cash flow with the new parameters and plot it
       
        for i = 1:length(D)
            investment_start_time=D{i,2}(1)
            investment_end_time=investment_start_time+D{i,2}(2)
            rental_start_time=investment_end_time
            if D{i,1}=='A1' 
                 investment_matrix(1,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(1,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(1,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(1)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(1)=projected_rental_price_array(i)
            elseif D{i,1}=='A2'
                 investment_matrix(2,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(2,rental_start_time:Y)=D{i,2}(4) 
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(2,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(2)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(2)=projected_rental_price_array(i)
            elseif D{i,1}=='A3'
                 investment_matrix(3,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(3,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(3,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(3)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(3)=projected_rental_price_array(i)
            elseif D{i,1}=='A4'
                 investment_matrix(4,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(4,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(4,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(4)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(4)=projected_rental_price_array(i)
            elseif D{i,1}=='A5'
                 investment_matrix(5,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(5,rental_start_time:Y)=D{i,2}(4)  
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(5,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(5)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(5)=projected_rental_price_array(i)
            elseif D{i,1}=='A6'
                 investment_matrix(6,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(6,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(6,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(6)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(6)=projected_rental_price_array(i)
            elseif D{i,1}=='A7'
                 investment_matrix(7,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(7,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(7,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_B(1)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(7)=projected_rental_price_array(i)
            elseif D{i,1}=='A8'
                 investment_matrix(8,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(8,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(8,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_A(8)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_A(8)=projected_rental_price_array(i)
            elseif D{i,1}=='B1'
                 investment_matrix(9,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(9,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(9,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_B(1)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_B(1)=projected_rental_price_array(i)
            elseif D{i,1}=='B2'
                 investment_matrix(10,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(10,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(10,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_B(2)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_B(2)=projected_rental_price_array(i)
            elseif D{i,1}=='B3'
                 investment_matrix(11,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(11,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(11,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_B(3)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_B(3)=projected_rental_price_array(i)
            elseif D{i,1}=='B4'
                 investment_matrix(12,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(12,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(12,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_B(4)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_B(4)=projected_rental_price_array(i)
            elseif D{i,1}=='C1'
                 investment_matrix(13,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(13,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(13,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(1)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(1)=projected_rental_price_array(i)
            elseif D{i,1}=='C2'
                 investment_matrix(14,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(14,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(14,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(2)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(2)=projected_rental_price_array(i)
            elseif D{i,1}=='C3'
                 investment_matrix(15,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(15,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(15,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(3)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(3)=projected_rental_price_array(i)
            elseif D{i,1}=='C4'
                 investment_matrix(16,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(16,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(16,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(4)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(4)=projected_rental_price_array(i)
            elseif D{i,1}=='C5'
                 investment_matrix(17,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(17,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(17,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(5)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(5)=projected_rental_price_array(i)
            else D{i,1}=='C6'
                 investment_matrix(18,investment_start_time)=D{i,2}(3)
                 development_rent_matrix(18,rental_start_time:Y)=D{i,2}(4)
                 UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix(18,rental_start_time:Y)=0
                 New_Surface_Per_Rental_Object_For_Building_C(6)=updated_rentable_surface_array(i)
                 New_Total_Rent_Per_Rental_Object_For_Building_C(6)=projected_rental_price_array(i)
            end
        end
        
        UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix_New=UnDiscounted_Cash_Flow_Per_Rental_Object_Matrix-investment_matrix+development_rent_matrix
    end
end

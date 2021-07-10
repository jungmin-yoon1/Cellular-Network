% made by Jungmin Yoon
%%%%%%%%%%%%%%%%%%% 21.05.27 : Cellular_Network_Topology %%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
close all;

%%%%%%%%%%%%%%셀 배치%%%%%%%%%%%%%%
% main cell
center_cell = zeros(1,2); %중앙의 기준 셀 기지국 위치 좌표

k_main = 2;
R = 1000; %반지름
type = 0;

% 1-tier cells
k = 1;
surround_cell = zeros(1,12); %기준 셀에 인접한 1-tier, 2-tier 셀의 기지국 위치 좌표 초기화
 
for i = 30:60:330  %각도를 변화시켜가며 1-tier 셀 기지국의 극좌표 형성
    
    % 기준점과 1-tier 사이 거리
    cc = sqrt(3) * R * cos(i * pi / 180) ;  %극좌표를 이용하여 표현
    cc(:,2) = sqrt(3) * R * sin(i * pi / 180) ;
    
    surround_cell(:,k:k+1) = center_cell + cc;
    k = k + 2;
    cc = 0;
end

% 2-tier cells
for i = 30:30:360  %각도를 변화시켜가며 2-tier 셀 기지국의 극좌표 형성
    
    % 기준점과 2-tier 사이 거리
    if mod(i,60) == 0            %극좌표를 이용하여 표현
        cc = 3 * R * cos(i * pi / 180) * ones(1,1);  
        cc(:,2) = 3 * R * sin(i * pi / 180) * ones(1,1);
    else
        cc = 2*sqrt(3) * R * cos(i * pi / 180) * ones(1,1);
        cc(:,2) = 2*sqrt(3) * R * sin(i * pi / 180) * ones(1,1);
    end
    
    surround_cell(:,k:k+1) = center_cell + cc;
    k = k + 2;
    cc = 0;
end
 
hold on
flag = 0;
plot(center_cell(1,1),center_cell(1,2),'<r') %중앙의 기준이 되는 기지국 

for i = 1:18           % 중앙 기지국, 1-tier, 2-tier 기지국 모두 표시
    if(flag == 0)
        plot(surround_cell(1,2*i-1),surround_cell(1,2*i),'<g')
        hold on
    end
    if(i == 7)
        flag = 1;
    end
    if(flag == 1)
        plot(surround_cell(1,2*i-1),surround_cell(1,2*i),'<b')
        hold on
    end
end

% 육각형 셀을 형성
hexagon(1000,center_cell(1,1),center_cell(1,2)) %함수를 불러와 육각형 셀 모양 출력
hold on

for i = 1 : 18
   hexagon(1000,surround_cell(1,2*i-1),surround_cell(1,2*i)); 
   hold on
end
xlabel('meter')
ylabel('meter')

%%%%%%%%%%%%%단말 배치%%%%%%%%%%%

N_t=19*7;  %전체 단말 개수
N=7;
terminal=zeros(N_t , 2);

r=(R*sqrt(3))/2;

for i=1:N   %중앙 기지국 주변의 단말 7개 배치
    x=randi([0 360],1,1);
    terminal(i,1)=r*cos(x)*rand(1);
    terminal(i,2)=r*sin(x)*rand(1);
    plot(terminal(i,1),terminal(i,2),'*');
    hold on;
end

for i=1:18   %1-tier, 2-tier 셀 모두의 기지국 주변에 단말 7개씩 배치
    for j=1:N
        x=randi([0 360],1,1); 
        terminal(i*N+j,1)=surround_cell(1,2*i-1)+r*cos(x)*rand(1);
        terminal(i*N+j,2)=surround_cell(1,2*i)+r*sin(x)*rand(1);
        plot(terminal(i*N+j,1),terminal(i*N+j,2),'*');
        hold on;
    end
end




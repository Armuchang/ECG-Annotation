function [fedwaves_val,c_info] = markDataPoints(fedwaves_val,R_peak_pos,...
    data_pos,signal,start,stop)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% 5.Labeling procedures by automatic and manual method
fig=figure;
str=string(1:length(fedwaves_val(:,1)));
str1=string(R_peak_pos(1:end,2));
plot(data_pos,signal(start:stop)); hold on;
plot(fedwaves_val(:,1),signal(fedwaves_val(:,1)),'or',...
            'MarkerFaceColor','r');
text(fedwaves_val(:,1),signal(fedwaves_val(:,1))-0.1,str)
text(R_peak_pos(:,1),signal(R_peak_pos(:,1))+0.1,str1)

dcm_info=datacursormode(fig);
set(dcm_info,'Enable','on')
uiwait(msgbox('Click line that point is added, then press OK.','Message'));
c_info=getCursorInfo(dcm_info);
i=length(c_info);
for j=1:i
    pos=find(fedwaves_val<c_info(j).Position(1,1));
    if isempty(pos)
        fedwaves_val(2:end+1,1)=fedwaves_val(1:end,1);
        fedwaves_val(1,1)=c_info(j).Position(1,1);
    else
        fedwaves_val(pos(end,1)+2:end+1,1)=fedwaves_val(pos(end,1)+1:end,1);
        fedwaves_val(pos(end,1)+1,1)=c_info(j).Position(1,1);
    end     
end


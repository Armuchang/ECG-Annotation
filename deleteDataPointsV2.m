function [fedwaves_val,c_info1,pos1] = deleteDataPointsV2(fedwaves_val,R_peak_pos,...
    data_pos,signal,start,stop)
% 6.*** Additional command lines *** 
        % If some end T wave annotations are incorrect and they have to be deleted,
        % use this section for doing that.
        fig=figure;
        str=string(1:length(fedwaves_val(:,1)));
        str1=string(R_peak_pos(1:end,2));
        plot(data_pos,signal(start:stop)); hold on;
        plot(fedwaves_val(:,1),signal(fedwaves_val(:,1)),'or',...
                    'MarkerFaceColor','r');
        text(fedwaves_val(:,1),signal(fedwaves_val(:,1))-0.1,str)
        text(R_peak_pos(:,1),signal(R_peak_pos(:,1))+0.1,str1)
        
        dcm_info1=datacursormode(fig);
        set(dcm_info1,'Enable','on')
        uiwait(msgbox('Click line that point is deleted, then press OK.','Message'));
        c_info1=getCursorInfo(dcm_info1);
        k=length(c_info1);
        for l=1:k
            pos1=find(fedwaves_val(:,1)==c_info1(l).Position(1,1));
            fedwaves_val(pos1)=[];
        end
end


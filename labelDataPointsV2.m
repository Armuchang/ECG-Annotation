function [data_coll_cat1,data] = labelDataPointsV2(data_pos,R_peak_pos,...
    fedwaves_val,ann_excludePlus,start,stop,tm,signal)
% 7.Annotate every point in ECG sample
        % There are 3 parts --> 1. points before the 1st end of T wave positions
        %                   --> 2. points between T wave positions
        %                   --> 3. points after the last end of T wave positions
        data_pos_type=data_pos;

        % This is part 1.
        R_peak_bf_t_val=R_peak_pos(R_peak_pos(:,1)<=fedwaves_val(1,1)-1);
        if isempty(R_peak_bf_t_val)
            R_peak_bf_t=find(ann_excludePlus==R_peak_pos(1,1))-1;
            R_peak_bf_t_pos=ann_excludePlus(R_peak_bf_t,:);
            if R_peak_bf_t_pos(1,2)==1
               data_pos_type(data_pos_type<fedwaves_val(1,1))=1;
            elseif R_peak_bf_t_pos(1,2)==2
                data_pos_type(data_pos_type<fedwaves_val(1,1))=2;
            elseif R_peak_bf_t_pos(1,2)==3
                data_pos_type(data_pos_type<fedwaves_val(1,1))=3;
            end
        else
            R_peak_bf_t=find(ann_excludePlus==R_peak_bf_t_val);
            R_peak_bf_t_pos=ann_excludePlus(R_peak_bf_t,:);
            if R_peak_bf_t_pos(1,2)==1
               data_pos_type(data_pos_type<fedwaves_val(1,1))=1;
            elseif R_peak_bf_t_pos(1,2)==2
                data_pos_type(data_pos_type<fedwaves_val(1,1))=2;
            elseif R_peak_bf_t_pos(1,2)==3
                data_pos_type(data_pos_type<fedwaves_val(1,1))=3;
            end    
        end

        % This is part 2.
        % k=1:length(fedwaves_val)-1
        for k=1:length(fedwaves_val)-1
            R_peak_t2t=R_peak_pos(R_peak_pos>=fedwaves_val(k) &...
                R_peak_pos<=fedwaves_val(k+1),:);
            if length(R_peak_t2t(:,1))==1
                if R_peak_t2t(1,2)==1
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=1;
                elseif R_peak_t2t(1,2)==2
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=2;
                elseif R_peak_t2t(1,2)==3
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=3;
                end
            else
                if R_peak_t2t(:,2)==1
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=1;
                elseif R_peak_t2t(:,2)==2
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=2;
                elseif R_peak_t2t(:,2)==3
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=3;
                else
                    data_pos_type(data_pos_type>=fedwaves_val(k) &...
                        data_pos_type<=fedwaves_val(k+1))=0;
                end
            end
        end

        % This is part 3.
        R_peak_af_t_val=R_peak_pos(R_peak_pos(:,1)>=fedwaves_val(end,1)+1);
        if isempty(R_peak_af_t_val)
            R_peak_af_t=find(ann_excludePlus==R_peak_pos(end,1))+1;
            R_peak_af_t_pos=ann_excludePlus(R_peak_af_t,:);
            if R_peak_af_t_pos(1,2)==1
               data_pos_type(data_pos_type>fedwaves_val(end,1))=1;
            elseif R_peak_af_t_pos(1,2)==2
                data_pos_type(data_pos_type>fedwaves_val(end,1))=2;
            elseif R_peak_af_t_pos(1,2)==3
                data_pos_type(data_pos_type>fedwaves_val(end,1))=3;
            end
        else
            R_peak_af_t=find(ann_excludePlus==R_peak_af_t_val);
            R_peak_af_t_pos=ann_excludePlus(R_peak_af_t,:);
            if R_peak_af_t_pos(1,2)==1
               data_pos_type(data_pos_type>fedwaves_val(end,1))=1;
            elseif R_peak_af_t_pos(1,2)==2
                data_pos_type(data_pos_type>fedwaves_val(end,1))=2;
            elseif R_peak_af_t_pos(1,2)==3
                data_pos_type(data_pos_type>fedwaves_val(end,1))=3;
            end    
        end

        % Making categorical array.
        data_coll_cat1=categorical((data_pos_type(:,1))',[1 4 2 3],...
            {'NSR' 'AF' 'PAC' 'PVC'});
        
        % 8.Ploting 30-second ECG samples and point annotations to check that every point is correct.
        time=(tm(start:stop))';
        data=(signal(start:stop))';
        figure,plot(time,data,'Color',[.8 .8 .8]), hold on
        for i=1:length(data)
            if data_pos_type(i)==1
                plot(time(i),data(i),'.','Color','r','MarkerSize',8), 
                hold on
            elseif data_pos_type(i)==2
                plot(time(i),data(i),'.','Color',[0 0.2 0.5],'MarkerSize',8), 
                hold on
            elseif data_pos_type(i)==3
                plot(time(i),data(i),'.','Color','m','MarkerSize',8), 
                hold on
            end
        end
        title('ECG with labeled types')
end


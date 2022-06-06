function [pos_ann,ann_excludePlus] = defineAnnTypesV2(anntype,anncomment,...
    annsamp)
% 3.Annotation types
% Collect each annotation type into number (from char to double).
% N(Normal beat)=1, A(PAC)=2, V(PVC)=3, +(comments)=4
collect=[]; %  Define name of matrix that collect annotation types.
% Create for loop to check every annotation type and define the types to
% number 1, 2, 3 and 4.
for j=1:length(anntype)
    if(anntype(j)=='N')
        col(j) = 1;
    end
    if(anntype(j)=='A')
        col(j) = 2;
    end
    if(anntype(j)=='V')
        col(j) = 3;
    end
    if(anntype(j)=='+')
        if(anncomment{j,1}=="(N")
            col(j) = 5;
        elseif(anncomment{j,1}=="(AFIB")
            col(j) = 4;
        else
            col(j) = 0;
        end
    end
end
collect=[collect col]; % Record parameter col in matrix collect.
ct=collect(:); % Invert a matrix collect into a new matrix ct.
pos_ann = []; %  Define name of matrix that collect annotation position and
% number of annotaation types.
pos_ann = [pos_ann annsamp ct ]; % Collect annotation position (ann) and number 
% of annotaation types (ct) in  matrix pos_ann.

% Exclude annotation type as a '+'
ann_excludePlus=pos_ann;
ann_excludePlus(anntype=='+',:)=[];
ann_excludePlus(ann_excludePlus(:,2)==0,:)=[];
end


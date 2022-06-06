close all;
clear all;
clc;

%% 1.Using ecgpuwave function for making make ECG wave annotations
rec_num='56';
[~,config]=wfdbloadlib;
config.WFDB_JAVA_HOME='E:\Project\data\database';
eval(['cd ' config.WFDB_JAVA_HOME filesep 'ltafdb'])
ecgpuwave(rec_num,'puw',[],[],'qrs','1',[]);

%% 2.Using rdsamp and rdann function for read ECG samples, and beat and rhythm annotations. 
[signal,Fs,tm]=rdsamp(rec_num,[1],[],[]);
[annsamp,anntype,~,~,annnum,anncomment]=rdann(rec_num,'atr',[1],[],[]);
[edwaves,~,~,~,ednum,~]=rdann(rec_num,'puw',[1],[],[],')');

%% 3.Annotation types
cd E:\Project\mat\mat_ltafdb_understanding
[pos_ann,ann_excludePlus] = defineAnnTypes(anntype,anncomment,annsamp);

%% 4.1 Get values from .mat file
cd E:\Project\mat\mat_ltafdb_understanding\PAC\pos
file_name="PAC_"+rec_num+".mat";
M=load(file_name);

%% 4.2 Check '(AFIB' and others
n=2; %*** Don't forget to change it.
start=M.data(n,1); 
num_samp=3839;
stop=start+num_samp;
data_pos=(start:stop)';
data=(signal(start:stop));

pos_ann_30sec=pos_ann(pos_ann>=start & pos_ann<=stop,:);
arrhy_other=find(pos_ann_30sec(:,2)==0);
arrhy_af=find(pos_ann_30sec(:,2)==4);
if ~isempty(arrhy_other) && isempty(arrhy_af)
    uiwait(msgbox('There are/is other arrythmia(s), please be careful.'));
elseif ~isempty(arrhy_af)
    uiwait(msgbox('AFIB ALERT! Please ignore and save it to examine later.'));
    cd E:\Project\mat\mat_ltafdb_understanding\PAC_AF
    file_name="TryPAC_AF_"+rec_num+"_"+n+".mat";
    save(file_name,'data','data_pos');
elseif isempty(arrhy_af) && isempty(arrhy_other)
    uiwait(msgbox('Continue to label.'));
end

%% 4.3 Define parameters
R_peak_pos=ann_excludePlus(ann_excludePlus>=start &...
    ann_excludePlus<=stop,:);

edwaves_pos=find(edwaves>=start & edwaves<=stop);
edwaves_val=edwaves(edwaves>=start & edwaves<=stop);
e=ednum(edwaves_pos);
fe=find(e==2);
fedwaves_val=edwaves_val(fe);

%% 5.Labeling procedures by automatic and manual method
cd E:\Project\mat\mat_ltafdb_understanding
[fedwaves_val,c_info] = markDataPoints(fedwaves_val,R_peak_pos,...
    data_pos,signal,start,stop);

%% 6.*** Additional command lines *** 
% If some end T wave annotations are incorrect and they have to be deleted,
% use this section for doing that.
[fedwaves_val,c_info1] = deleteDataPoints(fedwaves_val,R_peak_pos,...
    data_pos,signal,start,stop);

%% 
% 7.Annotate every point in ECG sample
% There are 3 parts --> 1. points before the 1st end of T wave positions
%                   --> 2. points between T wave positions
%                   --> 3. points after the last end of T wave positions
% 8.Ploting 30-second ECG samples and point annotations to check that every point is correct.
    data_coll_cat1 = labelDataPoints(data_pos,R_peak_pos,...
        fedwaves_val,ann_excludePlus,start,stop,tm,signal); 

%% 9.Save array in .mat file
cd E:\Project\mat\mat_ltafdb_understanding\PAC\val_cat\all
file_name="TryPAC_"+rec_num+"_"+n+".mat";
save(file_name,'data','data_coll_cat1');
cd E:\Project\mat\mat_ltafdb_understanding\PAC\endTwave
file_name="TryPAC_EndTwave_val_"+rec_num+"_"+n+".mat";
save(file_name,'fedwaves_val');
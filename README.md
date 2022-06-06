# ECG-Annotation
A developed MATLAB program for ECG signal annotations.
If no one is perfect, no annotation program is perfect either.
As we know, physiological signals are not stable all the time because of several factors, for example, body movement artifact, loose electrodes, and electromagnetic interference. Thus, we can encounter any artifacts in the ECG signals. 
Fortunately, the WFDB toolbox was developed for reading, writing, and processing physiologic signals and time series for the PhysioBank databases. 
(For more information: https://archive.physionet.org/physiotools/matlab/wfdb-app-matlab/)
We can use the internal function of the toolbox for observing and analyzing ECG data easily.
However, in some cases the toolbox cannot be automatically used to deal with the ECG data with artifact signals.
This is including cardiac arrhythamias which also affact mophology of ECG signals.

These ideas are a begining point of this ECG-Annotation program.
This program allows users to manually annotate ECG signals in rhythm-by-rhythm. 
Users can mark new points and remove unwanted points then, all of ECG beats are annoted in 4 types of cardiac rhythms. 
The 4 types of heart rhythms are NSR (Normal Sinus Rhythm), AF (Atrial Fibrilation), PAC (Premature Atrial Contraction), and PVC (Premature Ventricular Contration) (Disclaimer: It depends on the database. In this case, Long Term AF Database were used.)
Some functions of the WFDB toolbox also were applied in this program for an ECG data pre-processing.

This is used for academic purposes only. 
Please feel free to contact me if you have any questions and suggestions. 

Good luck! (🍀✨)

Jantappapa Chanthercrob
Email: j.chanthercrob@gmail.com

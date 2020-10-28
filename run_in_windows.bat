@echo off

start matlab -nodisplay -nodesktop -r "Main_Align_LFW(6, 'AFFINE'); exit" > "aff6.log"
start matlab -nodisplay -nodesktop -r "Main_Align_LFW(7, 'AFFINE'); exit" > "aff7.log"
start matlab -nodisplay -nodesktop -r "Main_Align_LFW(8, 'AFFINE'); exit" > "aff8.log"
start matlab -nodisplay -nodesktop -r "Main_Align_LFW(9, 'AFFINE'); exit" > "aff9.log"
start matlab -nodisplay -nodesktop -r "Main_Align_LFW(10, 'AFFINE'); exit" > "aff10.log"

exit
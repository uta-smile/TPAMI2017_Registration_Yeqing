@echo off

FOR /L %%A IN (6,1,10) DO (
  start matlab -nodisplay -nodesktop -r "Main_Align_LFW(%%A, 'TRANSLATION'); exit" > "trans%%A.log"
)

exit
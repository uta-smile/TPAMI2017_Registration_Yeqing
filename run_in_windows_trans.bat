@echo off

FOR /L %%A IN (1,1,5) DO (
  start matlab -nodisplay -nodesktop -r "Main_Align_LFW(%%A, 'TRANSLATION'); exit" > "trans%%A.log"
)

exit
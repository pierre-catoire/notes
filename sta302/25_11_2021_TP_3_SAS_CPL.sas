libname tp 'C:\Users\pcatoire\Downloads\tp';

proc import datafile='C:\Users\pcatoire\Downloads\tp\paquid_long_500sujets.txt'
out = tp.df
replace;
run;

proc univariate data=tp.df;
var mmse bvrt ist age_init;
histogram age_init/normal;
run;

proc freq data = tp.df;
tables homme*dem / missing chisq expected;
run;

data tp.df;
set tp.df;
tsuivi = agedem-age_init;
run;

data tp.df;
set tp.df;
if HIER > 0 then dep = 1;
else if HIER = 0 then dep = 0;
else dep = .;

if age_init > 75 then ageinit75 = 1;
else if age_init <= 75 then ageinit75 = 0;
else ageinit75 = 0;
run;


proc glimmix data=tp.df method=quad;
class ID;
model dep = ageinit75 homme tsuivi ageinit75*tsuivi homme*tsuivi /s link=logit dist=bin;
random intercept /subject = ID;
estimate "homme a entree" homme 1 homme*tsuivi 0 / exp cl;
estimate "homme a entree" homme 10 homme*tsuivi 0 / exp cl;
run;

proc genmod descending;
class ID;
model dep = ageinit75 homme tsuivi ageinit75*tsuivi homme*tsuivi / link=logit dist=bin;
repeated subject = ID ;
run;

proc genmod descending;
class ID;
model dep = ageinit75 homme tsuivi ageinit75*tsuivi homme*tsuivi / link=logit dist=bin;
repeated subject = ID / corrw corr=cs;
run;

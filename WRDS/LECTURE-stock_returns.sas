options noovp ls=72;

* Define the # of days to hold each stock;
%let hold = 180;


data portfolio;
     infile 'my_lecture2_portfolio.txt' dsd firstobs=2 delimiter='09'x;
     input  permno	       
     	    name	$
     	    mmddyyyy    $;

     * Convert text date into SAS numeric date;
     month   = substr(mmddyyyy,1,2);
     day     = substr(mmddyyyy,3,2);
     year    = substr(mmddyyyy,5,4);
     buydate = mdy(month, day, year);

     keep permno name buydate;
run;


/* Find daily returns for your investments & compound them. */
proc sql;
     create table dailies as
     select a.permno, a.name, a.buydate, b.retx, log(1+b.retx) as logret from
     portfolio as a left join crsp.dsf as b
     on a.permno eq b.permno
     where (b.date ge a.buydate) and (b.date le a.buydate + &hold); 
quit;


/*
title "Inspect result of PROC SQL join";
proc print data=dailies;
run;
* Looks good!;
*/


/* Calculate cumulative return. log(Product of x) = sum of (log x) */
proc summary data=dailies nway noprint sum;
     class permno name buydate;
     var logret;
     output out = sumlogs sum=sumlogs;
run;


/* Invert the initial log(1+retx) operation */ 
data returns;
     set sumlogs;
     totalret = exp(sumlogs) - 1;
     keep permno name buydate totalret;
run;


/* Inspect the final results */
title "Total decimal return of each holding";
proc print data=returns;
run;

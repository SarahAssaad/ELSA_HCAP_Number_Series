//Dr Sarah Assaad - University College London, UK 
//code created on 03/09/2024

*Derivation of the number series test score based on HRS 2012 SAS code (Updated)
cd "path_where_dataset_is_stored" // replace with the right path 
use "name_of_dataset.dta", clear // replace with the dataset name

//For the list of variables and coding, please refer to the excel sheet 'NS_variables.xlsx'

//step 1: generate the list variable
*NSlist (list A '1' and list B '2') 

gen NSlist=.
recode NSlist .=-1 if cf242==-1 | cf201g1==3  // test not started or participant does not understand instructions 
recode NSlist .=1 if cf242==1  & cf201g1 != -1 & cf202h1 != -1 & cf203i1 != -1 // test started and first 3 items in list 1 different than not applicable
recode NSlist .=2 if cf242==1  & cf221g2 != -1 & cf222h2 != -1 & cf223i2 != -1 // test started and first 3 items in list 2 different than not applicable

tab NSlist, m
tab NSlist cf242, m

tab NSlist cf201g1, m
tab NSlist cf202h1, m
tab NSlist cf203i1, m

tab NSlist cf221g2, m
tab NSlist cf222h2, m
tab NSlist cf223i2, m

label define list_label 1 "list A" 2 "list B" -1 "Not applicable"
label values NSlist list_label
save, replace

tab NSlist, m

//step 2: generate the first set score (2 variables based on list 1 or 2)

*recode the items into 0, 1 and missing (for not applicable)

//items in list 1
local list1 cf201g1 cf202h1 cf203i1 cf204a1 cf205b1 cf206c1 cf207d1 cf208e1 cf209f1 cf210j1 cf211k1 cf212l1 cf213m1 cf214n1 cf215o1

foreach lname of local list1 {
recode `lname' (-8 2 =0) (1=1) (-1 3=.), generate(`lname'_sc)
}

//items in list 2
local list2 cf221g2 cf222h2 cf223i2 cf224a2 cf225b2 cf226c2 cf227d2 cf228e2 cf229f2 cf230j2 cf231k2 cf232l2 cf233m2 cf234n2 cf235o2

foreach lname of local list2 {
recode `lname' (-8 2 =0) (1=1) (-1 3=.), generate(`lname'_sc)
}

//generate the 2 scores Set1A and Set1B
egen Set1A= rowtotal(cf201g1_sc cf202h1_sc cf203i1_sc), missing

egen Set1B= rowtotal(cf221g2_sc cf222h2_sc cf223i2_sc), missing

tab1 Set1A Set1B, m
tab Set1A Set1B, m

//step 3: generate the second set score (2 variables based on list 1 or 2)
*Set2A and Set2B
egen Set2A= rowtotal(cf204a1_sc cf205b1_sc cf206c1_sc cf207d1_sc cf208e1_sc cf209f1_sc cf210j1_sc cf211k1_sc cf212l1_sc cf213m1_sc cf214n1_sc cf215o1_sc), missing

egen Set2B= rowtotal(cf224a2_sc cf225b2_sc cf226c2_sc cf227d2_sc cf228e2_sc cf229f2_sc cf230j2_sc cf231k2_sc cf232l2_sc cf233m2_sc cf234n2_sc cf235o2_sc), missing

tab1 Set2A Set2B, m
tab Set2A Set2B, m

//step 4: write the programme for the derivation of the Number series score and its standard error (SE)

program drop NumSeries
drop NS_score NS_score_SE

program NumSeries, rclass
	version 1.0
	args NSlist Set1A Set2A Set1B Set2B

gen NS_score=.

	recode NS_score .=409 if `Set1A'==0 & `Set2A'==0 & `NSlist'==1
	recode NS_score .=429 if `Set1A'==0 & `Set2A'==1 & `NSlist'==1
	recode NS_score .=462 if `Set1A'==0 & `Set2A'==2 & `NSlist'==1
	recode NS_score .=484 if `Set1A'==0 & `Set2A'==3 & `NSlist'==1
	recode NS_score .=488 if `Set1A'==1 & `Set2A'==0 & `NSlist'==1
	recode NS_score .=501 if `Set1A'==1 & `Set2A'==1 & `NSlist'==1
	recode NS_score .=513 if `Set1A'==1 & `Set2A'==2 & `NSlist'==1
	recode NS_score .=524 if `Set1A'==1 & `Set2A'==3 & `NSlist'==1
	recode NS_score .=518 if `Set1A'==2 & `Set2A'==0 & `NSlist'==1
	recode NS_score .=528 if `Set1A'==2 & `Set2A'==1 & `NSlist'==1
	recode NS_score .=536 if `Set1A'==2 & `Set2A'==2 & `NSlist'==1
	recode NS_score .=546 if `Set1A'==2 & `Set2A'==3 & `NSlist'==1
	recode NS_score .=536 if `Set1A'==3 & `Set2A'==0 & `NSlist'==1
	recode NS_score .=546 if `Set1A'==3 & `Set2A'==1 & `NSlist'==1
	recode NS_score .=558 if `Set1A'==3 & `Set2A'==2 & `NSlist'==1
	recode NS_score .=570 if `Set1A'==3 & `Set2A'==3 & `NSlist'==1

	recode NS_score .=413 if `Set1B'==0 & `Set2B'==0 & `NSlist'==2
	recode NS_score .=435 if `Set1B'==0 & `Set2B'==1 & `NSlist'==2
	recode NS_score .=465 if `Set1B'==0 & `Set2B'==2 & `NSlist'==2
	recode NS_score .=485 if `Set1B'==0 & `Set2B'==3 & `NSlist'==2
	recode NS_score .=489 if `Set1B'==1 & `Set2B'==0 & `NSlist'==2
	recode NS_score .=503 if `Set1B'==1 & `Set2B'==1 & `NSlist'==2
	recode NS_score .=514 if `Set1B'==1 & `Set2B'==2 & `NSlist'==2
	recode NS_score .=525 if `Set1B'==1 & `Set2B'==3 & `NSlist'==2
	recode NS_score .=519 if `Set1B'==2 & `Set2B'==0 & `NSlist'==2
	recode NS_score .=529 if `Set1B'==2 & `Set2B'==1 & `NSlist'==2
	recode NS_score .=537 if `Set1B'==2 & `Set2B'==2 & `NSlist'==2
	recode NS_score .=547 if `Set1B'==2 & `Set2B'==3 & `NSlist'==2
	recode NS_score .=537 if `Set1B'==3 & `Set2B'==0 & `NSlist'==2
	recode NS_score .=549 if `Set1B'==3 & `Set2B'==1 & `NSlist'==2
	recode NS_score .=567 if `Set1B'==3 & `Set2B'==2 & `NSlist'==2
	recode NS_score .=584 if `Set1B'==3 & `Set2B'==3 & `NSlist'==2

gen NS_score_SE=.

	recode NS_score_SE .=18 if `Set1A'==0 & `Set2A'==0 & `NSlist'==1
	recode NS_score_SE .=19 if `Set1A'==0 & `Set2A'==1 & `NSlist'==1
	recode NS_score_SE .=17 if `Set1A'==0 & `Set2A'==2 & `NSlist'==1
	recode NS_score_SE .=13 if `Set1A'==0 & `Set2A'==3 & `NSlist'==1
	recode NS_score_SE .=12 if `Set1A'==1 & `Set2A'==0 & `NSlist'==1
	recode NS_score_SE .=11 if `Set1A'==1 & `Set2A'==1 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==1 & `Set2A'==2 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==1 & `Set2A'==3 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==2 & `Set2A'==0 & `NSlist'==1
	recode NS_score_SE .=9  if `Set1A'==2 & `Set2A'==1 & `NSlist'==1
	recode NS_score_SE .=9  if `Set1A'==2 & `Set2A'==2 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==2 & `Set2A'==3 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==3 & `Set2A'==0 & `NSlist'==1
	recode NS_score_SE .=10 if `Set1A'==3 & `Set2A'==1 & `NSlist'==1
	recode NS_score_SE .=12 if `Set1A'==3 & `Set2A'==2 & `NSlist'==1
	recode NS_score_SE .=16 if `Set1A'==3 & `Set2A'==3 & `NSlist'==1

	recode NS_score_SE .=18 if `Set1B'==0 & `Set2B'==0 & `NSlist'==2
	recode NS_score_SE .=19 if `Set1B'==0 & `Set2B'==1 & `NSlist'==2
	recode NS_score_SE .=15 if `Set1B'==0 & `Set2B'==2 & `NSlist'==2
	recode NS_score_SE .=12 if `Set1B'==0 & `Set2B'==3 & `NSlist'==2
	recode NS_score_SE .=12 if `Set1B'==1 & `Set2B'==0 & `NSlist'==2
	recode NS_score_SE .=11 if `Set1B'==1 & `Set2B'==1 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==1 & `Set2B'==2 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==1 & `Set2B'==3 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==2 & `Set2B'==0 & `NSlist'==2
	recode NS_score_SE .=9  if `Set1B'==2 & `Set2B'==1 & `NSlist'==2
	recode NS_score_SE .=9  if `Set1B'==2 & `Set2B'==2 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==2 & `Set2B'==3 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==3 & `Set2B'==0 & `NSlist'==2
	recode NS_score_SE .=10 if `Set1B'==3 & `Set2B'==1 & `NSlist'==2
	recode NS_score_SE .=16 if `Set1B'==3 & `Set2B'==2 & `NSlist'==2
	recode NS_score_SE .=18 if `Set1B'==3 & `Set2B'==3 & `NSlist'==2

end 

NumSeries NSlist Set1A Set2A Set1B Set2B
sum NS_score NS_score_SE, d // these are your number series score and standard error variables 
save, replace 

***************END.
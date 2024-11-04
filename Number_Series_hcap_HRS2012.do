//Dr Sarah Assaad - University College London, UK 
//code created on 03/09/2024

*Derivation of the number series test score based on HRS 2012 SAS code (Updated)
cd "path_where_dataset_is_stored" // replace with the right path 
use "name_of_dataset.dta", clear // replace with the dataset name

//For the list of variables and coding, please refer to the excel sheet 'NS_variables.xlsx'

//step 1: generate the list variable
*NSlist (list A '1' and list B '2') 

gen NSlist=.
recode NSlist .=-1 if NS904_NSIntro<1 | NSA31_Set3Item1==7 | NSB31_Set3Item1==7 // test not adminstered (refused or not applicable negative scores and 7 Respondent does not understand)

recode NSlist .=1 if NS904_NSIntro==1  & NSA31_Set3Item1!= -1 & NSA32_Set3Item2!= -1 & NSA33_Set3Item3!= -1 // test started and first 3 items in list 1 different than not applicable

recode NSlist .=2 if NS904_NSIntro==1  & NSB31_Set3Item1!= -1 & NSB32_Set3Item2!= -1 & NSB33_Set3Item3!= -1 // test started and first 3 items in list 2 different than not applicable

tab NSlist, m
label define list_label 1 "list A" 2 "list B" -1 "Not applicable"
label values NSlist list_label
tab NSlist, m

//data checks
tab NS904_NSIntro NSlist, m
tab NS900_NSExample1 NSlist, m
tab NS901_NSExample2 NSlist, m

//step 2: generate the first set score (2 variables based on list 1 or 2)

*recode the items into 0, 1 and missing (for not applicable)

//items in list 1
local list1 NSA31_Set3Item1 NSA32_Set3Item2 NSA33_Set3Item3 NSA11_Set1Item1 NSA12_Set1Item2 NSA13_Set1Item3 NSA21_Set2Item1 NSA22_Set2Item2 NSA23_Set2Item3 NSA41_Set4Item1 NSA42_Set4Item2 NSA43_Set4Item3 NSA51_Set5Item1 NSA52_Set5Item2 NSA53_Set5Item3

//labels
* -8 dont know
*  5 incorrect answer 
*  1 correct answer 
* -9 refused item 
* -1 not applicable
*  7 Respondent does not understand 

foreach lname of local list1 {
recode `lname' (-8 5 =0) (1=1) (-9 -1 7=.), generate(`lname'_sc)
}

//items in list 2
local list2 NSB31_Set3Item1 NSB32_Set3Item2 NSB33_Set3Item3 NSB11_Set1Item1 NSB12_Set1Item2 NSB13_Set1Item3 NSB21_Set2Item1 NSB22_Set2Item2 NSB23_Set2Item3 NSB41_Set4Item1 NSB42_Set4Item2 NSB43_Set4Item3 NSB51_Set5Item1 NSB52_Set5Item2 NSB53_Set5Item3

foreach lname of local list2 {
recode `lname' (-8 5 =0) (1=1) (-9 -1 7=.), generate(`lname'_sc)
}

//generate the 2 scores Set1A and Set1B
egen Set1A= rowtotal(NSA31_Set3Item1_sc NSA32_Set3Item2_sc NSA33_Set3Item3_sc), missing

egen Set1B= rowtotal(NSB31_Set3Item1_sc NSB32_Set3Item2_sc NSB33_Set3Item3_sc), missing

tab1 Set1A Set1B, m
tab Set1A Set1B, m

//step 3: generate the second set score (2 variables based on list 1 or 2)
*Set2A and Set2B
egen Set2A= rowtotal(NSA11_Set1Item1_sc NSA12_Set1Item2_sc NSA13_Set1Item3_sc NSA21_Set2Item1_sc NSA22_Set2Item2_sc NSA23_Set2Item3_sc NSA41_Set4Item1_sc NSA42_Set4Item2_sc NSA43_Set4Item3_sc NSA51_Set5Item1_sc NSA52_Set5Item2_sc NSA53_Set5Item3_sc), missing

egen Set2B= rowtotal(NSB11_Set1Item1_sc NSB12_Set1Item2_sc NSB13_Set1Item3_sc NSB21_Set2Item1_sc NSB22_Set2Item2_sc NSB23_Set2Item3_sc NSB41_Set4Item1_sc NSB42_Set4Item2_sc NSB43_Set4Item3_sc NSB51_Set5Item1_sc NSB52_Set5Item2_sc NSB53_Set5Item3_sc), missing

tab1 Set2A Set2B, m
tab Set2A Set2B, m

//step 4: write the programme for the derivation of the Number series score and its standard error (SE)

*program drop NumSeries // to make sure that this program does not exist already
*drop NS_score NS_score_SE // to make sure that these varaibles do not exist already

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

*save, replace // if you want to save the changes to your dataset 

***************END.

# ELSA-HCAP
STATA codes for deriving scores in the ELSA-HCAP study

# Number Series Score (and Standard Error)

The number series test is used to measure quantitative reasoning. It consists of administering 2 sets of questions. Set 1 is administered to all participants and consists of 3 items in increasing order of difficulty. Depending on the score of Set 1 (0 to 3) the participants are routed to 1 of 4 avaliable versions of Set 2 with varying levels of difficulty. Set 2 also consists of 3 items and its score ranges from 0 to 3. Hence the total number of items administered by participant is 6. While the available number of items in the dataset is 3+(3x4) = 15 items. The 15 items consist a list. The number series test is available in 2 lists (List A and List B) with 15 items each and participants are randomised into either lists at point of administration.   

To derive the Number series score and standard error variables, we use the Health and Retirement Study (HRS) 2012 Number Series Code orginally developed in SAS software.

Variables in the dataset should include:
* the list (A or B)
* the 15 items for list A 
* the 15 items for list B
* the score for set 1 (0 to 3)
* the score for set 2 (0 to 3)
* other variables about tests administration 







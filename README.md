# ELSA-HCAP
STATA codes for deriving scores in the ELSA-HCAP study.

# Number Series (NS) Test

The number series test is used to measure **quantitative reasoning.** 

It consists of administering 2 sets of questions. Set 1 is administered to all participants and consists of 3 items in increasing order of difficulty. Depending on the score of Set 1 (0 to 3) the participants are routed to 1 of 4 avaliable versions of Set 2 with varying levels of difficulty. Set 2 also consists of 3 items and its score ranges from 0 to 3. Hence the total number of items administered by participant is 6. While the available number of items in the dataset is 3 items + (3 items x4 sets) = 15 items. The 15 items make one list. The number series test is available in 2 lists (List A and List B) with 15 items each and participants are randomised into either lists at point of administration.   

To derive the Number series score and standard error summary variables, we used the Health and Retirement Study (HRS) 2012 Number Series Code orginally developed in SAS software.

**Raw data variables should include:**
* The list (A or B)
* The 15 items for list A 
* The 15 items for list B
* Other variables about tests administration (if any)

**Derived variables include:**
* The score for set 1 (0 to 3) (intermediate variable)
* The score for set 2 (0 to 3) (intermediate variable)
* The Number series score (summary variable)
* The standard error (summary variable)

*The excel file NS_variables.xlsx* includes details about the raw data variables, labels, and coding. 

*The Stata code file Number_series.do* includes data management steps and derivation steps of the intermediate and summary variables.

**For queries, please email Dr Assaad at:** s.assaad@ucl.ac.uk

*Usage*: this code is provided under the creative commons license as an open source subject to citation.

*Citation*:  Assaad S. 2023. ELSA-HCAP study: Derivation of the summary variables for the Number Series Test. STATA 17 code, version 1.0. 







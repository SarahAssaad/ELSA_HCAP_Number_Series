# ELSA-HCAP Study

The Healthy Cognitive Ageing Project (HCAP) (2018 - ongoing) is a sub-study of the English Longitudinal Study on Ageing (ELSA) (2002 - ongoing) that aims at studying in-depth the change in cognitive functions within 65+ year-older English adults using the Harmonised Cognitive Assessment Protocol (also abbreviated as HCAP) (For more details please visit //www.elsa-project.ac.uk/hcap). The latter protocol is a tool developed by the Health and Retirement Study (HRS) team in consultation with researchers leading sister studies within the HCAP Network (https://hcap.isr.umich.edu/). 

In this repository, Dr Sarah Assaad, a research fellow in cognitive ageing and dementia at University College London, shares her STATA codes for deriving scores in the ELSA-HCAP study. 

# Number Series (NS) Test

The number series test is used to measure **quantitative reasoning.** 

It consists of administering 2 sets of questions. Set 1 is administered to all participants and consists of 3 items in increasing order of difficulty. Depending on the score of Set 1 (0 to 3) the participants are routed to 1 of 4 available versions of Set 2 with varying levels of difficulty. Set 2 also consists of 3 items and its score ranges from 0 to 3. Hence the total number of items administered to each participant is 6. While the available number of items in the dataset is 3 items + (3 items x4 sets) = 15 items. The 15 items make one list. The number series test is available in 2 lists (List A and List B) with 15 items each and participants are randomised into either list at the point of administration.   

To derive the Number series score and standard error summary variables we used the Health and Retirement Study (HRS) 2012 Number Series Code originally developed in SAS software.

**Raw data variables should include:**
* The list (A or B)
* The 15 items for List A 
* The 15 items for List B
* Other variables about tests administration (if any)

**Derived variables include:**
* The score for set 1 (0 to 3) (intermediate variable)
* The score for set 2 (0 to 3) (intermediate variable)
* The Number series score (summary variable)
* The standard error (summary variable)

*The Excel file NS_variables.xlsx* includes details about the raw data variables, labels, and coding. 

*The Stata code file Number_series.do* includes data management steps and derivation steps of the intermediate and summary variables.

**For queries, please email Dr Assaad at** s.assaad@ucl.ac.uk

*Usage*: this code is provided under the creative commons license as an open source subject to citation.

*Citation*:  Assaad S. 2023. ELSA-HCAP study: Derivation of the summary variables for the Number Series Test. STATA 17 code, version 1.0. 

# ELSA-HCAP Study

The Healthy Cognitive Ageing Project (HCAP) (2018 - ongoing) is a sub-study of the English Longitudinal Study on Ageing (ELSA) (2002 - ongoing) that aims at studying in-depth the change in cognitive functions within 65+ year-older English adults using the Harmonised Cognitive Assessment Protocol (also abbreviated as HCAP) (For more details please visit //www.elsa-project.ac.uk/hcap). The latter protocol is a tool developed by the Health and Retirement Study (HRS) team in consultation with researchers leading sister studies within the HCAP Network (https://hcap.isr.umich.edu/). 

In this repository, Dr Sarah Assaad, a research fellow in cognitive ageing and dementia at University College London, shares her STATA codes for deriving scores in the ELSA-HCAP study. 

# Number Series (NS) Test

The number series test is used to measure **quantitative reasoning.** 

It consists of administering 2 sets of 3 items (or questions) each, making a total of 6 questions per participant. 

The first set (labelled as 'Set 3' in the dataset but referred to as **Set 1** hereafter) is administered to all participants and consists of 3 items (questions 1, 2 and 3) in increasing order of difficulty. Depending on the score of Set 1 (0 to 3), the participant is routed to 1 of 4 available versions of the second set (labelled as 'Set 2', 'Set 4' and 'Set 5' in the dataset but referred to as **Set 2** hereafter) with varying levels of difficulty. Set 2 also consists of 3 items and its score ranges from 0 to 3. Hence the total number of items in the dataset is 3 items for set 1 + (3 items x4 sets) for set 2 = 15 items. The 15 items make one list. The number series test is available in 2 lists (List A and List B) with 15 items each and participants are randomised into either list at the point of administration.

Here is a table summarising the above:

| | List A  | List B | Total in Dataset |
| --- | --- | --- | --- |
| Set 1 | 3 Items | 3 Items | |
| Set 2 | 3 Items in version 1 | 3 Items in version 1 | |
| | 3 Items in version 2 | 3 Items in version 2 | |
| | 3 Items in version 3 | 3 Items in version 3 | |
| | 3 Items in version 3 | 3 Items in version 3 | |
| Total | 15 Items | 15 Items | 30 Items |

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

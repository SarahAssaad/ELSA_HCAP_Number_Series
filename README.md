# ELSA-HCAP Study

The Healthy Cognitive Ageing Project (HCAP) (2018 - ongoing) is a sub-study of the English Longitudinal Study on Ageing (ELSA) (2002 - ongoing) that aims at studying in-depth the change in cognitive functions within 65+ year-older English adults using the Harmonised Cognitive Assessment Protocol (also abbreviated as HCAP) (For more details please visit //www.elsa-project.ac.uk/hcap). The latter protocol is a tool developed by the Health and Retirement Study (HRS) team in consultation with researchers leading sister studies within the HCAP Network (https://hcap.isr.umich.edu/). 

In this repository, Dr Sarah Assaad, a research fellow in cognitive ageing and dementia at University College London, shares her STATA codes for deriving scores in the ELSA-HCAP study. 

# Number Series (NS) Test

The number series test is used to measure **quantitative reasoning.** 

It consists of administering 2 sets of 3 items (or questions) each, making a total of 6 questions per participant. 

The first set (referred to as **Set 1** hereafter) is administered to all participants and consists of 3 items (questions 1, 2 and 3) in increasing order of difficulty. Depending on the score of Set 1 (0 to 3), the participant is routed to 1 out of 4 available versions of the second set (referred to as **Set 2** hereafter) with varying levels of difficulty. Set 2 also consists of 3 items and its score ranges from 0 to 3. Hence the total number of items in the dataset is:  

3 items for Set 1 + (3 items x4 sets) for Set 2 = 15 items

The 15 items make **one list**. The number series test is available in 2 lists (List A and List B) with 15 items each and participants are randomised into either list at the point of administration.

Here is a table summarising the above:

| | List A  | List B | Total in Dataset |
| --- | --- | --- | --- |
| Set 1 | 3 Items | 3 Items | |
| Set 2 | 3 Items in version 1 | 3 Items in version 1 | |
| | 3 Items in version 2 | 3 Items in version 2 | |
| | 3 Items in version 3 | 3 Items in version 3 | |
| | 3 Items in version 3 | 3 Items in version 3 | |
| Total | 15 Items | 15 Items | 30 Items |

**Summary variables and derivation method**  

These 30 items available as raw data can be used to derive two summary variables for the Number Series test:
* Number Series score
* Standard error
  
To derive these summary variables we used the Health and Retirement Study (HRS) Number Series Code originally developed in SAS software:
* The HRS 2010 version code
* The HRS 2012 version code (recommended for use)

**Dataset files**  

The purpose of this repository is to enable the derivation of the Number Series summary variables in any dataset with the raw data adapting the STATA code as needed. 

Two examples of this derivation are provided in the ELSA and ELSA-HCAP studies (please see the table below for the dataset files). Both files are available for download from the UK Data Services website https://ukdataservice.ac.uk/  

| Study | Dataset file name | Study Number in UK Data Services |
|---| ---| ---|
| ELSA wave 8 Nurse Visit | wave_8_elsa_nurse_data_eul_v1.dta | SN 5050 |
| HCAP wave 1 | hcap_2018_eul_respondent_archive.dta | SN 8502 | 

**Raw data variables should include:**  
* The list (A or B) which can be derived if not included in the raw data
* The 15 items for List A 
* The 15 items for List B
* Other variables about tests administration (if any)

**Derived variables include:**  
* The list (A or B) if not included in the raw data
* The score for set 1 (0 to 3) (intermediate variable)
* The score for set 2 (0 to 3) (intermediate variable)
* The Number Series score (summary variable)
* The standard error (summary variable)

**Repository files (attached)**  
* The Excel files include details about the raw data variables, labels, and coding (value labels).
* The Stata code files include data management and derivation steps of the intermediate and summary variables.

Below is a summary table with the file names:

| Study | STATA file | Excel file |
|---|---|---|
| ELSA | Number_series_elsa_HRS2010.do | NS_variables.xlsx (sheet 1) |
|      | Number_series_elsa_HRS2012.do |                        |
| HCAP | Number_series_hcap.do | NS_variables.xlsx (sheet 2) |

Note that in the datasets for ELSA and HCAP, Set 1 corresponds to raw data labelled with 'Set 3', and Set 2 corresponds to raw data labelled with 'Set 1', 'Set 2', 'Set 4', and 'Set 5'. This is evident in the Excel files to be used in conjunction with the STATA files.

**Final important remarks**  

*For queries*: Please email the author, Dr Assaad at s.assaad@ucl.ac.uk

*Usage*: This code is provided under the Creative Commons license as an open source subject to citation.

*Citation*:  Assaad S. 2023. ELSA-HCAP study: Derivation of the summary variables for the Number Series Test. STATA 17 code, version 1.0. 

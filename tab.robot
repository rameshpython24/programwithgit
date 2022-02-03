*** Settings ***
Library		SeleniumLibrary

*** Variables ***
${br}	chrome
${url}	https://www.cricbuzz.com/cricket-series/2798/icc-mens-t20-world-cup-2021
${myteam}	India

*** Test Cases ***
NoOfTeamsInGroup2
	Launch Browser
    ${No_of_Teams}=	get element count	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr
	Log To Console	the total no of teams in Group2: ${No_of_Teams//2}
IndiaIsavAilbleOrNot
	Launch Browser
	Element should contain	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]	${myteam}
	Log To Console	india is availble ${myteam}
RowsColsCells
    Launch Browser
	${r_count}=	get element count	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr
	Log To Console	the total no of rows in group2 table: ${r_count//2}
    ${c_count}=	get element count	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[1]/td
	Log To Console	the total no of columns in Group2 gtable: ${c_count-1}
    ${TotCells}	evaluate	${r_count//2} * ${c_count-1}
    Log To Console	the total no of cells in Group2 table ${TotCells}
TeamPosInPtable
	${t1}	get Text    xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[1]/td[1]
	${t2}	get Text    xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[3]/td[1]
	${t3}	get Text	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[5]/td[1]
	${t4}	get Text	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[7]/td[1]
    ${t5}	get Text	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[9]/td[1]
	${t6}	get Text	xpath://*[@id="page-wrapper"]/div[4]/div[1]/table[4]/tbody/tr[11]/td[1]

    Log	1st position Team: ${t1}	WARN
	Log	2nd position Team: ${t2}	WARN
	Log	3rd position Team: ${t3}	ERROR
	Log	4th position Team: ${t4}	WARN
	Log	5th position Team: ${t5}	WARN
	Log	6th position Team: ${t6}	WARN
	Close All Browsers

*** Keywords ***
Launch Browser
	open browser	${url}	${br}
	maximize browser window
    click link	xpath://*[@id="page-wrapper"]/div[3]/nav/a[5]

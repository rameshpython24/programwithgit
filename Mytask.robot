*** Settings ***
Library     SeleniumLibrary
Library		getp.py
Library		os
Library		OperatingSystem
Suite Setup	Launch Browser
Suite Teardown	close browser


*** Variables ***
${choice}	3
${br}	chrome
${url}	https://whenwise.agileway.net/sign-in
@{values}	//*[@id="services-table"]/tbody/tr[1]/td[6]	//*[@id="services-table"]/tbody/tr[2]/td[6]	//*[@id="services-table"]/tbody/tr[3]/td[6]



*** Test Cases ***
demo
	Login
	Page_validation
	Verify_Service
	Extract_prices
	Get_price with Rgex
	IfElse_Case
	Create_Service


*** Keywords ***
Launch Browser
    Open Browser	${url}	${br}
	maximize browser window
Login
	click link	//*[@id="login_form"]/div[3]/div/div/div[2]/div[1]/a[4]
	click button	id:login-btn
Page_validation
	wait until page contains	Dashboard
Verify_Service
	click element	//*[@id="menu_services"]/span[2]
    wait until page contains	Services
Extract_prices
	FOR    ${val}    IN    @{values}
		${output}=	get text	${val}
		Log	${output}	WARN
	END
Get_price with Rgex
	FOR    ${val}    IN    @{values}
		${output}=	get text	${val}
		${res}=		getPrice	${output}
		log	${res}	WARN
	END
Create_Service
	${j_file}	Get File 	data.json
	${jsfile}    Evaluate    json.loads('''${j_file}''')	json
    ${service_name}    Set Variable    ${jsfile["Service"][0]["ServiceName"]}
    ${service_code}    Set Variable    ${jsfile["Service"][0]["Code"]}
    ${price}    Set Variable    ${jsfile["Service"][0]["Price"]}
    Click Element    //*[@id="new-service-12-link"]
    Input Text    //input[@id="service_name"]    ${service_name}
    Input Text    //input[@id="service_code"]    ${service_code}
    Input Text    //input[@id="service_price"]    ${price}
    Click Button    //button[@id="save-btn"]

IfElse_Case
	Run Keyword If   ${choice}==1	Add
    ...   ELSE IF    ${choice}==2	Mul
	...   ELSE	 Log	"nothing is done"	WARN
Add
	FOR    ${val}    IN    @{values}
		${output}=	get text	${val}
		${res}=		getPrice	${output}
		${res1}=	Evaluate	${res} + 100
		Log	"Adding 100 to price:" ${res1}	WARN
	END
Mul
	FOR    ${val}    IN    @{values}
		${output}=	get text	${val}
		${res}=		getPrice	${output}
		${res1}=	Evaluate	${res} * 2
		Log	"Double the price:" ${res1}	WARN
	END


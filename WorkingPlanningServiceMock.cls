/*
    Name        : WorkingPlanningServiceMock
    Author Name : Mairaj Haider
    Create Date : May 03, 2021
    Version No  : Initial version Created
    Description : This is a Mock Class to generate fake response
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Mairaj Haider  *********** May 03, 2021  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/

public with sharing class WorkingPlanningServiceMock implements HttpCalloutMock{
	public static HttpResponse respond(HttpRequest req) {
    	HttpResponse response = new HttpResponse();
    	response.setStatusCode(200);
        response.setBody('{"success": true, "secretKey": "6f462fc9053739d41b5d4258b0c62d5d"}');
    	return response;
	}
}
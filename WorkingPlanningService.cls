/*
    Name        : WorkingPlanningService
    Author Name : Mairaj Haider
    Create Date : May 03, 2021
    Version No  : Initial version Created
    Description : Class is reponsible for making callout to API and returning response to Batch class
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Mairaj Haider  *********** May 03, 2021  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/

public with sharing class WorkingPlanningService {
    public static ApiResponse getAPICall(sObject sObj){
        //Using Named Creentials
        String endpoint = 'callout:APTest';
        
        //Retrieve Case Id and OwnerId from Case Object to send to API
        String cid = JSON.serialize(sObj.get('Id'));
        String agentId = JSON.serialize(sObj.get('OwnerId'));
        
        //Create API Request
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:APTest');
	request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        request.setHeader('Content-Type','application/json'); 
        request.setMethod('POST');
        //Increased timeout value to 120,000
        request.setTimeout(120000);
        request.setBody('{"id":'+JSON.serialize(cid)+', "agentid":'+JSON.serialize(agentId)+'}');
        
        //Send Request and get Response
        Http http = new Http();
        HttpResponse httpres = new HttpResponse();
        
        try{
            httpres = http.send(request);
            //Deserialize response to API response object
            ApiResponse resp = (ApiResponse)System.JSON.deserialize(httpres.getBody(), ApiResponse.class);
            return resp;

        } catch(System.CalloutException ex){
            System.debug('Error='+ex);
        }
        return null;
    }
}

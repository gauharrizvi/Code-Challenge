/*
    Name        : WorkingPlanningBatch
    Author Name : Mairaj Haider
    Create Date : May 03, 2021
    Version No  : Initial version Created
    Description : Batch is reponsible for making callout and updating Case of Secret Key
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Mairaj Haider  *********** May 03, 2021  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/

public class WorkingPlanningBatch implements Database.Batchable<sobject>, Database.AllowsCallouts, Database.Stateful{
    //Instance member to retain state across transactions
    private Integer recordsProcessed = 0;
    private Integer totalRecords = 0;
    //Generic Batch pass object name on which you want to run Batch
    private String objName;
    //Secret Key field name
    private String key;
    
    //Constructor Dependency Injection
    public WorkingPlanningBatch(String objectName, String secretKey){
        objName = objectName;
        key = secretKey;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id,OwnerId, Secret_Key__c FROM '+ objName + ' WHERE (Status=\'Closed\' AND Secret_Key__c = NULL AND LastModifiedDate = TODAY)';
        return database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope){
        Integer size = scope.size();
        List<API_Log__c> log = new List<API_Log__c>();
        
        //Make all API Calls in batch and save Secret Key for 
        //all successful calls in the scope
        for(Integer i = 0; i < size; i++){
            ApiResponse response = WorkingPlanningService.getAPICall(scope.get(i));
            totalRecords = totalRecords + 1;
            if(response.success){
            	scope.get(i).put(key, response.secretKey);
                recordsProcessed = recordsProcessed + 1;
            } 
        }
        //DML after making all API calls
        //Update Case
        update scope;
    }
    
    //Not useful if batch is scheduled to run very frequently
    //Send email containing Total Records and Number of Records Processed and how many records failed
    //Using Database.Statefull to maintain state and calculate Number of Records
    public void finish(Database.BatchableContext bc){
        Integer recordFailed = totalRecords - recordsProcessed;
        System.debug(recordsProcessed + ' records processed out of Total Records '+totalRecords);
        System.debug('Records Failed: '+recordFailed);

        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);

    }

}
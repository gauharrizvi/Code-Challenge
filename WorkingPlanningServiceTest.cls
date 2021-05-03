/*
    Name        : WorkingPlanningServiceTest
    Author Name : Mairaj Haider
    Create Date : May 03, 2021
    Version No  : Initial version Created
    Description : This is a unit test class
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Mairaj Haider  *********** May 03, 2021  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/

@IsTest
private class WorkingPlanningServiceTest {
    @TestSetup
    private Static void setup(){
        List<Case> cases = TestDataSetup.createCases(1);
        insert cases;
    }
	@IsTest
	static void case_updated_with_secretkey() {
    List<Case> cases = new List<Case>();
    cases = [SELECT Id, OwnerId FROM Case LIMIT 1];

    Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new WorkingPlanningServiceMock());
    	new WorkingPlanningBatch('Case','Secret_Key__c').execute(null, new Case[]{cases[0]});
    Test.stopTest();

    System.assertEquals(1, [SELECT Count() FROM Case WHERE Secret_Key__c = '6f462fc9053739d41b5d4258b0c62d5d']);
}
}
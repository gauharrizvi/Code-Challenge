/*
    Name        : TestDataSetup
    Author Name : Mairaj Haider
    Create Date : May 03, 2021
    Version No  : Initial version Created
    Description : This class setup test data for unit test classes
    
    **************************************** Modified History ******************************************************
    **SR.No******* Modified By *********** Modified Date ************* Version No ********* Description       ******
    ****************************************************************************************************************
    
    **  01 ******* Mairaj Haider  *********** May 03, 2021  ************* V 1.0    *********** Initial version Created* 
 
    ****************************************************************************************************************
*/

public class TestDataSetup {
    public static List<Case> createCases(Integer count){
        List<Case> cases = new List<Case>();
        for(Integer i = 0; i <=count; i++){
            Case caseRecord = new Case(Type = 'Web', Status = 'Closed');
            cases.add(caseRecord);
        }
        return cases;
    }

}
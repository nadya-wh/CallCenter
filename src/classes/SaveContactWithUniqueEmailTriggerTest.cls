@isTest
public class SaveContactWithUniqueEmailTriggerTest {
    @testSetup
    private static void setup() {
        Contact contact = new Contact(
            						  FirstName='TestFName',
        							  LastName='TestLName',
        							  Email='exiting@email.com');
        
        insert contact;
    }
    
    @isTest
    private static void testAddContactWithExitingEmail() {
       System.assertEquals(1, [SELECT count()
            				   FROM Contact 
                               WHERE Email='exiting@email.com']);
        
        try {
        Contact contact = new Contact(
        							  LastName='SecondTestName',
        							  Email='exiting@email.com');
        
        insert contact;
        }
        catch(DmlException e) {
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
        }
    }
    
    @isTest
    private static void testUpdateContactWithoutChangingEmail() {
        Contact contact = [SELECT Id, FirstName, LastName
            		       FROM Contact 
                           WHERE Email='exiting@email.com'
                           LIMIT 1];
        contact.FirstName = 'UpdateNonEmailField';
            
        try {
        	update contact;
        }
        catch(DmlException e) {
            System.assert(false);
        }
    }
}
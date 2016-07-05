@isTest
public class ConnectCaseWithContactTriggerTest {
  
  	@isTest
    private static void testBulkContactsGetCreated() {
        List<Case> newCases = new List<Case>();
        for (Integer i = 0; i < 50; i++) {
            Case c = new Case(SuppliedEmail='test@starwars.com' + i,
                              SuppliedName='Dart Veider' + i,
                              Subject='TestSubject' + i);
            newCases.add(c);
        }
        insert newCases;
        
        List<Id> newCaseIds = new List<Id>();
        for (Case caseObj : newCases) {
            newCaseIds.add(caseObj.Id);    
        }
        
        List<Case> updatedCases = [SELECT ContactId
        						   FROM Case
        						   WHERE Id IN :newCaseIds];
        
        for (Case caseObj:updatedCases) {
            System.assert(caseObj.ContactId != null,'There should be no null contacts');
        }
    }

  	@isTest
    private static void testContactGetsCreated() {
        Case c = new Case(SuppliedEmail='test@starwars.com',
                          SuppliedName='Dart Veider',
                          Subject='TestSubject');
        insert c;

        List<Contact> contacts = [SELECT Id
        						  FROM Contact
        						  WHERE Email='test@starwars.com'];


        System.assert(contacts.size() == 1, 'There should be one contact!');
        
        Case caseObj = [SELECT ContactId
         				FROM Case
         				WHERE Id = :c.Id];
        System.assert(caseObj.ContactId != null,'There should be no null contact on the case');
    }

  	@isTest
    private static void testNoDupesAreCreated() {
        Contact cnt1 = new Contact(FirstName = 'Dart',
                                   LastName = 'Veider',
                                   Email='test@starwars.com');

        insert cnt1;

        Case case1 = new Case(SuppliedEmail='test@starwars.com',
                              SuppliedName='Dart Veider',
                              Subject='TestSubject');

        insert case1;

        List<Contact> contacts = [SELECT Id
        						  FROM Contact
        						  WHERE Email='test@starwars.com'];

        System.assert(contacts.size() == 1, 'There should be one contact!');
    }

  	@isTest
    private static void testEmailNameDoesntGetCreated() {
        Case c = new Case(SuppliedEmail='testEmailNameDoesntGetCreated@test.com',
                          SuppliedName='testEmailNameDoesntGetCreated@test.com',
                          Subject='TestSubject');
        insert c;

        List<Contact> contacts = [SELECT Id
        						  FROM Contact
        						  WHERE Email='testEmailNameDoesntGetCreated@test.com'];


        System.assert(contacts.size() == 0 , 'There should be no contacts!');
    }
}
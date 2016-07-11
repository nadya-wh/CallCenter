@isTest
private class ManagerNotificationTest {
	
	public static final String WEEKLY_CRON_EXP = '0 0 12 ? * MON *';
	private static final Integer RECORDS_COUNT = 2;
	private static final String CONTACT_NAME_PREFIX = 'Test_User';
	private static final String EMAIL_POSTFIX = '@test.com';


	@testSetup static void createCaseWithOwner() {
		List<Contact> contacts = new List<Contact>();
		List<Case> cases = new List<Case>();
		for (Integer i = 0; i < RECORDS_COUNT; i++) {
			contacts.add(new Contact(LastName=CONTACT_NAME_PREFIX + i, Email=CONTACT_NAME_PREFIX + EMAIL_POSTFIX));

		}
		insert contacts;
		for (Integer i = 0; i < RECORDS_COUNT; i++) {
			Case c = new Case();
			c.ContactId = contacts.get(i).ID;
			cases.add(c);
		}

		insert cases;
	}

	@isTest static void testExecute() {
		Test.startTest();
		Integer emailBefore = Limits.getEmailInvocations();
		ManagerNotification reminder = new ManagerNotification();
		String jobID = System.schedule('Manager Notification Test', WEEKLY_CRON_EXP, reminder);
		
		Test.stopTest();
	}
	
	
}
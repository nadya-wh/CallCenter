public with sharing class CaseDataFactory {


	private static final Integer RECORDS_COUNT = 2;
	private static final String CONTACT_NAME_PREFIX = 'Test_User';
	private static final String EMAIL_POSTFIX = '@test.com';


	public CaseDataFactory() {
		
	}

	public static void createCaseWithOwner() {
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
}
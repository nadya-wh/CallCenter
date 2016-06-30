@isTest
private class CaseOwnerNotififcationTest {
	

	public static final String DAILY_CRON_EXP = '0 0 12 1/1 * ? *';


	@isTest static void testExecute() {
		Test.startTest();
		CaseDataFactory.createCaseWithOwner();
		Integer emailBefore = Limits.getEmailInvocations();
		CaseOwnerNotififcation reminder = new CaseOwnerNotififcation();
		String jobID = System.schedule('Remind Case Owners Test', DAILY_CRON_EXP, reminder);
		

		Test.stopTest();

		System.assertNotEquals(emailBefore, Limits.getEmailInvocations(),'The number of send emails should have decreased');
	}
	
}
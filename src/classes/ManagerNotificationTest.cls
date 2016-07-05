@isTest
private class ManagerNotificationTest {
	
	public static final String WEEKLY_CRON_EXP = '0 0 12 ? * MON *';


	@isTest static void testExecute() {
		Test.startTest();
		CaseDataFactory.createCaseWithOwner();
		Integer emailBefore = Limits.getEmailInvocations();
		ManagerNotification reminder = new ManagerNotification();
		String jobID = System.schedule('Manager Notification Test', WEEKLY_CRON_EXP, reminder);
		
		Test.stopTest();
	}
	
	
}
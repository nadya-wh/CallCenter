@isTest
private class BossNotificationTest {
	
	public static final String CRON_EXP = '0 0 0 15 3 ? 2022';


	@isTest static void testSendNotification() {
		Test.startTest();
    	String jobId = System.schedule('ScheduleApexClassTest',
                        CRON_EXP, 
                        new BossNotification());
    	Test.stopTest();
	}
	
}
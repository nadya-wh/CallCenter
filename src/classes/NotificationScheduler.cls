public class NotificationScheduler {
	

	public static final String DAILY_CRON_EXP = '0 0 12 1/1 * ? *';

	public static void scheduleDailyOwnerNotfications() {
		CaseOwnerNotififcation reminder = new CaseOwnerNotififcation();
		String jobID = System.schedule('Remind Case Owners', DAILY_CRON_EXP, reminder);
	}

}
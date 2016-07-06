global class BossNotification implements Schedulable {

	private static final String EMAIL_TEMPLATE_NAME = 'Boss Email Template For List of Cases';
	private static final String ROLE_NAME = 'Boss';

	global void execute(SchedulableContext sc) {
		NotificationSenderHelper notificationSenderHelper = 
			new NotificationSenderHelper(ROLE_NAME, EMAIL_TEMPLATE_NAME);
		notificationSenderHelper.send();
	}
}
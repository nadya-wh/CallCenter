global class ManagerNotification implements Schedulable {

	private static final String EMAIL_TEMPLATE_NAME = 'Weekly newsletter for Manager';
	private static final String ROLE_NAME = 'CC Manager';


	global void execute(SchedulableContext sc) {
		NotificationSenderHelper notificationSenderHelper = 
			new NotificationSenderHelper(ROLE_NAME, EMAIL_TEMPLATE_NAME);
		notificationSenderHelper.send();

	}
}
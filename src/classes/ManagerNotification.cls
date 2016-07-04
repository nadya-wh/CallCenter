global class ManagerNotification implements Schedulable {

	private static final String EMAIL_TEMPLATE_NAME = 'Weekly newsletter for Manager';
	private static final String ROLE_NAME = 'CC Manager';

	global void execute(SchedulableContext sc) {

		Id roleId = RoleHelper.getRoleId(ROLE_NAME);
		List<User> users = [SELECT Email 
							FROM User
							WHERE UserRole.Id = :roleId];
		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		for (User user : users) {

			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setToAddresses(new String[] { user.Email});
			email.setTemplateId(EmailTemplateHelper.getTemplateId(EMAIL_TEMPLATE_NAME));
			email.setTargetObjectId(user.Id);
			email.setSaveAsActivity(false);
			mails.add(email);
		}
		Messaging.sendEmail(mails);
	}
}
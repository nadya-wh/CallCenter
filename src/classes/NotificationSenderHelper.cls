public with sharing class NotificationSenderHelper {

	private String roleName;
	private String templateName;

	public NotificationSenderHelper(String roleName, String templateName) {
		this.roleName = roleName;
		this.templateName = templateName;
	}

	public void send() {
		Id roleId = RoleHelper.getRoleId(roleName);
		List<User> users = [SELECT Email 
							FROM User
							WHERE UserRole.Id = :roleId];
		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		for (User user : users) {
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setToAddresses(new String[] { user.Email });
			email.setTemplateId(EmailTemplateHelper.getTemplateId(templateName));
			email.setTargetObjectId(user.Id);
			email.setSaveAsActivity(false);
			mails.add(email);
		}
		Messaging.sendEmail(mails);
	}
}
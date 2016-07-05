global class CaseOwnerNotififcation implements Schedulable {
	
	private static final String EMAIL_TEMPLATE_NAME = 'OwnerNotification';

	global void execute(SchedulableContext ctx) {
		List<Case> cases = [SELECT ID, Type,  
							ContactId, Status, Contact.Email
							FROM Case 
							WHERE Status != 'Closed'];

		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		for (Case c : cases) {
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setToAddresses(new String[] { c.Contact.Email });
			email.setTemplateId(EmailTemplateHelper.getTemplateId(EMAIL_TEMPLATE_NAME));
			email.setTargetObjectId(c.ContactId);
			email.setSaveAsActivity(false);
			email.setWhatId(c.Id);
			mails.add(email);
		}
		Messaging.sendEmail(mails);
	}


}
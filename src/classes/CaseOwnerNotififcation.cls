global class CaseOwnerNotififcation implements Schedulable {
	
	private static final String EMAIL_TEMPLATE_NAME = 'OwnerNotification';

	global void execute(SchedulableContext ctx) {
		List<Case> cases = [SELECT ID, Type,  
							ContactId, Status, Contact.Email
							FROM Case 
							WHERE Status != 'Closed'];
<<<<<<< HEAD

		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		for (Case c : cases) {
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setToAddresses(new String[] { c.Contact.Email });
			email.setTemplateId(EmailTemplateHelper.getTemplateId(EMAIL_TEMPLATE_NAME));
			email.setTargetObjectId(c.ContactId);
=======
		List<Id> receivers = new List<Id>();
		List<Id> whatIds = new List<Id>();
		for (Case c : cases) {
			receivers.add(c.ContactId);
			whatIds.add(c.Id);
		}
		
		if (receivers.size() > 0) {
			Messaging.MassEmailMessage  email = new Messaging.MassEmailMessage();
			email.setTargetObjectIds(receivers);
			email.setTemplateId(EmailTemplateHelper.getTemplateId(EMAIL_TEMPLATE_NAME));
			email.setWhatIds(whatIds);
>>>>>>> 1dbac89f9198d45fe6db392d12ad927e8cb779b9
			email.setSaveAsActivity(false);
			email.setWhatId(c.Id);
			mails.add(email);
		}
		Messaging.sendEmail(mails);
	}


}
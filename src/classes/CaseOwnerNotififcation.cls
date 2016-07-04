global class CaseOwnerNotififcation implements Schedulable {
	
	private static final String EMAIL_TEMPLATE_NAME = 'OwnerNotification';

	global void execute(SchedulableContext ctx) {
		List<Case> cases = [SELECT ID, Type,  
							ContactId, Status
							FROM Case 
							WHERE Status != 'Closed'];
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
			email.setSaveAsActivity(false);
			Messaging.SendEmail(New Messaging.MassEmailMessage[] {email});
		}
	}


}
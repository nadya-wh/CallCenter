global class CaseOwnerNotififcation implements Schedulable {
	
	private static final String EMAIL_TEMPLATE_NAME = 'OwnerNotification';

	global void execute(SchedulableContext ctx) {
		List<Case> cases = [SELECT ID, Type,  
							ContactId, Status
							FROM Case 
							WHERE LastEmailWasSent__c = false];
		List<Id> receivers = new List<Id>();
		List<Id> whatIds = new List<Id>();
		List<Case> closedCases = new List<Case>();
		for (Case c : cases) {
			receivers.add(c.ContactId);
			whatIds.add(c.Id);
			if (c.Status == 'Closed') {
				closedCases.add(c);
				c.LastEmailWasSent__c = true;
			}
		}
		EmailTemplate et = [SELECT id 
							FROM EmailTemplate 
							WHERE name = :EMAIL_TEMPLATE_NAME];

		if (receivers.size() > 0) {
			Messaging.MassEmailMessage  email = new Messaging.MassEmailMessage();
			email.setTargetObjectIds(receivers);
			email.setTemplateId(et.ID);
			email.setWhatIds(whatIds);
			email.setSaveAsActivity(false);
			Messaging.SendEmail(New Messaging.MassEmailMessage[] {email});
		}
		if (closedCases.size() > 0) {
			update closedCases;
		}
	}


}
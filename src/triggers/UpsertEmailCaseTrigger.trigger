trigger UpsertEmailCaseTrigger on Case (before insert, before update) {
	for(Case c : trigger.new) {
		Contact contact = [SELECT Id, Email
						   FROM Contact
						   WHERE (Email = :c.ContactEmail) OR (Email = :c.SuppliedEmail)];
		if(contact != null) {
			c.addError('Email address ' + contact.Email + ' is taken by Contact ' + contact.Id + '.');
		}
	}
}
trigger SaveContactWithUniqueEmailTrigger on Contact (before insert, before update) {
	for(Contact c : Trigger.New) {
		List<Contact> contacts = [SELECT Id, Email, FirstName, LastName
						          FROM Contact
						          WHERE Id <> :c.Id
                                  AND Email = :c.Email
                                  LIMIT 1];
		if(!contacts.isEmpty()) {
            Contact contact = contacts.get(0);
            String link = '<a href="/'+ contact.Id +'">' + contact.FirstName + '  ' + contact.LastName + '</a>';
            
			c.addError('Email address ' + contact.Email +
                       ' is taken by ' + link, false);
		}
	}
}
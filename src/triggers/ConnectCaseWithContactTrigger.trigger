trigger ConnectCaseWithContactTrigger on Case (before insert) {
    List<String> emailAddresses = new List<String>();
    
    for (Case caseObj : Trigger.new) {
        if (caseObj.ContactId == null &&
            caseObj.SuppliedEmail != '') {
            emailAddresses.add(caseObj.SuppliedEmail);
        }
    }

    List<Contact> listContacts = [SELECT Id, Email
    							  FROM Contact
    							  WHERE Email
    							  IN :emailAddresses];
    Set<String> takenEmails = new Set<String>();
    for (Contact c:listContacts) {
        takenEmails.add(c.Email);
    }
    
    Map<String,Contact> emailToContactMap = new Map<String,Contact>();
    List<Case> casesToUpdate = new List<Case>();

	for (Case caseObj : Trigger.new) {
        if (caseObj.ContactId == null &&
            caseObj.SuppliedName != null &&
            caseObj.SuppliedEmail != null &&
            caseObj.SuppliedName != '' &&
            !caseObj.SuppliedName.contains('@') &&
            caseObj.SuppliedEmail != '' &&
            !takenEmails.contains(caseObj.SuppliedEmail))
        {
            String[] nameParts = caseObj.SuppliedName.split(' ', 2);
            if (nameParts.size() == 2)
            {
                Contact cont = new Contact(FirstName = nameParts[0],
                                           LastName = nameParts[1],
                                           Email = caseObj.SuppliedEmail);
                emailToContactMap.put(caseObj.SuppliedEmail, cont);
                casesToUpdate.add(caseObj);
            }
        }
    }
    
    List<Contact> newContacts = emailToContactMap.values();
    insert newContacts;
    
    for (Case caseObj : casesToUpdate) {
        Contact newContact = emailToContactMap.get(caseObj.SuppliedEmail);
        
        caseObj.ContactId = newContact.Id;
    }
}
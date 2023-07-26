trigger CreateDefaultContact on Account (after insert, after update) {
    
    Set<Id> accIdLst = new Set<Id>();
    for (Account acc : Trigger.new) {
        if(acc.Type == 'Customer' && acc.Active__c==true){
            accIdLst.add(acc.Id);
        }       
    }
    List<Account> lstAccount = [Select id,Name,Company_Email__c,Phone,(Select id from Contacts) from Account where Id in : accIdLst];
    List<Contact> newContacts = new List<Contact>();
    for(Account acc: lstAccount){
        if(acc.Contacts.size()==0){
            Contact newContact = new Contact(
            FirstName = acc.Name,
            LastName = 'Customer Representative',
            AccountId = acc.Id,
            Email = acc.Company_Email__c,
            Phone = acc.Phone
        );
        newContacts.add(newContact);
        }
    }

     
    if (!newContacts.isEmpty()) {
        insert newContacts;
    }
}

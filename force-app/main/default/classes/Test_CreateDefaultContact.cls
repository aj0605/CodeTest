@isTest
public class Test_CreateDefaultContact {
    @isTest
    static void testCreateDefaultContact() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                Type = 'Customer',
                Active__c = true,
                Company_Email__c = 'test' + i + '@example.com',
                Phone = '123-456-7890'
            ));
        }
        insert testAccounts;

        Test.startTest();
        update testAccounts;

        List<Contact> createdContacts = [SELECT Id, FirstName, LastName, AccountId, Email, Phone
                                        FROM Contact
                                        WHERE AccountId IN :testAccounts];
        Test.stopTest();

        System.assertEquals(testAccounts.size(), createdContacts.size());

        for (Contact contact : createdContacts) {
            String expectedFullName = contact.Account.Name + ' Customer Representative';
            System.assertEquals(expectedFullName, contact.FirstName + ' ' + contact.LastName);
            System.assertEquals(contact.Account.Company_Email__c, contact.Email);
            System.assertEquals(contact.Account.Phone, contact.Phone);
        }
    }

    @isTest
    static void testActivateAccountWithSummary() {
        // Test data setup
        Account testAccount = new Account(
            Name = 'Test Account',
            Type = 'Customer',
            Active__c = false
        );
        insert testAccount;

        String accountSummary = 'Test account activated.';

        Test.startTest();
        activateAccountClass.activateAccountwWithSummary(testAccount.Id, accountSummary);
        Test.stopTest();

        Account updatedAccount = [SELECT Id, Active__c, Account_Activation_Summary__c
                                 FROM Account
                                 WHERE Id = :testAccount.Id];

        System.assertEquals(true, updatedAccount.Active__c);
        System.assertEquals(accountSummary, updatedAccount.Account_Activation_Summary__c);
    }
}
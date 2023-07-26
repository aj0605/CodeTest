public  class activateAccountClass {
    @AuraEnabled
    public static void activateAccountwWithSummary(String recordId,String accountSummary){
        List<Account> accList = [Select id,Account_Activation_Summary__c,Active__c from Account where Id=: recordId Limit 1];
        if(accList.size()>0){
            for(Account acc: accList){
                acc.Active__c = true;
                acc.Account_Activation_Summary__c = accountSummary;
            }
            update accList;
        }
    }
}
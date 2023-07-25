public class EmailAlertOnDeleteAccountHandler {
    public static void sendEmail(List<Account> deletedAccounts) {
        //Set of deleted Account Id
        set<id> accountOwnerid = new set<id>();
        for (Account deletedAcct : deletedAccounts) {
        	accountOwnerid.add(deletedAcct.OwnerId);
    	}
        
        //get user's record which is delete Account's Record
        User userlist=[select id,Name,Username,email from user where id=:deletedAccounts[0].OwnerId];
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        //List of String create for email for sent alert email
        list<string> emailAdds = new list<string>();
          
        try{
			if(userlist != null){
            	for (Account acct : deletedAccounts) {
					accountOwnerid.add(acct.id);
                	emailAdds.add(userlist.email);
                	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                	email.setToAddresses(emailAdds);
                	email.setSubject('Deleted Account Alert');
                	email.setPlainTextBody('This message is to alert you that the account named ' + acct.Name + ' has been deleted.');
                	emails.add(email);
            	}
            Messaging.sendEmail(emails);
            }
        }
        catch(Exception ex){
            system.debug('Error Occur ==> ' +ex.getmessage());
        }
    }
}
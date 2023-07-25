trigger EmailAlertOnDeleteAccount on Account (after delete) {
    if(Trigger.isAfter && Trigger.isDelete){
    	EmailAlertOnDeleteAccountHandler.sendEmail(Trigger.old);
    }
}
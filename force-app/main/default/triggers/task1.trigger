trigger task1 on Account (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isInsert){
        System.debug('Insert operation is performed on account');
    }
    if(trigger.isUpdate){
        System.debug('Update operation is performed on account');
    }
    if(trigger.isBefore){
        System.debug('isBefore operation is performed on account');
    }
    if(trigger.isDelete){
        System.debug('Delete operation is performed on account');
    }
    if(trigger.isAfter){
        System.debug('isAfter operation is performed on account');
    }
    if(trigger.isUndelete){
        System.debug('Undelete operation is performed on account');
    }

}
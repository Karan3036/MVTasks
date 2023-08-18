trigger task1_rus on contact(after insert, after update, after delete, after undelete) {
    if (trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete)) {
        task1_rus_class.rollupContacts(trigger.new);
    }
    else if (trigger.isAfter && trigger.isDelete) {
        task1_rus_class.rollupContacts(trigger.old);
    }
}
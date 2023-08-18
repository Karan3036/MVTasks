trigger task13 on Contact (after insert) {
    list<Event> lstevent = new list<Event>();
for (Contact con : Trigger.new) {
        Event event = new Event();
        event.OwnerId = UserInfo.getUserId();
        event.WhoId = con.Id;
        event.Subject = 'Go Live';
        event.StartDateTime = system.today();
        event.EndDateTime = system.today()+7;
        lstevent.Add(event);       
    }
    System.debug(lstevent);
    insert lstevent;
    
}
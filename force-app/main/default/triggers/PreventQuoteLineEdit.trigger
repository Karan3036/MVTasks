trigger PreventQuoteLineEdit on buildertek__Quote_Item__c (before update) {
    Set<Id> quoteIds = new Set<Id>();
    for (buildertek__Quote_Item__c quoteLineItem : Trigger.new) {
        buildertek__Quote_Item__c oldQuoteLineItem = Trigger.oldMap.get(quoteLineItem.Id);
            quoteIds.add(quoteLineItem.buildertek__Quote__c);
    }
    System.debug('Quoteid-->'+ quoteIds);
    
    if (!quoteIds.isEmpty()) {
        Map<Id, buildertek__Quote__c> quotesMap = new Map<Id, buildertek__Quote__c>([
            SELECT Id, buildertek__Status__c
            FROM buildertek__Quote__c
            WHERE Id IN :quoteIds
        ]);
        
        for (buildertek__Quote_Item__c quoteLineItem : Trigger.new) {
            buildertek__Quote__c relatedQuote = quotesMap.get(quoteLineItem.buildertek__Quote__c);
            if (relatedQuote.buildertek__Status__c == 'Customer Accepted') {
                quoteLineItem.addError('The record cannot be edited as the Quote is in "Customer Accepted" status.');
            }
        }
    }
}
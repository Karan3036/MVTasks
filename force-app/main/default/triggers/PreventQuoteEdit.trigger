trigger PreventQuoteEdit on buildertek__Quote__c (before update) {
    for (buildertek__Quote__c quote : Trigger.new) {
        buildertek__Quote__c oldQuote = Trigger.oldMap.get(quote.Id);
        
        // Check if the status changed to "Customer Approved" and Quote is being updated
        if (oldQuote.buildertek__Status__c == 'Customer Accepted') {
            // Prevent any Quote updates
            quote.addError('The record cannot be edited as the Quote is in "Customer Accepted" status.');
        }
    }
}
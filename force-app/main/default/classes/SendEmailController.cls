public with sharing class SendEmailController {


    @AuraEnabled
    public static void sendEmailAction(String eTo, String eCc, String eBcc, String eSubject, String eBody, String eFrom, List<String> attach){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        System.debug('attach--'+attach);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setToAddresses(new List<String>{eTo});

        if(eCc != '' && eCc != null)
            mail.setCcAddresses(new List<String>{eCc});

        if(eBcc != '' && eBcc != null)
            mail.setBccAddresses(new List<String>{eBcc});

        mail.setSubject(eSubject);
        if(eFrom != null)
            mail.setInReplyTo(eFrom);

        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        /*for (ContentDocument a : [select Id, Title from ContentDocument where Id = :attach])
        {
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(a.Title);
            efa.setBody(a.Body);
            fileAttachments.add(efa);
        }*/
        mail.setEntityAttachments(attach);
        mail.setHtmlBody(eBody);
        mails.add(mail);
        System.debug('Email-->>'+mails);
        /*Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);

        if (results[0].success)
            System.debug('The email was sent successfully.');
        else
            System.debug('The email failed to send: ' + results[0].errors[0].message);*/
    }

    @AuraEnabled
    public static List<OrgWideEmailAddress> getOrgWideEmailAddress(){
        return [SELECT Id, Address, DisplayName from OrgWideEmailAddress];
    }
}
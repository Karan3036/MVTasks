public class DropboxController 
{
    @AuraEnabled
	public static void uploadFileByRecord(string recordId, String cvid)
    {   System.debug(cvid);
        
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE Id =: cvid];
        
        for(ContentVersion attach:versions)
        {
            try
            {
                string fileUrl=DropboxService.upload(attach);
                
            }
            catch(Exception ex)
            {
               System.debug('error');
               System.debug(ex.getMessage() + ':' + ex.getLineNumber());
               
            }
        }
        
    }
    @AuraEnabled
    public static void deletefilebyname(String filenametoDelete){
        System.debug(filenametoDelete);
        if (string.isNotBlank(filenametoDelete)) {
            DropboxService.Deletefile(filenametoDelete);
           }
    }
}
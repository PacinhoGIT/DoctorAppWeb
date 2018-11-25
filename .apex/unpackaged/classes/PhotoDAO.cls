/**
 * Created by patryk on 2018-11-20.
 */
@RestResource(urlMapping = '/Photo/*')
global class PhotoDAO {

	@HttpPost
	global static void addPhoto(String name, String content, String description) {
		RestRequest req = RestContext.request;
		String examID = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

		Photo__c p = new Photo__c();
		p.Name__c=name;
		p.Description__c=description;
		p.Source__c=content;
		p.Examination__c=examID;
		insert p;

	}

}
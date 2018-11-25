/**
 * Created by patryk on 2018-11-20.
 */
@RestResource(urlMapping = '/Examinations/*')
global class ExaminationDAO {

	@HttpGet
	global static List<Examination__c> selectExaminations() {
		RestRequest req = RestContext.request;
		String docID = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

		List<Examination__c> examinations = [Select Id,Name,Name__c,Description__c from Examination__c where Patient__c=:docID];
		return examinations;

	}

}
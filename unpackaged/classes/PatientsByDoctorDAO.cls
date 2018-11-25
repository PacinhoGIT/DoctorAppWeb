/**
 * Created by patryk on 2018-11-20.
 */
@RestResource(urlMapping = '/MyPatients/*')
global class PatientsByDoctorDAO {

	@HttpGet
	global static List<Patient__c> selectPatients() {
		RestRequest req = RestContext.request;
		String docID = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

		List<Patient__c> patients = [Select Id,Name,First_Name__c,Last_name__c,Password__c from Patient__c where Doctor__c=:docID];
		return patients;

	}

}
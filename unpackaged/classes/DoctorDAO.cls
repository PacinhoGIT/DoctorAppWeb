/**
 * Created by patryk on 2018-11-18.
 */
@RestResource(urlMapping = '/Doctor/*')
global class DoctorDAO {

	@HttpGet
	global static Doctor__c seledtDoctor() {
		RestRequest req = RestContext.request;
		String Login = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

		List<Doctor__c> doctor = [Select Name,First_Name__c,Last_name__c,Password__c from Doctor__c where Name=:Login];
		if(doctor.size()>0){
			return doctor.get(0);
		}
		return null;

	}

}
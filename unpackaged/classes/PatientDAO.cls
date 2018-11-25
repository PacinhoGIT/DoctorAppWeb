/**
 * Created by patryk on 2018-11-14.
 */

@RestResource(urlMapping='/Patient/*')
global class PatientDAO {

	@HttpPost
	global static Boolean addPatient(String firstName, String lastName){

		Patient__c p = new Patient__c();
		p.First_Name__c = firstName;
		p.Last_name__c = lastName;

		try{
			insert p;
		}
		catch (Exception ex){
			return false;
		}
		return true;
	}

	@HttpGet
	global static List<Patient__c> selectPatient(){
		RestRequest req = RestContext.request;
		String Id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

		if(Id.length()!=0){
			return [Select p.Id,p.First_Name__c,p.Last_name__c from Patient__c p where p.Id=:Id];
		}
		return [Select p.Id,p.First_Name__c,p.Last_name__c from Patient__c p ];
	}

	@HttpDelete
	global static boolean deletePatient(){
		RestRequest req = RestContext.request;
		String ID = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		try{
			delete [SELECT ID from Patient__c where Id=:ID];
		}catch (Exception ex){
			return false;
		}
		return true;
	}

	@HttpPut
	global static boolean updatePatient(String firstName, String lastName, String ID){
		try{
			Patient__c p = new Patient__c();
			p.First_Name__c=firstName;
			p.Last_name__c=lastName;
			p.Id=ID;
			upsert p;
		}catch (Exception ex){
			return false;
		}
		return true;
	}


}
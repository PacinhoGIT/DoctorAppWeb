/**
 * Created by patryk on 2018-11-16.
 */
public class HomeController {

	private String doctorId;
	public String selectedPatient{get;set;}

	private static final String DETAILS_PAGE = '/apex/PatientDetails';
	private static final String ADD_PATIENT = '/apex/AddPatientPage';

	public HomeController() {

		try {
			doctorId = ApexPages.currentPage().getParameters().get('id');
		} catch (Exception e) {
		}
	}


	public List<Patient__c> patients{
		get{
			return [Select Id,Name,First_Name__c,Last_name__c from Patient__c WHERE Doctor__r.Id=:doctorId];
		}
	}

	public PageReference details(){
		PageReference pageRef = new PageReference(DETAILS_PAGE);
		pageRef.setRedirect(true);
		System.debug(selectedPatient);
		pageRef.getParameters().put('id',selectedPatient);
		pageRef.getParameters().put('docId',doctorId);
		return pageRef;
	}

	public PageReference deletePatient(){
		try{
			Patient__c p = [Select Id,Doctor__c from Patient__c where Id=:selectedPatient];
			p.Doctor__c = null;
			update p;
		}
		catch (Exception ex){}
		return null;
	}

	public PageReference addPatient(){
		PageReference pageRef = new PageReference(ADD_PATIENT);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('docId',doctorId);
		return pageRef;
	}
}
/**
 * Created by patryk on 2018-11-17.
 */
public class AddPatientController {


	private static final String HOME_PAGE = '/apex/HomePage';
	private static final String DETAILS_PAGE = '/apex/PatientDetails';


	public Boolean success{
		get;set;
	}

	public Patient__c patient {
		get;set;
	}

	public String password{
		get;set;
	}

	public String password2{
		get;set;
	}

	private String doctorId;

	public AddPatientController() {
		patient = new Patient__c();
		try {
			doctorId = ApexPages.currentPage().getParameters().get('docId');
		} catch (Exception e) {
		}
	}

//
//	public PageReference back() {
//		PageReference pageRef = new PageReference(HOME_PAGE);
//		pageRef.setRedirect(true);
//		pageRef.getParameters().put('id', doctorId);
//		return pageRef;
//	}

	public PageReference save() {
		if (password.equals(password2) && password.length() > 6) {

			System.debug(patient);

			if (patient.First_Name__c.length() > 0 && patient.Last_name__c.length() > 0) {
				patient.Password__c = CryptoHandler.hashToSHA256(password);
				patient.Role__c = 'User';
				patient.Doctor__c = doctorId;
				insert patient;
			} else {
				success = false;
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First and Last Name cannot be empty !'));
			}
		} else {
			success = false;
			ApexPages.addMessage(
					new ApexPages.Message(ApexPages.Severity.ERROR, 'Password must be at least 6 characters !'));
		}

		System.debug(patient);

		PageReference pageRef = new PageReference(DETAILS_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', patient.Id);
		pageRef.getParameters().put('docId', doctorId);
		return pageRef;


	}


}
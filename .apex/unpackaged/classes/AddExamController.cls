/**
 * Created by patryk on 2018-11-17.
 */
public class AddExamController {

	private static final String DETAILS_PAGE = '/apex/PatientDetails';


	public Boolean success{
		get;set;
	}

	public Examination__c exam {
		get;set;
	}

	private String doctorId;
	private String patientId;

	public AddExamController() {
		exam = new Examination__c();
		try {
			doctorId = ApexPages.currentPage().getParameters().get('docId');
			patientId = ApexPages.currentPage().getParameters().get('id');
		} catch (Exception e) {
		}
	}

	public PageReference save() {

		exam.Patient__c = patientId;
		insert exam;


		PageReference pageRef = new PageReference(DETAILS_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', patientId);
		pageRef.getParameters().put('docId', doctorId);
		return pageRef;


	}
}
/**
 * Created by patryk on 2018-11-16.
 */
public class PatientDetailsController {

	private String patientId;
	private String doctorId;

	private static final String HOME_PAGE = '/apex/HomePage';
	private static final String ADD_EXAM_PAGE = '/apex/AddExamPage';
	private static final String SELF_PAFE = '/apex/PatientDetails';
	private static final String PHOTO_PAGE = '/apex/PhotosPage';

	public String selectedExam{get;set;}

	public Patient__c patient{
		get;
		set;
	}

	public Boolean edittEnable{
		get;set;
	}

	public List<Examination__c> exam{get{
		return [Select Name,Name__c,Description__c,CreatedDate from Examination__c where Patient__r.Id=:patientId];
	}}

	public PatientDetailsController() {

		try {
			patientId = ApexPages.currentPage().getParameters().get('id');
			doctorId = ApexPages.currentPage().getParameters().get('docId');
			edittEnable = false;
			patient = [Select Name,First_Name__c, Last_name__c from Patient__c where Id=:patientId].get(0);
		} catch (Exception e) {
		}
	}

	public PageReference updatePatient() {
		try {
			update patient;
		} catch (Exception e) {
		}
		PageReference pageRef = new PageReference(SELF_PAFE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('docId', doctorId);
		pageRef.getParameters().put('id', patientId);
		return pageRef;
	}

	public PageReference examPhotos(){
		PageReference pageRef = new PageReference(PHOTO_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', selectedExam);
		pageRef.getParameters().put('docId', doctorId);
		return pageRef;
	}

	public PageReference newExam(){
		PageReference pageRef = new PageReference(ADD_EXAM_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', patientId);
		pageRef.getParameters().put('docId', doctorId);
		return pageRef;
	}


	public PageReference back(){
		PageReference pageRef = new PageReference(HOME_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', doctorId);
		return pageRef;
	}

}
/**
 * Created by patryk on 2018-11-16.
 */
public class PhotosController {

	private static final String DETAILS_PAGE = '/apex/PatientDetails';
	private static final String PHOTO_PAGE = '/apex/ShowPhotoPage';

	public String examID;
	public String docId;

	public String selectedPhoto{
		get;set;
	}

	public List<Photo__c> photos{
		get{
			return [SELECT Id,Name,Name__c,Description__c,Source__c,CreatedDate from Photo__c where Examination__r.Id=:examID order by CreatedDate desc] ;
		}
	}
	public Examination__c exam{
		get{
			return [SELECT Patient__r.Id,Name from Examination__c where Id=:examID];
		}
	}

	public PhotosController() {
		try {
			examID = ApexPages.currentPage().getParameters().get('id');
			docId = ApexPages.currentPage().getParameters().get('docId');
		} catch (Exception e) {
		}
	}

	public PageReference show() {
		PageReference pageRef = new PageReference(PHOTO_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', selectedPhoto);
		return pageRef;
	}

	public PageReference back() {
		PageReference pageRef = new PageReference(DETAILS_PAGE);
		pageRef.setRedirect(true);
		pageRef.getParameters().put('id', exam.Patient__r.Id);
		pageRef.getParameters().put('docId', docId);
		return pageRef;
	}
}
/**
 * Created by patryk on 2018-11-16.
 */
public class ShowPhotoController {

	public Photo__c photo{
		get{
			return [SELECT Name__c, Source__c from Photo__c where Id=:photoId].get(0);
		}
		set;
	}



	public List<Comment__c> comments{
		get{
			return [SELECT CreatedDate,Text__c from Comment__c where Photo__c=:photoId Order BY CreatedDate desc];
		}
		set;
	}

	public String photoId;
	public String commText{get;set;}


	public ShowPhotoController() {
		try {
			photoId = ApexPages.currentPage().getParameters().get('id');

		} catch (Exception e) {
		}

	}

	public PageReference addComment(){
		Comment__c comm= new Comment__c();
		comm.Photo__c=photoId;
		comm.Id=null;
		comm.Text__c=commText;
		insert comm;
		commText='';
		return null;
	}
}
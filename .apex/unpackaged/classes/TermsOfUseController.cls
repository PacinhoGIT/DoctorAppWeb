/**
 * Created by patryk on 2017-10-16.
 */
public class TermsOfUseController {

	String retURL;
	String id;

	public TermsOfUseController(){

		try {
			retURL = ApexPages.currentPage().getParameters().get('retURL');
			id = ApexPages.currentPage().getParameters().get('id');
		}
		catch (Exception e){

		}
	}

	public PageReference back(){

		PageReference pageRef;

		if(retURL.contains('Home')){
		 	pageRef = new PageReference('/apex/Home');
			pageRef.getParameters().put('id',id);
		}
		else{
			pageRef = new PageReference('/apex/Login');
		}
		pageRef.setRedirect(true);
		return pageRef;

	}
}
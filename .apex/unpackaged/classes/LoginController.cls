/**
 * Created by patryk on 2018-11-15.
 */
public class LoginController {

	private static final String ID_PARAM = 'id';
	private static final String HOME_PAGE = '/apex/HomePage';
	private static final String REGISTER_PAGE = '/apex/RegisterPage';

	private static final String TRUES  = 'true';
	private static final String SUCCESSS  = 'succes';
	private static final String NAMEE  = 'Name';
	private static final String SUCCES_REGISTER  ='Register succesful !';
	private static final String YOUR_NAME  ='Your login : ';

	public LoginController(){

		try {
			String succesS = ApexPages.currentPage().getParameters().get(SUCCESSS);
			String name = ApexPages.currentPage().getParameters().get(NAMEE);
			if(succesS.equals(TRUES)){
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, SUCCES_REGISTER + YOUR_NAME + name));
				succes=true;
			}
		}catch(Exception e){}
	}

	public String login{
		get;set;
	}
	public String password{
		get;set;
	}

	public Boolean succes{
		get;set;
	}

	public PageReference register() {
		PageReference pageRef = new PageReference(REGISTER_PAGE);
		return pageRef;
	}

	public PageReference resetPassword() {
		return null;
	}

	public PageReference login() {

		try {
			Doctor__c doctor =
			[Select Id,First_Name__c,Last_name__c from Doctor__c WHERE Name=:login and Password__c=:CryptoHandler.hashToSHA256(
					password)];

			if (doctor != null) {
				PageReference pageRef = new PageReference(HOME_PAGE);
				pageRef.setRedirect(true);
				pageRef.getParameters().put(ID_PARAM, doctor.Id);
				return pageRef;

			} else {
				succes = false;
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Bad login or password'));
			}

		} catch (Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Bad login or password'));
			succes = false;
		}

		return null;
	}
}
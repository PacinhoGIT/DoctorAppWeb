/**
 * Created by patryk on 2018-11-15.
 */
public class RegisterController {

	private final static String LOGIN_PAGE = '/apex/LoginPage' ;
	private static final String SUCCESSS  = 'succes';
	private static final String NAMEE  = 'Name';
	private static final String TRUEE  = 'true';

	public String firstName{get;set;}
	public String lastName{get;set;}
	public String password{get;set;}
	public String password2{get;set;}

	public Boolean success{get;set;}
	public Boolean accept{get;set;}

	public PageReference register(){

		if(accept) {
			if (password.equals(password2) && password.length()>6) {

				if(firstName.length()>0 && lastName.length()>0 ) {
					String name = CreateUserHandler.createUser(firstName, lastName, password);
					if (name.length()>0) {

						success = true;
						return back(true,name);

					} else {
						return null;
					}
				}
				else{
					success=false;
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First and Last Name cannot be empty !'));
				}
			}
			else{
				success=false;
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Password must be at least 6 characters !'));
			}
		}
		else{
			success=false;
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must accept Terms of Use.'));

		}

		return null;
	}

	public PageReference back(){
		return back(false,'');
	}

	public PageReference back(Boolean param, String name){

		PageReference pageRef = new PageReference(LOGIN_PAGE);
		pageRef.setRedirect(true);
		if(param) {
			pageRef.getParameters().put(SUCCESSS, TRUEE);
			System.debug(name);
			pageRef.getParameters().put(NAMEE, name);
		}
		return pageRef;

	}

	public PageReference termsOfUse(){

		PageReference pageRef = new PageReference('/apex/TermsofUse');
		pageRef.getParameters().put('retURL','Register');
		pageRef.setRedirect(true);
		return pageRef;

	}
}
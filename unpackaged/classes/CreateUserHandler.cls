/**
 * Created by patryk on 2018-11-15.
 */
public class CreateUserHandler {

	public static String createUser(String fn, String ln, String password) {
		System.debug(fn);
		System.debug(ln);
		System.debug(password);
		Doctor__c doc = new Doctor__c();
		doc.First_Name__c = fn;
		doc.Last_name__c = ln;
		doc.Password__c = CryptoHandler.hashToSHA256(password);
		doc.Role__c = 'Admin';
		try {
			insert doc;

			String name = [Select Name from Doctor__c where Id=:doc.Id].get(0).Name;
			System.debug(name);
			return name;
		} catch (Exception e) {
			return '';
		}

		return null;
	}
}
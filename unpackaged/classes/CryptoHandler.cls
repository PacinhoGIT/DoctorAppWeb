/**
 * Created by patryk on 2017-08-19.
 */
public class CryptoHandler {

	private static final String CRYPTO_ALGORITHM = 'SHA-256';

	public static String hashToSHA256(String input){
		Blob targetBlob = Blob.valueOf(input);
		Blob hash = Crypto.generateDigest(CRYPTO_ALGORITHM, targetBlob);
		String passHash = EncodingUtil.convertToHex(hash);
		return passHash;
	}
}
package utilitaires;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Check {
	
	private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
	private static final String PASSWORD_REGEX = "[A-Za-z0-9]+";
	
	public static boolean isValidEmail(String email) {
		 	Pattern pattern = Pattern.compile(EMAIL_REGEX);
	        Matcher matcher = pattern.matcher(email);
	        return matcher.matches();
	}
	

	public static boolean isValidPassword(String password) {
	        Pattern pattern = Pattern.compile(PASSWORD_REGEX);
	        Matcher matcher = pattern.matcher(password);
	        return matcher.matches();
	}

}

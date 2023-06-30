package utilitaires;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
	public static void main(String[] argv) {
		String d1 = "2023-06-15";
        String d2 = "2023-06-25";

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date1 = LocalDate.parse(d1, formatter);
        LocalDate date2 = LocalDate.parse(d2, formatter);

        if (date1.isAfter(date2) || date1.isEqual(date2)) {
            System.out.println("d1 est supérieure ou égale à d2");
        } else {
            System.out.println("d1 est inférieure à d2");
        }
	}
}

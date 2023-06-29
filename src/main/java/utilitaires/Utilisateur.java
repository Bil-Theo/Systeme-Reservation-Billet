package utilitaires;

public class Utilisateur {
	public String _id, nom, prenom, email, password, type;
	
	public Utilisateur(String id, String nom, String prenom, String email, String password, String type) {
		this._id = id;
		this.nom =  nom;
		this.prenom = prenom;
		this.email = email;
		this.password =  password;
		this.type = type;
	}
}

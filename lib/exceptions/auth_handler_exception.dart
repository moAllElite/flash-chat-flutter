import 'package:firebase_auth/firebase_auth.dart';
enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  userNotFound,
  unknown,
}
class AuthHandlerException{
  static handleAuthException(FirebaseAuthException e){
    AuthStatus status;
    switch(e.code){
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      case "user-not-found":
        status = AuthStatus.userNotFound;

      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Erreur de format de votre email .";
        break;
      case AuthStatus.weakPassword:
        errorMessage = 'Le mot de passe doit être au moins  de 6 charactères.';
        break;
      case AuthStatus.wrongPassword:
        errorMessage = 'Le Mot de passe saisi est incorrect.';
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage = 'L\'utilisateur avec l\'email saisi est déjà attribué à un utilisateur.';
        break;
      case AuthStatus.userNotFound:
        errorMessage = 'L\'utilisateur avec l\'email fourni est introuvable ';
        break;
      default:
        errorMessage = "Une erreur est survenue. Merci d'essayer plus tard!.";
    }
    return errorMessage;
  }

}
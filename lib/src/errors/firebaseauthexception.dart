// we can crete
class SignUpWithEmailAndPasswordFailure {
  final String message;
  const SignUpWithEmailAndPasswordFailure([
    this.message = "An Unknown error occurred",
  ]);
  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "invalid-email":
        return const SignUpWithEmailAndPasswordFailure(
          "Your email address appears to be malformed.",
        );
      case "wrong-password":
        return const SignUpWithEmailAndPasswordFailure(
          "Your password is wrong.",
        );
      case "user-not-found":
        return const SignUpWithEmailAndPasswordFailure(
          "User with this email doesn't exist.",
        );
      case "user-disabled":
        return const SignUpWithEmailAndPasswordFailure(
          "User with this email has been disabled.",
        );
      case "too-many-requests":
        return const SignUpWithEmailAndPasswordFailure(
          "Too many requests",
        );
      case "operation-not-allowed":
        return const SignUpWithEmailAndPasswordFailure(
          "Signing in with Email and Password is not enabled.",
        );
      default:
        return const SignUpWithEmailAndPasswordFailure(
          "An undefined Error happened.",
        );
    }
  }
}

class LoginWithEmailAndPasswordFailure {
  final String message;
  const LoginWithEmailAndPasswordFailure([
    this.message = "An Unknown error occurred",
  ]);
  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "invalid-email":
        return const LoginWithEmailAndPasswordFailure(
          "Your email address appears to be malformed.",
        );
      case "wrong-password":
        return const LoginWithEmailAndPasswordFailure(
          "Your password is wrong.",
        );
      case "user-not-found":
        return const LoginWithEmailAndPasswordFailure(
          "User with this email doesn't exist.",
        );
      case "user-disabled":
        return const LoginWithEmailAndPasswordFailure(
          "User with this email has been disabled.",
        );
      case "too-many-requests":
        return const LoginWithEmailAndPasswordFailure(
          "Too many requests",
        );
      case "operation-not-allowed":
        return const LoginWithEmailAndPasswordFailure(
          "Signing in with Email and Password is not enabled.",
        );
      default:
        return const LoginWithEmailAndPasswordFailure(
          "An undefined Error happened.",
        );
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class AppException with _$AppException {
  const factory AppException.emailAlreadyInUse() = EmailAlreadyInUse;

  const factory AppException.weakPassword() = WeakPassword;

  const factory AppException.wrongPassword() = WrongPassword;

  const factory AppException.userNotFound() = UserNotFound;

  const factory AppException.cartSync() = CartSync;

  const factory AppException.paymentFailureEmptyCart() =
      PaymentFailureEmptyCart;

  const factory AppException.parseOrder() = ParseOrder;

  const factory AppException.aborted() = Aborted;

  const factory AppException.alreadyExists() = AlreadyExists;

  const factory AppException.cancelled() = Cancelled;

  const factory AppException.dataLoss() = DataLoss;

  const factory AppException.deadlineExceeded() = DeadlineExceeded;

  const factory AppException.failedPrecondition() = Precondition;

  const factory AppException.internal() = Internal;

  const factory AppException.invalidArgument() = InvalidArgument;

  const factory AppException.notFound() = NotFound;

  const factory AppException.ok() = Ok;

  const factory AppException.outOfRange() = OutOfRange;

  const factory AppException.permissionDenied() = PermissionDenied;

  const factory AppException.resourceExhausted() = ResourceExhausted;

  const factory AppException.unauthenticated() = Unauthenticated;

  const factory AppException.unavailable() = Unavailable;

  const factory AppException.unimplemented() = Unimplemented;

  const factory AppException.unknown(String reason) = Unknown;

  const factory AppException.noInternet() = NoInternet;

  const factory AppException.timeOut() = TimeOut;

  const factory AppException.invalidEmail() = InvalidEmail;

  const factory AppException.userDisabled() = UserDisabled;

  const factory AppException.tooManyRequests() = TooManyRequests;

  const factory AppException.operationNotAllowed() = OperationNotAllowed;

  const factory AppException.emailAlreadyExists() = EmailAlreadyExists;

  const factory AppException.networkRequestFailed() = NetworkRequestFailed;

  const factory AppException.iap(String reason) = IAPFailed;
//Stripe

// const factory AppException.refusedPayment() = RefusedPayment;
}

class AppExceptionData {
  final String code;
  final String message;

  AppExceptionData({required this.code, required this.message});

  @override
  String toString() {
    return 'AppExceptionData{code: $code, message: $message}';
  }
}

extension AppExceptionDetails on AppException {
  AppExceptionData get details {
    return when(
      // Auth
      emailAlreadyInUse: () => AppExceptionData(
        code: 'email-already-in-use',
        message: 'Email already in use',
      ),
      weakPassword: () => AppExceptionData(
        code: 'weak-password',
        message: 'Password is too weak',
      ),
      wrongPassword: () => AppExceptionData(
        code: 'wrong-password',
        message: 'Wrong password',
      ),
      userNotFound: () => AppExceptionData(
        code: 'user-not-found',
        message: 'User not found',
      ),
      // Orders
      parseOrder: () => AppExceptionData(
        code: 'parse-order-failure',
        message: 'Could not parse order status: todo',
      ),
      paymentFailureEmptyCart: () => AppExceptionData(
        code: 'payment-failure-empty-cart',
        message: 'Can not place an order if the cart is empty',
      ),
      cartSync: () => AppExceptionData(
        code: 'parse-order-failure',
        message: 'Could not parse order status',
      ),

      aborted: () => AppExceptionData(
          code: "aborted",
          message:
              "The operation was aborted, typically due to a concurrency issue like transaction aborts, etc."
                  ),
      alreadyExists: () => AppExceptionData(
          code: "alreadyExists",
          message: "Some document that we attempted to create already exists."
              ),
      cancelled: () => AppExceptionData(
          code: "cancelled",
          message: "The operation was cancelled (typically by the caller)."
              ),
      dataLoss: () => AppExceptionData(
          code: "dataLoss",
          message: "Unrecoverable data loss or corruption."),
      deadlineExceeded: () => AppExceptionData(
          code: "deadlineExceeded",
          message:
              "Deadline expired before operation could complete."),
      failedPrecondition: () => AppExceptionData(
          code: "failedPrecondition",
          message:
              "Operation was rejected because the system is not in a state required for the operation's execution."
                  ),
      internal: () => AppExceptionData(
          code: "internal", message: "Internal errors."),
      invalidArgument: () => AppExceptionData(
          code: "invalidArgument",
          message: "Client specified an invalid argument."),
      notFound: () => AppExceptionData(
          code: "notFound",
          message: "Some requested document was not found."),
      ok: () => AppExceptionData(
          code: "ok",
          message: "The operation completed successfully."),
      outOfRange: () => AppExceptionData(
          code: "outOfRange",
          message: "Operation was attempted past the valid range."),
      permissionDenied: () => AppExceptionData(
          code: "permissionDenied",
          message:
              "The caller does not have permission to execute the specified operation."
                  ),
      resourceExhausted: () => AppExceptionData(
          code: "resourceExhausted",
          message:
              "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space."
                  ),
      unauthenticated: () => AppExceptionData(
          code: "unauthenticated",
          message:
              "The request does not have valid authentication credentials for the operation."
                  ),
      unavailable: () => AppExceptionData(
          code: "unavailable",
          message: "The service is currently unavailable."),
      unimplemented: () => AppExceptionData(
          code: "unimplemented",
          message: "Operation is not implemented or not supported/enabled."
              ),
      unknown: (reason) => AppExceptionData(
          code: "unknown",
          message: reason.isNotEmpty? reason:"Unknown error or an error from a different error domain."
              ),
      noInternet: () => AppExceptionData(
          code: "noInternet", message: "No internet connection"),
      timeOut: () =>
          AppExceptionData(code: "timeOut", message: "Timeout..."),
      invalidEmail: () => AppExceptionData(
          code: "invalid-email",
          message: "Your email address appears to be incorrect."),
      emailAlreadyExists: () => AppExceptionData(
          code: "email-already-exists",
          message: "The email is already being used."),
      networkRequestFailed: () => AppExceptionData(
          code: "network-request-failed",
          message: "La connexion internet est interrompu."),
      operationNotAllowed: () => AppExceptionData(
          code: "operation-not-allowed",
          message:
              "Signing in with Email and Password is not enabled."),
      tooManyRequests: () => AppExceptionData(
          code: "too-many-requests", message: "Too many requests"),
      userDisabled: () => AppExceptionData(
          code: "user-disabled",
          message: "User with this email has been disabled."),
      iap: (reason) => AppExceptionData(
          code: "iap-failed", message: "IAP failed: $reason"),
    );
  }
}

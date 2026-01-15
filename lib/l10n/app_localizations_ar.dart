// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get home => 'الصفحة الرئيسية';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get thisEmailIsNotValid => 'هذا البريد الإلكتروني غير صالح';

  @override
  String get userName => 'اسم المستخدم';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get alreadyHaveAnAccount => 'لديك حساب بالفعل؟';

  @override
  String get userNameIsNotValid => 'اسم المستخدم غير صالح';

  @override
  String get enterYourUserName => 'أدخل اسم المستخدم';

  @override
  String get enterYourFirstName => 'أدخل اسمك الأول';

  @override
  String get enterYourLastName => 'أدخل اسم العائلة';

  @override
  String get passwordNotMatched => 'كلمات المرور غير متطابقة';

  @override
  String get passwordMinLength =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get passwordUpperCase =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordLowerCase =>
      'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';

  @override
  String get passwordNumber =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordSpecialChar =>
      'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get userNameRequired => 'اسم المستخدم مطلوب';

  @override
  String get phoneNumberRequired => 'رقم الهاتف مطلوب';

  @override
  String get firstNameRequired => 'الاسم الأول مطلوب';

  @override
  String get lastNameRequired => 'اسم العائلة مطلوب';

  @override
  String get rememberMe => 'تذكرني';
}

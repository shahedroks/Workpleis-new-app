import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/screens/checking_liveness.dart';
import 'package:workpleis/features/auth/screens/confirm_document_type_scanner.dart';
import 'package:workpleis/features/auth/screens/confirm_face_photo_screen.dart';
import 'package:workpleis/features/auth/screens/forget_password_screen.dart';
import 'package:workpleis/features/auth/screens/forget_verification_code_screen.dart';
import 'package:workpleis/features/auth/screens/get_ready_video_selfie_screen.dart';
// Auth
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';
import 'package:workpleis/features/auth/screens/new_password_screen.dart';
import 'package:workpleis/features/auth/screens/phone_number_verification.dart';
import 'package:workpleis/features/auth/screens/take_your_face_photo.dart';
import 'package:workpleis/features/auth/screens/veryfiy_your_business.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen1.dart';
// Onboarding
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_05.dart';
// Role / Type / Notifications
import 'package:workpleis/features/role_screen/screen/genNotifications.dart';
import 'package:workpleis/features/role_screen/screen/seclect_role_screen.dart';
import 'package:workpleis/features/role_screen/screen/seclect_type_screen.dart';
// Splash
import 'package:workpleis/features/spalashScreen/screen/splashScreen.dart';
// Client
import 'package:workpleis/features/client/screen/client_home_screen.dart';
import '../features/auth/screens/confrim_document_type_screen.dart';
import '../features/auth/screens/frontIdentityCaptureScreen.dart';
import '../features/auth/screens/select_document_screen.dart';
import '../features/nav_bar/screen/bottom_nav_bar.dart';
import 'error_screen.dart';

class AppRouter {
  // initial route
  static const String initial = SplashScreen.routeName;

  static final GoRouter appRouter = GoRouter(
    initialLocation: initial,

    errorBuilder: (context, state) {
      final String badPath = state.uri.toString();
      return CustomGoErrorPage(
        location: badPath,
        error: state.error,
        onRetry: () => context.go(initial),
        onReport: () {
          GlobalSnackBar.show(
            context,
            title: "We're sorry",
            message: "Thanks, we'll look into this.",
          );
        },
      );
    },

    routes: <RouteBase>[
      // 🔹 Splash
      GoRoute(
        path: SplashScreen.routeName,
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),

      // 🔹 Onboarding
      GoRoute(
        path: OnboardingScreen01.routeName,
        name: OnboardingScreen01.routeName,
        builder: (context, state) => const OnboardingScreen01(),
      ),
      GoRoute(
        path: OnboardingScreen05.routeName,
        name: OnboardingScreen05.routeName,
        builder: (context, state) => OnboardingScreen05(),
      ),

      // 🔹 Auth
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.routeName,
        name: RegisterScreen.routeName,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AccountSuccessful.routeName,
        name: AccountSuccessful.routeName,
        builder: (context, state) => AccountSuccessful(),
      ),

      GoRoute(
        path: Frontidentitycapturescreen.routeName,
        name: Frontidentitycapturescreen.routeName,
        builder: (context, state) => const Frontidentitycapturescreen(),
      ),
      GoRoute(
        path: PhoneNumberVerification.routeName,
        name: PhoneNumberVerification.routeName,
        builder: (context, state) {
          final isFromForgot = (state.extra as bool?) ?? false;
          return PhoneNumberVerification(isFromForgotPassword: isFromForgot);
        },
      ),
      GoRoute(
        path: NewPasswordScreen.routeName,
        name: NewPasswordScreen.routeName,
        builder: (context, state) => const NewPasswordScreen(),
      ),

      GoRoute(
        path: ForgetPasswordScreen.routeName,
        name: ForgetPasswordScreen.routeName,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: ForgetVerificationCodeScreen.routeName,
        name: ForgetVerificationCodeScreen.routeName,
        builder: (context, state) => const ForgetVerificationCodeScreen(),
      ),
      GoRoute(
        path: SelectDocumentScreen.routeName,
        name: SelectDocumentScreen.routeName,
        builder: (context, state) => const SelectDocumentScreen(),
      ),

      GoRoute(
        path: ConfirmDocumentTypeScreen.routeName,
        name: ConfirmDocumentTypeScreen.routeName,
        builder: (context, state) => ConfirmDocumentTypeScreen(),
      ),

      GoRoute(
        path: GetReadyVideoSelfieScreen.routeName,
        name: GetReadyVideoSelfieScreen.routeName,
        builder: (context, state) => GetReadyVideoSelfieScreen(),
      ),

      GoRoute(
        path: ConfirmDocumentTypeScanner.routeName,
        name: ConfirmDocumentTypeScanner.routeName,
        builder: (context, state) => ConfirmDocumentTypeScanner(),
      ),
      GoRoute(
        path: TakeYourFacePhoto.routeName,
        name: TakeYourFacePhoto.routeName,
        builder: (context, state) => TakeYourFacePhoto(),
      ),

      GoRoute(
        path: ConfirmFacePhotoScreen.routeName,
        name: ConfirmFacePhotoScreen.routeName,
        builder: (context, state) => ConfirmFacePhotoScreen(),
      ),



      GoRoute(
        path: VideoSelfieReadyScreen.routeName,
        name: VideoSelfieReadyScreen.routeName,
        builder: (context, state) => VideoSelfieReadyScreen(),
      ),

      GoRoute(
        path: VideoSelfieReadyScreen1.routeName,
        name: VideoSelfieReadyScreen1.routeName,
        builder: (context, state) => VideoSelfieReadyScreen1(),
      ),
      // 🔹 Role / Type / Notification
      GoRoute(
        path: SeclectRoleScreen.routeName,
        name: SeclectRoleScreen.routeName,
        builder: (context, state) => SeclectRoleScreen(),
      ),

      GoRoute(
        path: CheckingLiveness.routeName,
        name: CheckingLiveness.routeName,
        builder: (context, state) =>  CheckingLiveness(),
      ),

      GoRoute(
        path: VeryfiyYourBusiness.routeName,
        name: VeryfiyYourBusiness.routeName,
        builder: (context, state) => VeryfiyYourBusiness(),
      ),

      GoRoute(
        path: SeclectTypeScreen.routeName,
        name: SeclectTypeScreen.routeName,
        builder: (context, state) => SeclectTypeScreen(),
      ),

      GoRoute(
        path: Gennotifications.routeName,
        name: Gennotifications.routeName,
        builder: (context, state) => Gennotifications(),
      ),

      GoRoute(
        path: BottomNavBar.routeName,
        name: BottomNavBar.routeName,
        builder: (context, state) => BottomNavBar(),
      ),

      // 🔹 Client Home
      GoRoute(
        path: ClientHomeScreen.routeName,
        name: ClientHomeScreen.routeName,
        builder: (context, state) => ClientHomeScreen(),
      ),
    ],
  );
}

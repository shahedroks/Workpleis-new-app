import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/screens/account_successful.dart';
import 'package:workpleis/features/auth/screens/business_login_screen.dart';
import 'package:workpleis/features/auth/screens/checking_liveness.dart';
import 'package:workpleis/features/auth/screens/confirm_document_type_scanner.dart';
import 'package:workpleis/features/auth/screens/confirm_face_photo_screen.dart';
import 'package:workpleis/features/auth/screens/confrim_document_type_screen.dart';
import 'package:workpleis/features/auth/screens/forget_password_screen.dart';
import 'package:workpleis/features/auth/screens/forget_verification_code_screen.dart';
import 'package:workpleis/features/auth/screens/frontIdentityCaptureScreen.dart';
import 'package:workpleis/features/auth/screens/get_ready_video_selfie_screen.dart';
// Auth
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/screens/new_password_screen.dart';
import 'package:workpleis/features/auth/screens/phone_number_verification.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/auth/screens/select_document_screen.dart';
import 'package:workpleis/features/auth/screens/service_provider_verify_business.dart';
import 'package:workpleis/features/auth/screens/take_your_face_photo.dart';
import 'package:workpleis/features/auth/screens/veryfiy_your_business.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen.dart';
import 'package:workpleis/features/auth/screens/video_selfie_ready_screen1.dart';
// Client
import 'package:workpleis/features/client/screen/client_home_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/jobs.dart';
import 'package:workpleis/features/client/Jobs/screen/postJob_wizard_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/send_report_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/request_refund_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/job_completed_success_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/job_details_screen.dart';
import 'package:workpleis/features/client/Jobs/model/flow_type.dart';
import 'package:workpleis/features/client/Jobs/screen/proposal_details_screen.dart';
import 'package:workpleis/features/client/Jobs/screen/account_add_screen.dart';
import 'package:workpleis/features/nav_bar/screen/bottom_nav_bar.dart';
import 'package:workpleis/features/nav_bar/screen/service_bottom_nav_bar.dart';
import 'package:workpleis/features/notifications/create_new_project_flow.dart';
import 'package:workpleis/features/notifications/screen/notifications_screen.dart';
// Onboarding
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_05.dart';
// Role / Type / Notifications
import 'package:workpleis/features/role_screen/screen/genNotifications.dart';
import 'package:workpleis/features/role_screen/screen/seclect_role_screen.dart';
import 'package:workpleis/features/role_screen/screen/seclect_type_screen.dart';
import 'package:workpleis/features/service/screen/get_paid_now_screen.dart';
import 'package:workpleis/features/service/screen/service_home_screen.dart';
import 'package:workpleis/features/service/screen/set_up_withdrawals_screen.dart';
// Splash
import 'package:workpleis/features/spalashScreen/screen/splashScreen.dart';

import '../features/client/Jobs/model/project_model.dart';
import '../features/client/message/screen/messages_screen.dart';
import '../features/client/profile/screen/profile_screen.dart';
import '../features/client/project/screen/project_screen.dart';
import '../features/notifications/screen/referral_screen.dart';
import 'error_screen.dart';

class AppRouter {
  // initial route
  //static const String initial = ClientHomeScreen.routeName;
  static final String initial = SplashScreen.routeName;
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
      GoRoute(
        path: ReferralScreen.routeName,
        name: ReferralScreen.routeName,
        builder: (context, state) =>  ReferralScreen(),
      ),
       GoRoute(
        path: CreateNewProjectFlow.routeName,
        name: CreateNewProjectFlow.routeName,
        builder: (context, state) =>  CreateNewProjectFlow(),
      ),
        GoRoute(
        path: ServiceHomeScreen.routeName,
        name: ServiceHomeScreen.routeName,
        builder: (context, state) =>  ServiceHomeScreen(),
      ),
      GoRoute(
        path: GetPaidNowScreen.routeName,
        name: GetPaidNowScreen.routeName,
        builder: (context, state) => const GetPaidNowScreen(),
      ),
      GoRoute(
        path: SetUpWithdrawalsScreen.routeName,
        name: SetUpWithdrawalsScreen.routeName,
        builder: (context, state) => const SetUpWithdrawalsScreen(),
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
        builder: (context, state) => const OnboardingScreen05(),
      ),
      GoRoute(
        path: PostJobWizardScreen.routeName,
        name: PostJobWizardScreen.routeName,
        builder: (context, state) => const PostJobWizardScreen(),
      ),

      // 🔹 Auth
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final isBusiness = (extras?['isBusiness'] as bool?) ?? false;
          return LoginScreen(isBusinessFlow: isBusiness);
        },
      ),
      GoRoute(
        path: RegisterScreen.routeName,
        name: RegisterScreen.routeName,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final isBusiness = (extras?['isBusiness'] as bool?) ?? false;
          return RegisterScreen(isBusinessFlow: isBusiness);
        },
      ),
      GoRoute(
        path: AccountSuccessful.routeName,
        name: AccountSuccessful.routeName,
        builder: (context, state) => const AccountSuccessful(),
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
          final extras = state.extra as Map<String, dynamic>?;
          final isFromForgot = (extras?['isFromForgot'] as bool?) ?? false;
          final isBusiness = (extras?['isBusiness'] as bool?) ?? false;
          return PhoneNumberVerification(
            isFromForgotPassword: isFromForgot,
            isBusinessFlow: isBusiness,
          );
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
        builder: (context, state) => const ConfirmDocumentTypeScreen(),
      ),

      GoRoute(
        path: BusinessLoginScreen.routeName,
        name: BusinessLoginScreen.routeName,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final isBusiness = (extras?['isBusiness'] as bool?) ?? true;
          return BusinessLoginScreen(isBusinessFlow: isBusiness);
        },
      ),

      GoRoute(
        path: GetReadyVideoSelfieScreen.routeName,
        name: GetReadyVideoSelfieScreen.routeName,
        builder: (context, state) => const GetReadyVideoSelfieScreen(),
      ),

      GoRoute(
        path: ConfirmDocumentTypeScanner.routeName,
        name: ConfirmDocumentTypeScanner.routeName,
        builder: (context, state) => const ConfirmDocumentTypeScanner(),
      ),
      GoRoute(
        path: TakeYourFacePhoto.routeName,
        name: TakeYourFacePhoto.routeName,
        builder: (context, state) => const TakeYourFacePhoto(),
      ),

      GoRoute(
        path: ConfirmFacePhotoScreen.routeName,
        name: ConfirmFacePhotoScreen.routeName,
        builder: (context, state) => const ConfirmFacePhotoScreen(),
      ),

      GoRoute(
        path: VideoSelfieReadyScreen.routeName,
        name: VideoSelfieReadyScreen.routeName,
        builder: (context, state) => const VideoSelfieReadyScreen(),
      ),

      GoRoute(
        path: VideoSelfieReadyScreen1.routeName,
        name: VideoSelfieReadyScreen1.routeName,
        builder: (context, state) => const VideoSelfieReadyScreen1(),
      ),
      // 🔹 Role / Type / Notification
      GoRoute(
        path: SeclectRoleScreen.routeName,
        name: SeclectRoleScreen.routeName,
        builder: (context, state) => const SeclectRoleScreen(),
      ),

      GoRoute(
        path: CheckingLiveness.routeName,
        name: CheckingLiveness.routeName,
        builder: (context, state) => const CheckingLiveness(),
      ),

      GoRoute(
        path: VeryfiyYourBusiness.routeName,
        name: VeryfiyYourBusiness.routeName,
        builder: (context, state) => const VeryfiyYourBusiness(),
      ),

      GoRoute(
        path: ServiceProviderVerifyBusiness.routeName,
        name: ServiceProviderVerifyBusiness.routeName,
        builder: (context, state) => const ServiceProviderVerifyBusiness(),
      ),
      GoRoute(
        path: SeclectTypeScreen.routeName,
        name: SeclectTypeScreen.routeName,
        builder: (context, state) => const SeclectTypeScreen(),
      ),

      GoRoute(
        path: Gennotifications.routeName,
        name: Gennotifications.routeName,
        builder: (context, state) => const Gennotifications(),
      ),
      GoRoute(
        path: NotificationsScreen.routeName,
        name: NotificationsScreen.routeName,
        builder: (context, state) => const NotificationsScreen(),
      ),

      GoRoute(
        path: BottomNavBar.routeName,
        name: BottomNavBar.routeName,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        path: ServiceBottomNavBar.routeName,
        name: ServiceBottomNavBar.routeName,
        builder: (context, state) => const ServiceBottomNavBar(),
      ),

      // 🔹 Client Home
      GoRoute(
        path: ClientHomeScreen.routeName,
        name: ClientHomeScreen.routeName,
        builder: (context, state) => const ClientHomeScreen(),
      ),

      // 🔹 Client Projects/Jobs (Unified flow)
      GoRoute(
        path: ClientProjectsScreen.routeName,
        name: ClientProjectsScreen.routeName,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final flowType = extras?['flowType'] as FlowType? ?? FlowType.project;
          return ClientProjectsScreen(flowType: flowType);
        },
      ),
      GoRoute(
        path: ProjectDetailsScreen.routeName,
        name: ProjectDetailsScreen.routeName,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final project = extras?['project'] as ProjectModel?;
          final flowType = extras?['flowType'] as FlowType? ?? FlowType.project;
          return ProjectDetailsScreen(project: project, flowType: flowType);
        },
      ),
      GoRoute(
        path: ProposalDetailsScreen.routeName,
        name: ProposalDetailsScreen.routeName,
        builder: (context, state) => ProposalDetailsScreen(proposal: state.extra as dynamic),
      ),
      GoRoute(
        path: AccountAddScreen.routeName,
        name: AccountAddScreen.routeName,
        builder: (context, state) => const AccountAddScreen(),
      ),
      GoRoute(
        path: SendReportScreen.routeName,
        name: SendReportScreen.routeName,
        builder: (context, state) => const SendReportScreen(),
      ),
      GoRoute(
        path: RequestRefundScreen.routeName,
        name: RequestRefundScreen.routeName,
        builder: (context, state) => const RequestRefundScreen(),
      ),

      // 🔹 Project Completed Success
      GoRoute(
        path: ProjectCompletedSuccessScreen.routeName,
        name: ProjectCompletedSuccessScreen.routeName,
        builder: (context, state) => const ProjectCompletedSuccessScreen(),
      ),

      // 🔹 Project
      GoRoute(
        path: ProjectScreen.routeName,
        name: ProjectScreen.routeName,
        builder: (context, state) => const ProjectScreen(),
      ),

      // 🔹 Message
      GoRoute(
        path: MessageScreen.routeName,
        name: MessageScreen.routeName,
        builder: (context, state) => const MessageScreen(),
      ),

      // 🔹 Profile
      GoRoute(
        path: ProfileScreen.routeName,
        name: ProfileScreen.routeName,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
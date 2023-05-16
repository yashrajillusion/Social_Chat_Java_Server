import 'package:chat_app/infrastructure/providers/home_provider/home_provider.dart';
import 'package:chat_app/infrastructure/providers/onboarding_provider/onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider(ref));
final onboardingProvider = ChangeNotifierProvider<OnboardingProvider>((ref) => OnboardingProvider(ref));

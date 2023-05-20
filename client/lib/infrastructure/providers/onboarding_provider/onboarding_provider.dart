import 'dart:developer';

import 'package:chat_app/infrastructure/data_access_layer/networks/api_response.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/repositories/account_repository.dart';
import 'package:chat_app/infrastructure/models/request/create_account_request_modal.dart';
import 'package:chat_app/infrastructure/models/request/login_account_request_modal.dart';
import 'package:chat_app/infrastructure/models/response/common_error_response_model.dart';
import 'package:chat_app/infrastructure/models/response/create_account_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users_by_id_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/login_account_response_modal.dart';
import 'package:chat_app/ui/common/custom_loading/custom_loading.dart';
import 'package:chat_app/ui/screens/home_screens/home_chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class OnboardingProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<OnboardingProvider> ref;
  OnboardingProvider(this.ref);
  final AccountRepository _accountRepository = AccountRepository();
  List<GetAllUsersDataList>? allUsersDataList;
  bool isLogin = true;
  String chatId = '';

  setIsLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }

  Future createAccount({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    CustomLoading.progressDialog(isLoading: true, context: context);
    CreateAccountrequestmodal createAccountrequestmodal = CreateAccountrequestmodal(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
    );
    ApiHttpResult response = await _accountRepository.createAccount(createAccountrequestmodal.prepareRequest());

    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is CreateAccountResponsemodal) {
          CustomLoading.progressDialog(isLoading: false, context: context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeChatsScreen()));
        }
        break;
      case APIStatus.ERROR:
        CustomLoading.progressDialog(isLoading: false, context: context);
        Logger().d("Api fail on confirm code ");
        // CommonErrorResponseModel signUpErrorResponseModel = CommonErrorResponseModel.fromJson(response.data);
        notifyListeners();
        break;
    }
  }

  Future loginAccount({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    CustomLoading.progressDialog(isLoading: true, context: context);
    LoginAccountRequestModal loginAccountrequestmodal = LoginAccountRequestModal(
      email: email,
      password: password,
    );
    ApiHttpResult response = await _accountRepository.loginAccount(loginAccountrequestmodal.prepareRequest());

    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is LoginAccountResponseModal) {
          CustomLoading.progressDialog(isLoading: false, context: context);
          LoginAccountResponseModal signupConfirmResponse = response.data as LoginAccountResponseModal;
          Logger().d(signupConfirmResponse.message);

          if (signupConfirmResponse.statusCode == 200 || signupConfirmResponse.statusCode == 201) {
            chatId = signupConfirmResponse.data?.id ?? '';
            getAllUsersById();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeChatsScreen()),
            );
          }
        }
        break;
      case APIStatus.ERROR:
        CustomLoading.progressDialog(isLoading: false, context: context);
        Logger().d("Api fail on confirm code ");
        // CommonErrorResponseModel signUpErrorResponseModel = CommonErrorResponseModel.fromJson(response.data);
        notifyListeners();
        break;
    }
    // notifyListeners();
  }

  Future getAllUsers(BuildContext context) async {
    ApiHttpResult response = await _accountRepository.getAllUsers();
    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is GetAllUsers) {
          GetAllUsers getAllUsers = response.data as GetAllUsers;
          Logger().d(getAllUsers.message);
          if (getAllUsers.statusCode == 200 || getAllUsers.statusCode == 201) {
            allUsersDataList = getAllUsers.data;
          }
        }
        break;
      case APIStatus.ERROR:
        Logger().d("Api fail on get all users");
        CommonErrorResponseModel signUpErrorResponseModel = CommonErrorResponseModel.fromJson(response.data);
        notifyListeners();
        break;
    }
    notifyListeners();
  }

  List<GetUsersByIdData> allUsersbyIdDataList = [];

  Future getAllUsersById() async {
    ApiHttpResult response = await _accountRepository.getAllUsersById(chatId: chatId);
    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is GetUsersByIdResponseModal) {
          GetUsersByIdResponseModal getAllUsers = response.data as GetUsersByIdResponseModal;
          Logger().d(getAllUsers.message);
          if (getAllUsers.statusCode == 200 || getAllUsers.statusCode == 201) {
            allUsersbyIdDataList = getAllUsers.data!;
            inspect(allUsersbyIdDataList);
            notifyListeners();
          }
        }
        break;
      case APIStatus.ERROR:
        Logger().d("Api fail on get all users");
        CommonErrorResponseModel signUpErrorResponseModel = CommonErrorResponseModel.fromJson(response.data);
        notifyListeners();
        break;
    }
  }
}

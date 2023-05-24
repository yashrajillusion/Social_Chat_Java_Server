import 'package:chat_app/infrastructure/data_access_layer/networks/api_response.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/repositories/account_repository.dart';
import 'package:chat_app/infrastructure/models/request/create_account_request_modal.dart';
import 'package:chat_app/infrastructure/models/request/create_chat_request.dart';
import 'package:chat_app/infrastructure/models/request/login_account_request_modal.dart';
import 'package:chat_app/infrastructure/models/request/send_message_request.dart';
import 'package:chat_app/infrastructure/models/response/common_error_response_model.dart';
import 'package:chat_app/infrastructure/models/response/create_account_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/create_chat_response.dart';
import 'package:chat_app/infrastructure/models/response/get_all_messages_by_id_response.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users_by_id_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/login_account_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/send_message_response_modal.dart';
import 'package:chat_app/infrastructure/sharedprefs/sharedprefs.dart';
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
  List<GetAllMessagesByIdData>? allMessagesById;
  bool isLogin = true;
  String chatId = '';

  setChatId(String value) {
    chatId = value;
    notifyListeners();
  }

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
          CreateAccountResponsemodal signupConfirmResponse = response.data as CreateAccountResponsemodal;

          SharedPrefs.saveChatId(signupConfirmResponse.data?.id ?? '');
          CustomLoading.progressDialog(isLoading: false, context: context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeChatsScreen()));
        }
        break;
      case APIStatus.ERROR:
        CustomLoading.progressDialog(isLoading: false, context: context);
        Logger().d("Api fail on create account ");
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
          LoginAccountResponseModal signupConfirmResponse = response.data as LoginAccountResponseModal;
          SharedPrefs.saveChatId(signupConfirmResponse.data?.id ?? '');
          CustomLoading.progressDialog(isLoading: false, context: context);
          Logger().d(signupConfirmResponse.message);

          if (signupConfirmResponse.statusCode == 200 || signupConfirmResponse.statusCode == 201) {
            chatId = signupConfirmResponse.data?.id ?? '';
            getAllUsersById(chatId);
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
    notifyListeners();
  }

  List<GetUsersByIdData> allUsersbyIdDataList = [];

  Future getAllUsersById(String chatIdd) async {
    ApiHttpResult response = await _accountRepository.getAllUsersById(chatId: chatIdd);
    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is GetUsersByIdResponseModal) {
          GetUsersByIdResponseModal getAllUsers = response.data as GetUsersByIdResponseModal;
          Logger().d(getAllUsers.message);
          if (getAllUsers.statusCode == 200 || getAllUsers.statusCode == 201) {
            allUsersbyIdDataList = getAllUsers.data!;
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

  Future getAllUsersChatsById(String chatIdd) async {
    ApiHttpResult response = await _accountRepository.getAllMessagesById(chatId: chatIdd);
    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is GetAllMessagesByIdResponse) {
          GetAllMessagesByIdResponse getAllUsers = response.data as GetAllMessagesByIdResponse;
          Logger().d(getAllUsers.message);
          if (getAllUsers.statusCode == 200 || getAllUsers.statusCode == 201) {
            allMessagesById = getAllUsers.data;
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

  Future sentMessage({
    required BuildContext context,
    required String senderId,
    required String chatId,
    required String message,
  }) async {
    SendMessageRequest sendMessgeRequest = SendMessageRequest(
      senderId: senderId,
      chatId: chatId,
      message: message,
    );
    ApiHttpResult response = await _accountRepository.sendMessageRequest(sendMessgeRequest.prepareRequest());

    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is SendMessageResponseModal) {
          SendMessageResponseModal sendMessageResponse = response.data as SendMessageResponseModal;
          return sendMessageResponse.data?.toJson();
        }
        break;
      case APIStatus.ERROR:
        Logger().d("Api fail to send message ");
        notifyListeners();
        break;
    }
  }

  Future createChat({
    required String memberId1,
  }) async {
    CreateChatRequest sendMessgeRequest = CreateChatRequest(
      isGroupChat: false,
      membersId: [chatId, memberId1],
    );
    ApiHttpResult response = await _accountRepository.createChat(sendMessgeRequest.prepareRequest());

    switch (response.status) {
      case APIStatus.SUCCESS:
        if (response.data != null && response.data is CreateChatResponse) {
          CreateChatResponse getAllUsers = response.data as CreateChatResponse;
          return getAllUsers.data?.id;
        }
        break;
      case APIStatus.ERROR:
        Logger().d("Api fail to create chat ");
        notifyListeners();
        break;
    }
  }
}

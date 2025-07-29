import 'package:dio/dio.dart';
import 'package:flutter_application_2/cubites/auth_state.dart';
import 'package:flutter_application_2/models/user_model.dart';
import 'package:flutter_application_2/servieses/local_storage_servies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial({})){
     LocalStorageService.loadRemembered();
     LocalStorageService.loadEmails();
  }

  void login(String email, bool rememperMe, String password) async {
    emit(AuthLoginSuccess(state.emails));
    await LocalStorageService.saveRemembered(rememperMe);
  }

  void remmberd(bool rem) {
    emit(AuthRemmemberd(state.emails, rem));
  }

  void register(UserModel user) async {
  Map<String, String> existingEmails = await LocalStorageService.loadEmails();

  existingEmails[user.email] = user.password;

  emit(AuthRegisterd(existingEmails, user));

  await LocalStorageService.saveEmails(existingEmails);
}

  void logOut() {}

  void checkAuthState() {}

  void validateForm(FormData formData) {}

  void updateProfile(UserModel user) {}

  void changePassword(String oldPass, String newPass) {}
}

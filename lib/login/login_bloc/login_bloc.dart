import 'package:coflow/login/login_services/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  LoginService service = LoginService();
  LoginBloc() : super(InitialLoginState()) {
    on(loginEventControl);
  }

  Future<void> loginEventControl(
      LoginEvent event, Emitter<LoginState> emit) async {
    if (event is InitialLoginEvent) {
      emit(LoadingLoginState());
      final _isCurrentUser = await isCurrentUser();

      emit(CurrentUserCheckLoginState(isCurrentUser: _isCurrentUser!));
    } else if (event is LoadLoginEvent) {
    } else if (event is CreateUserLoginEvent) {
      emit(CreateUserLoadingLoginState());
      try {
        String? isSucsses = await service.createUser(
            email: event.personModel!.mailAdress!,
            password: event.personModel!.password!);
        if (isSucsses == 'true') {
          emit(CreateUserSucssesLoginState());
        } else {
          if (isSucsses == 'email-already-in-use') {
            isSucsses = 'E-posta Adresi Zaten Kullanılıyor';
          } else if (isSucsses == 'invalid-email') {
            isSucsses = 'Geçerli bir E-posta Adresi Giriniz';
          } else {
            isSucsses = 'Bilinmeyen Bir Hata Oluştu';
          }
          emit(CreateUserFailedLoginState(error: isSucsses));
        }
      } catch (e) {}
    } else if (event is LoginUserLoginEvent) {
      emit(LoginUserLoadingLoginState());
      try {
        String? isSucsses = await service.loginUser(
            email: event.email!, password: event.password!);
        if (isSucsses == 'true') {
          emit(LoginUserSuccsesLoginState());
        } else {
          if (isSucsses == 'invalid-email' ||
              isSucsses == 'user-disabled' ||
              isSucsses == 'user-not-found') {
            isSucsses = 'Geçersiz Mail Adresi';
          } else if (isSucsses == 'wrong-password') {
            isSucsses = 'E-posta Adresi veya Şifre Yanlış';
          } else {
            isSucsses = 'Bilinmeyen Bir Hata Oluştu';
          }
          emit(LoginUserFailedLoginState(error: isSucsses));
        }
      } catch (e) {}
    } else if (event is PushToHomeScrrenLoginEvent) {
      emit(LoadingLoginState());
      emit(PushToHomeScreenLoginState());
    }
  }

  Future<bool?> isCurrentUser() async {
    final isCurrentAuth = auth.currentUser;
    if (isCurrentAuth != null) {
      return true;
    } else {
      return false;
    }
  }
}

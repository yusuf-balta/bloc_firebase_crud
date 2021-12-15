import 'package:coflow/home/home_screen.dart';
import 'package:coflow/login/login_bloc/login_bloc.dart';
import 'package:coflow/login/login_bloc/login_event.dart';
import 'package:coflow/login/login_bloc/login_state.dart';
import 'package:coflow/models/person_model.dart';
import 'package:coflow/utils/buttons.dart';
import 'package:coflow/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late String? _mailAdress;
  late String? _password;
  late PersonModel? personModel;
  late TextEditingController? txtEmailAdressSingInController;
  late TextEditingController? txtPasswordSingInController;

  late TextEditingController? txtUserNameSingUpController;
  late TextEditingController? txtPasswordSingUpController;
  late TextEditingController? txtEmailAdressSingUpController;
  late TextEditingController? txtphoneNumberSingUpController;

  late LoginBloc loginBloc;

  bool isLoading = false;
  bool isSplashLoading = false;
  bool isVisibilityPassword = false;
  bool isDialogActive = false;
  bool isCurrentUser = false;
  @override
  void initState() {
    personModel = PersonModel();
    super.initState();
    loginBloc = LoginBloc();
    loginBloc.add(InitialLoginEvent());
    txtEmailAdressSingInController = TextEditingController();
    txtPasswordSingInController = TextEditingController();

    txtUserNameSingUpController = TextEditingController();
    txtPasswordSingUpController = TextEditingController();
    txtEmailAdressSingUpController = TextEditingController();
    txtphoneNumberSingUpController = TextEditingController();
    _mailAdress = "";
    _password = "";
  }

  @override
  void dispose() {
    loginBloc.close();
    txtEmailAdressSingInController!.dispose();
    txtPasswordSingInController!.dispose();

    txtUserNameSingUpController!.dispose();
    txtPasswordSingUpController!.dispose();
    txtEmailAdressSingUpController!.dispose();
    txtphoneNumberSingUpController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
        bloc: loginBloc,
        listener: (context, state) async {
          if (state is InitialLoginState) {
          } else if (state is CurrentUserCheckLoginState) {
            if (!state.isCurrentUser) {
              setState(() {
                isCurrentUser = false;
                isLoading = false;
              });
            } else {
              setState(() {
                isCurrentUser = true;
                isLoading = false;
              });
            }
          } else if (state is CreateUserLoadingLoginState) {
            setState(() {
              isDialogActive = true;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.loadingDialog(size);
                });
          } else if (state is CreateUserSucssesLoginState) {
            if (isDialogActive) {
              setState(() {
                isDialogActive = false;
              });
              Navigator.of(context).pop();
            }
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.sucssesDialog(
                      content: const Text('Kayıt Başarılı'),
                      context: context,
                      onPressed: () {
                        Navigator.pop(context);
                        loginBloc.add(InitialLoginEvent());
                      });
                });
          } else if (state is CreateUserFailedLoginState) {
            if (isDialogActive) {
              setState(() {
                isDialogActive = false;
              });
              Navigator.of(context).pop();
            }
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.errorDialog(
                      content: Text(state.error), context: context);
                });
          } else if (state is LoginUserLoadingLoginState) {
            setState(() {
              isDialogActive = true;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.loadingDialog(size);
                });
          } else if (state is LoginUserSuccsesLoginState) {
            if (isDialogActive) {
              setState(() {
                isDialogActive = false;
              });
              Navigator.of(context).pop();
            }
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.sucssesDialog(
                      content: const Text('Giriş Başarılı'),
                      context: context,
                      onPressed: () async {
                        Navigator.pop(context);
                        loginBloc.add(PushToHomeScrrenLoginEvent());
                      });
                });
          } else if (state is LoginUserFailedLoginState) {
            if (isDialogActive) {
              setState(() {
                isDialogActive = false;
              });
              Navigator.of(context).pop();
            }
            showDialog(
                context: context,
                builder: (context) {
                  return Dialogs.errorDialog(
                      content: Text(state.error), context: context);
                });
          } else if (state is PushToHomeScreenLoginState) {
            if (isDialogActive) {
              Navigator.pop(context);
            }
            loginBloc.add(InitialLoginEvent());
          }
        },
        child: isCurrentUser
            ? const HomeScreen()
            : SafeArea(
                child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: tabBar.preferredSize,
                    child: ColoredBox(
                      color: Colors.grey,
                      child: tabBar,
                    ),
                  ),
                  body: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TabBarView(
                          children: [signIn(), signUp()],
                        ),
                ),
              )));
  }

  TabBar get tabBar => const TabBar(
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            text: 'Giriş Yap',
          ),
          Tab(
            text: 'Kayıt Ol',
          )
        ],
      );
  Widget txtEmailAdress(bool isIn) {
    return TextFormField(
      controller: isIn
          ? txtEmailAdressSingInController
          : txtEmailAdressSingUpController,
      decoration: InputDecoration(
        hintText: 'E-posta',
        labelText: 'E-posta',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'boş olamaz';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        _mailAdress = value;
        personModel!.mailAdress = value;
      }),
      onChanged: (value) => setState(() {
        personModel!.mailAdress = value;
        _mailAdress = value;
      }),
    );
  }

  Widget txtPassword(bool isIn) {
    return TextFormField(
      controller:
          isIn ? txtPasswordSingInController : txtPasswordSingUpController,
      decoration: InputDecoration(
        hintText: 'Şifre',
        labelText: 'Şifre',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isVisibilityPassword = !isVisibilityPassword;
            });
          },
          icon: Icon(
            isVisibilityPassword ? Icons.visibility : Icons.visibility_off,
            color: isVisibilityPassword
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        ),
        prefixIcon: const Icon(Icons.vpn_key),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      obscureText: !isVisibilityPassword,
      validator: (value) {
        if (value!.length < 6) {
          return ' 6 karakterden büyük olmalı ';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        personModel!.password = value;
        _password = value;
      }),
      onChanged: (value) => setState(() {
        personModel!.password = value;
        _password = value;
      }),
    );
  }

  Widget signUp() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txtEmailAdress(false),
                const SizedBox(
                  height: 10,
                ),
                txtPassword(false),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons.elevatedButton(
                        child: const Text("Kayıt Ol"),
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            loginBloc.add(
                                CreateUserLoginEvent(personModel: personModel));
                          } else {}
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signIn() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _signInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txtEmailAdress(true),
                const SizedBox(
                  height: 20,
                ),
                txtPassword(true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons.elevatedButton(
                        child: const Text("Giriş Yap"),
                        onPressed: () {
                          if (_signInFormKey.currentState!.validate()) {
                            loginBloc.add(LoginUserLoginEvent(
                                email: _mailAdress, password: _password));
                          } else {}
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

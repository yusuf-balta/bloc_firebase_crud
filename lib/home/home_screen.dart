import 'package:coflow/breking_bad/breking_bad_view.dart';
import 'package:coflow/home/home_bloc/home_state.dart';
import 'package:coflow/login/login_ui/login_screen.dart';

import 'package:coflow/models/product_model.dart';
import 'package:coflow/product/product_view.dart';
import 'package:coflow/utils/dialogs.dart';
import 'package:coflow/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc/home_bloc.dart';
import 'home_bloc/home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ProductModel> productsModel;
  late HomeBloc homeBloc;
  late bool isLoading;
  late bool isDialogActive;
  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.add(InitialHomeEvent());
    isLoading = true;
    productsModel = [];
    isDialogActive = false;
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is LoadingHomeState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is SuccsesHomeState) {
          productsModel = state.productsModel;
          setState(() {
            isLoading = false;
          });
        } else if (state is LogoutLoadingHomeState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is LogoutSuccsesHomeState) {
          if (isDialogActive) {
            Navigator.pop(context);
            isDialogActive == false;
          }
          showDialog(
              context: context,
              builder: (context) => Dialogs.sucssesDialog(
                  content: const Text('Çıkış Başarılı'),
                  context: context,
                  onPressed: () {
                    Navigator.pop(context);
                    homeBloc.add(PushToLoginScreenHomeEvent());
                  }));
        } else if (state is PushToLoginScreenHomeState) {
          Routter.pushReplacement(const LoginScreen(), context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : productsModel.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsModel.length,
                      itemBuilder: (context, index) {
                        final product = productsModel[index];
                        return _card(product);
                      })
                  : const Center(
                      child: Text('Ürün Ekleyiniz'),
                    ),
          floatingActionButton: FloatingActionButton(
            child: IconButton(
                onPressed: () async {
                  await Routter.push(ProductView(), context);
                  homeBloc.add(InitialHomeEvent());
                },
                icon: const Icon(
                  Icons.add,
                )),
            onPressed: () {},
          ),
          appBar: AppBar(
            title: const Text('Coflow'),
            actions: [
              IconButton(
                  onPressed: () {
                    Routter.push(BrekingBad(), context);
                  },
                  icon: const Icon(Icons.backup_rounded)),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    homeBloc.add(LogoutHomeEvent());
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(ProductModel productModel) {
    return GestureDetector(
      onTap: () async {
        await Routter.push(
            ProductView(
              productModel: productModel,
            ),
            context);
        homeBloc.add(InitialHomeEvent());
      },
      child: SizedBox(
        height: 100,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('id = ${productModel.productId}'),
              Text('name = ${productModel.productName}'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:coflow/home/home_bloc/home_bloc.dart';
import 'package:coflow/home/home_screen.dart';
import 'package:coflow/models/product_model.dart';
import 'package:coflow/product/product_view_bloc/product_view_bloc.dart';
import 'package:coflow/product/product_view_bloc/product_view_event.dart';
import 'package:coflow/product/product_view_bloc/product_view_state.dart';
import 'package:coflow/utils/buttons.dart';
import 'package:coflow/utils/dialogs.dart';
import 'package:coflow/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ProductView extends StatefulWidget {
  ProductView({Key? key, this.productModel}) : super(key: key);
  late ProductModel? productModel;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final uuid = Uuid();
  final GlobalKey<FormState> _productViewKey = GlobalKey<FormState>();
  late ProductViewBloc productViewBloc;
  late TextEditingController? txtProductIdController;
  late TextEditingController? txtProductNameController;
  late TextEditingController? txtProductCodeController;
  late TextEditingController? txtProductPriceController;
  bool isDialogActive = false;
  bool isCreate = false;

  @override
  void initState() {
    super.initState();
    productViewBloc = ProductViewBloc();
    txtProductIdController = TextEditingController();
    txtProductNameController = TextEditingController();
    txtProductCodeController = TextEditingController();
    txtProductPriceController = TextEditingController();
    if (widget.productModel == null) {
      isCreate = true;
      widget.productModel = ProductModel(
          productId: '',
          productCode: '',
          productName: '',
          productPrice: '',
          uuid: uuid.v1());
    } else {
      txtProductIdController!.text = widget.productModel!.productId;
      txtProductNameController!.text = widget.productModel!.productName;
      txtProductCodeController!.text = widget.productModel!.productCode;
      txtProductPriceController!.text = widget.productModel!.productPrice;
    }
  }

  @override
  void dispose() {
    productViewBloc.close();
    txtProductIdController!.dispose();
    txtProductNameController!.dispose();
    txtProductCodeController!.dispose();
    txtProductPriceController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: productViewBloc,
      listener: (context, state) {
        if (state is LoadingAddToDbProductViewState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is SuccsesAddToDbProductViewState) {
          if (isDialogActive) {
            isDialogActive = false;
            Navigator.pop(context);
          }
          showDialog(
              context: context,
              builder: (context) => Dialogs.sucssesDialog(
                  content: Text('Ürün eklendi'),
                  context: context,
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }));
        } else if (state is LoadingUpdateToDbProductViewState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is SuccsesUpdateToDbProductViewState) {
          if (isDialogActive) {
            isDialogActive = false;
            Navigator.pop(context);
          }
          showDialog(
              context: context,
              builder: (context) => Dialogs.sucssesDialog(
                  content: Text(' Ürün güncellendi'),
                  context: context,
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }));
        } else if (state is LoadingDeleteToDbProductViewState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is SuccsesDeleteToDbProductViewState) {
          if (isDialogActive) {
            isDialogActive = false;
            Navigator.pop(context);
          }
          showDialog(
              context: context,
              builder: (context) => Dialogs.sucssesDialog(
                  content: Text(' Ürün Silindi'),
                  context: context,
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }));
        } else if (state is PushToHomeScreenProductViewState) {
          Routter.pushReplacement(const HomeScreen(), context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Coflow'),
            actions: [
              if (!isCreate) ...[
                IconButton(
                    onPressed: () {
                      productViewBloc.add(DeleteToDbProductViewEvent(
                          productModel: widget.productModel!));
                    },
                    icon: Icon(Icons.delete)),
              ]
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _productViewKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    productId(),
                    SizedBox(
                      height: 10,
                    ),
                    productName(),
                    SizedBox(
                      height: 10,
                    ),
                    productCode(),
                    SizedBox(
                      height: 10,
                    ),
                    productPrice(),
                    SizedBox(
                      height: 10,
                    ),
                    Buttons.elevatedButton(
                        child: Text(isCreate ? 'Ekle' : 'Güncelle'),
                        onPressed: () {
                          if (_productViewKey.currentState!.validate()) {
                            isCreate
                                ? productViewBloc.add(AddToDbProductViewEvent(
                                    productModel: widget.productModel!))
                                : productViewBloc.add(
                                    UpdateToDbProductViewEvent(
                                        productModel: widget.productModel!));
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productId() {
    return TextFormField(
      controller: txtProductIdController,
      decoration: InputDecoration(
        hintText: 'Id',
        labelText: 'Id',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ' boş Olamaz ';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        widget.productModel!.productId = value!;
      }),
      onChanged: (value) => setState(() {
        widget.productModel!.productId = value;
      }),
    );
  }

  Widget productCode() {
    return TextFormField(
      controller: txtProductCodeController,
      decoration: InputDecoration(
        hintText: 'Code',
        labelText: 'Code',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ' boş Olamaz ';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        widget.productModel!.productCode = value!;
      }),
      onChanged: (value) => setState(() {
        widget.productModel!.productCode = value;
      }),
    );
  }

  Widget productName() {
    return TextFormField(
      controller: txtProductNameController,
      decoration: InputDecoration(
        hintText: 'Name',
        labelText: 'Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ' boş Olamaz ';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        widget.productModel!.productName = value!;
      }),
      onChanged: (value) => setState(() {
        widget.productModel!.productName = value;
      }),
    );
  }

  Widget productPrice() {
    return TextFormField(
      controller: txtProductPriceController,
      decoration: InputDecoration(
        hintText: 'Price',
        labelText: 'Price',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ' boş Olamaz ';
        } else {
          return null;
        }
      },
      onSaved: (value) => setState(() {
        widget.productModel!.productPrice = value!;
      }),
      onChanged: (value) => setState(() {
        widget.productModel!.productPrice = value;
      }),
    );
  }
}

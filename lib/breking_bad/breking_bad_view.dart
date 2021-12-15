import 'package:coflow/breking_bad/breking_bad_bloc/breking_bad_bloc.dart';
import 'package:coflow/breking_bad/breking_bad_bloc/breking_bad_event.dart';
import 'package:coflow/breking_bad/breking_bad_bloc/breking_bad_state.dart';
import 'package:coflow/models/breking_bad_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrekingBad extends StatefulWidget {
  const BrekingBad({Key? key}) : super(key: key);

  @override
  _BrekingBadState createState() => _BrekingBadState();
}

class _BrekingBadState extends State<BrekingBad> {
  bool isLoading = true;
  late BrekingBadBloc brekingBadBloc;
  List<BrekingBadModel> listBrekingBadModels = [];
  @override
  void initState() {
    super.initState();
    brekingBadBloc = BrekingBadBloc();
    brekingBadBloc.add(InitialBrekingBadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: brekingBadBloc,
      listener: (context, state) {
        if (state is SuccsesBrekingBadState) {
          setState(() {
            isLoading = false;
            listBrekingBadModels = state.listBrekingBadModels;
          });
        } else if (state is LoadingBrekingBadState) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Coflow'),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 10,
                    );
                  },
                  itemCount: listBrekingBadModels.length,
                  itemBuilder: (context, index) {
                    final brekingBadModel = listBrekingBadModels[index];
                    return _Card(brekingBadModel: brekingBadModel);
                  }),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.brekingBadModel,
  }) : super(key: key);

  final BrekingBadModel brekingBadModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(brekingBadModel.name!),
                VerticalDivider(),
                Text(brekingBadModel.nickname!),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Image.network(brekingBadModel.img!),
          ],
        ),
      ),
    );
  }
}

import 'package:antriku/help/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/AntrainBloc/atrian_bloc_bloc.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  void initState() {
    super.initState();
    context.read<AtrianBlocBloc>().add(AtrianEventBlocGetlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warna.primary,
      body: Column(
        children: [
          BlocConsumer<AtrianBlocBloc, AtrianBlocState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is AtrianstateBlocLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AtrianstateBlocStateFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is AtrianstateBlocStateListantrian) {
                return Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double containerHeight =
                          MediaQuery.of(context).size.height / 2.5;
                      double containerWidth = MediaQuery.of(context).size.width;
                      return Container(
                          padding: EdgeInsets.only(bottom: 50),
                          height: containerHeight,
                          width: containerWidth,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("assets/images/papan.png"),
                              Container(
                                margin: EdgeInsets.only(top: 120),
                                height: containerHeight / 2,
                                width: containerWidth / 2,
                                child: Column(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit
                                          .scaleDown, // Menyesuaikan teks agar tetap di dalam area yang tersedia
                                      child: Text(
                                        "No. ${state.antrian?.nomor ?? "kosong"}",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "Nama : ${state.antrian?.nama ?? "kosong"}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
            },
          ),
          BlocConsumer<AtrianBlocBloc, AtrianBlocState>(
            listener: (context, state) {
              if (state is AtrianstateBlocStateFailed) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Gagal"),
                    content: Text(state.message.toString()),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AtrianstateBlocStateListantrian) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: state.listantrian?.length,
                  itemBuilder: (context, index) {
                    print("jumlah = ${state.listantrian?.length}");
                    var data = state.listantrian![index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: warna.red,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Antrian ${data?.nomor.toString()}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                data!.nama.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<AtrianBlocBloc>().add(
                                      AtrianEventBlocStatus(
                                          id: data.id.toString()),
                                    );
                              },
                              child: Text("Panggil"))
                        ],
                      ),
                    );
                  },
                ));
              } else if (state is AtrianstateBlocLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  child: Center(child: Text("No Data")),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

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
  @override
  void initState() {
    super.initState();
    context.read<AtrianBlocBloc>().add(AtrianEventBlocGetlist());
    // context.read<AtrianBlocBloc>().add(AtrianEventBlocPending());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warna.primary,
      body: Column(
        children: [
          BlocConsumer<AtrianBlocBloc, AtrianBlocState>(
            listener: (context, state) {
              if (state is AtrianstateBlocStateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is AtrianstateBlocLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AtrianstateBlocStateListantrian) {
                return buildAntrianContainer(state);
              } else {
                return Center(child: Text("No Data"));
              }
            },
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Antrian"),
                      Tab(text: "Pending"),
                      Tab(text: "Selesai"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildAntrianListView(),
                        buildPendingListView(),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAntrianContainer(AtrianstateBlocStateListantrian state) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double containerHeight = MediaQuery.of(context).size.height / 2.5;
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
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "No. ${state.antrian?.nomor ?? "kosong"}",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Nama : ${state.antrian?.nama ?? "kosong"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildAntrianListView() {
    return BlocConsumer<AtrianBlocBloc, AtrianBlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AtrianstateBlocStateListantrian) {
          return ListView.builder(
            itemCount: state.listantrian?.length ?? 0,
            itemBuilder: (context, index) {
              var data = state.listantrian![index];
              return buildAntrianItem(data);
            },
          );
        } else if (state is AtrianstateBlocLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No Data"));
        }
      },
    );
  }

  Widget buildAntrianItem(data) {
    return ListTile(
      title: Text("Antrian: ${data.nomor}"),
      subtitle: Text("Nama: ${data.nama}"),
      trailing: ElevatedButton(
        onPressed: () {
          context
              .read<AtrianBlocBloc>()
              .add(AtrianEventBlocStatus(id: data.id));
        },
        child: Text("Panggil"),
      ),
    );
  }

  Widget buildPendingListView() {
    return BlocConsumer<AtrianBlocBloc, AtrianBlocState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AtrianstateBlocStateListantrian) {
          print(state.pendingdata?.length);

          return ListView.builder(
            itemCount: state.pendingdata?.length ?? 0,
            itemBuilder: (context, index) {
              var data = state.pendingdata![index];
              return ListTile(
                title: Text("Antrian: ${data.nomor}"),
                subtitle: Text("Nama: ${data.nama}"),
                trailing: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AtrianBlocBloc>()
                        .add(AtrianEventBlocStatus(id: data.id.toString()));
                  },
                  child: Text("Panggil"),
                ),
              );
            },
          );
        } else if (state is AtrianstateBlocLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No Pending Data"));
        }
      },
    );
  }
}

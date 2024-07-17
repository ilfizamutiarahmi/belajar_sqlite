import 'package:flutter/material.dart';
import 'package:crud_sqlite/addData.dart';
import 'package:crud_sqlite/dbhelper.dart';
import 'package:crud_sqlite/model.dart';

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({Key? key}) : super(key: key);

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  late DBHelper db;
  late List<ModelMahasiswa> itemList;

  @override
  void initState() {
    super.initState();
    db = DBHelper();
    itemList = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<dynamic>? data = await db.getAllMahasiswa();
    if (data != null) {
      List<ModelMahasiswa> mahasiswaList = data.map((e) => ModelMahasiswa.fromMap(e)).toList();
      setState(() {
        itemList = mahasiswaList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Mahasiswa"),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  ModelMahasiswa data = itemList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      child: ListTile(
                        title: Text(data.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("No. BP: ${data.noBP}"),
                            Text("No. HP: ${data.noHP}"),
                            Text("Email: ${data.email}"),
                            Text("Alamat: ${data.alamat}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddMahasiswa(data: data),
                                  ),
                                ).then((_) => _fetchData());
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Anda yakin menghapus data ${data.nama}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            db.deleteMahasiswa(data.id).then((_) {
                                              _fetchData();
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddMahasiswa()),
                  ).then((_) => _fetchData());
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:crud_sqlite/dbhelper.dart';
import 'package:crud_sqlite/listData.dart';
import 'package:crud_sqlite/model.dart';

class AddMahasiswa extends StatefulWidget {
  final ModelMahasiswa? data;

  const AddMahasiswa({Key? key, this.data}) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  DBHelper db = DBHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.data?.nama);
    bpController = TextEditingController(text: widget.data?.noBP);
    hpController = TextEditingController(text: widget.data?.noHP);
    emailController = TextEditingController(text: widget.data?.email);
    addressController = TextEditingController(text: widget.data?.alamat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data?.id != null ? "Update Mahasiswa" : "Add Mahasiswa"),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Nama",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: bpController,
                decoration: InputDecoration(
                  hintText: "Nomor BP",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: hpController,
                decoration: InputDecoration(
                  hintText: "Nomor HP",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Alamat",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                minWidth: 200,
                color: Colors.lightBlue,
                height: 45,
                onPressed: () {
                  if (widget.data?.id != null) {
                    db.updateMahasiswa(widget.data!.id, ModelMahasiswa(
                      nameController.text,
                      bpController.text,
                      hpController.text,
                      emailController.text,
                      addressController.text,
                    )).then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const ListMahasiswa()),
                            (route) => false,
                      );
                    });
                  } else {
                    db.saveMahasiswa(ModelMahasiswa(
                      nameController.text,
                      bpController.text,
                      hpController.text,
                      emailController.text,
                      addressController.text,
                    )).then((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const ListMahasiswa()),
                            (route) => false,
                      );
                    });
                  }
                },
                child: Text(widget.data?.id != null ? "EDIT" : "SIMPAN"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
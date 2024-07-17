class ModelMahasiswa {
  int? _id;
  String? _nama, _noBP, _noHP, _email, _alamat;

  ModelMahasiswa(this._nama, this._noBP, this._noHP, this._email, this._alamat);

  int get id => _id ?? 0;
  String get nama => _nama ?? "";
  String get noBP => _noBP ?? "";
  String get noHP => _noHP ?? "";
  String get email => _email ?? "";
  String get alamat => _alamat ?? "";

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map["id"] = _id;
    }
    map["nama"] = _nama;
    map["nobp"] = _noBP;
    map["nohp"] = _noHP;
    map["email"] = _email;
    map["alamat"] = _alamat;
    return map;
  }

  ModelMahasiswa.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _nama = map["nama"];
    _noBP = map["nobp"];
    _noHP = map["nohp"];
    _email = map["email"];
    _alamat = map["alamat"];
  }
}
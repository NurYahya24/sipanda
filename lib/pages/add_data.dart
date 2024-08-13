import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:intl/intl.dart';

class InputDataPage extends StatefulWidget {
  final String nama, tanggal, ortu, alamat, posyandu, jenkel, uid;
  final double bbl, pbl, lkl, anak;
  final DateTime dateTime;
  final bool edit;
  const InputDataPage({
    super.key, 
    required this.nama, 
    required this.tanggal, 
    required this.ortu,
    required this.alamat,
    required this.posyandu,
    required this.jenkel,
    required this.bbl,
    required this.pbl,
    required this.lkl,
    required this.anak,
    required this.dateTime,
    required this.edit,
    required this.uid});

  @override
  _InputDataPageState createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender, _selectedPlace;
  FirebaseFirestore fs = FirebaseFirestore.instance;
  var _nama = TextEditingController();
  var _tgl = TextEditingController();
  var _ortu = TextEditingController();
  var _alamat = TextEditingController();
  var _BBL = TextEditingController();
  var _PBL = TextEditingController();
  var _LKL = TextEditingController();
  var _anak = TextEditingController();
  DateTime? _tglUnformatted;


  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _handlePlaceChange(String? value) {
    setState(() {
      _selectedPlace = value;
    });
  }

  @override
  void initState() {
      super.initState();
      setState(() {
        if(widget.edit){
          _nama.text = widget.nama;
          _tgl.text = widget.tanggal;
          _ortu.text = widget.ortu;
          _alamat.text = widget.alamat;
          _selectedGender = widget.jenkel;
          _BBL.text = widget.bbl.toString();
          _PBL.text = widget.pbl.toString();
          _LKL.text = widget.lkl.toString();
          _anak.text = widget.lkl.toString();
          _tglUnformatted = widget.dateTime;

        }else{
          _nama.text = '';
          _tgl.text = '';
          _ortu.text = '';
          _alamat.text = '';
          _BBL.text = '';
          _PBL.text = '';
          _LKL.text = '';
          _anak.text = '';
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white,),
        elevation: 0.0,),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4D80DF), Color(0xFFA7E6FF)],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Form Data Bayi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Silahkan Lengkapi Data Pada Form Berikut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  _radioButton('Posyandu', Icons.add_location, 'Anggrek', 'Cempaka', _selectedPlace, _handlePlaceChange),
                  const SizedBox(height: 20),
                  _textField('Nama Bayi', Icons.person, false, false, _nama),
                  const SizedBox(height: 20),
                  _dateTime(),
                  const SizedBox(height: 20),
                  _radioButton('Jenis Kelamin', Icons.wc, 'Laki-laki', 'Perempuan', _selectedGender, _handleGenderChange),
                  const SizedBox(height: 20),
                  _textField('Nama Orang Tua (Ayah/Ibu)', Icons.people, false, false, _ortu),
                  const SizedBox(height: 20),
                  _textField('Alamat', Icons.home, false, false, _alamat),
                  const SizedBox(height: 20),
                  _spaceBetweenField('BB Lahir (kg)', 'PB Lahir (cm)', Icons.monitor_weight, Icons.straighten, _BBL, _PBL),
                  const SizedBox(height: 20),
                  _spaceBetweenField('LK Lahir (cm)', 'Anak Ke-', Icons.child_care, Icons.format_list_numbered, _LKL, _anak),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        try{
                          widget.edit ? updateBayi(_selectedPlace.toString(),_nama.text, _alamat.text, _tglUnformatted!, _selectedGender.toString(), double.parse(_BBL.text), double.parse(_PBL.text), double.parse(_LKL.text), double.parse(_anak.text), _ortu.text, widget.uid) : addBayi(_selectedPlace.toString(),_nama.text, _alamat.text, _tglUnformatted!, _selectedGender.toString(), double.parse(_BBL.text), double.parse(_PBL.text), double.parse(_LKL.text), double.parse(_anak.text), _ortu.text);
                          Navigator.pop(context);
                          const SnackBar(
                            content: Text('Data berhasil disimpan.'),
                            backgroundColor:Color(0xFF4D80DF),
                          );
                        }
                        catch(e){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text(
                                  'Terjadi Kesalahan'
                                ),
                                content: Text('$e'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, 
                                    child: const Text('Ok'))
                                ],
                              );
                            }
                          );                         
                        }   
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateTime(){
    return TextFormField(
      controller: _tgl,
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal Harus Diisi';
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context, 
          firstDate: DateTime(1950), 
          lastDate: DateTime(2100));
        if(pickedDate != null){
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            _tgl.text = formattedDate;
            _tglUnformatted = pickedDate;
          });
        }
      },
      decoration: InputDecoration(
        hintText: "Tanggal Lahir",
        hintStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.blueGrey),
    );
  }

  Widget _textField(String hintText, IconData icon, bool isPassword, bool isDigit, TextEditingController lController) {
    return TextFormField(
      controller: lController,
      keyboardType: isDigit? const TextInputType.numberWithOptions(decimal:true) : TextInputType.text,
      inputFormatters: isDigit ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))] : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText Harus Diisi';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.blueGrey),
    );
  }

  Widget _radioButton(String judul, IconData icons, String firstOption, String secondOption, String? groupV, void Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icons, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    judul,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(firstOption, style: Theme.of(context).textTheme.displaySmall),
                    value: firstOption,
                    groupValue: groupV,
                    activeColor: Colors.blueGrey, 
                    onChanged: onChanged
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(secondOption, style: Theme.of(context).textTheme.displaySmall),
                    value: secondOption,
                    groupValue: groupV,
                    activeColor: Colors.blueGrey, 
                    onChanged: onChanged
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _spaceBetweenField(String first, String second, IconData icon1, IconData icon2, TextEditingController controller1, controller2) {
    return Row(
      children: [
        Expanded(
          child: _textField(first, icon1, false, true, controller1),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _textField(second, icon2, false, true, controller2),
        ),
      ],
    );
  }
}

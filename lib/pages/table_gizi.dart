import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:intl/intl.dart';
import 'package:sipanda/contents/BBlist.dart';

class Table_Gizi extends StatefulWidget {
  final String uid;
  final String gender;
  const Table_Gizi({super.key, required this.uid, required this.gender});

  @override
  State<Table_Gizi> createState() => _Table_GiziState();
}

class _Table_GiziState extends State<Table_Gizi> {
  final _formKey = GlobalKey<FormState>();
  var BBcontroller = TextEditingController();
  var PBcontroller = TextEditingController();
  var LKcontroller = TextEditingController();
  var TGLcheckUp = TextEditingController();
  DateTime? _tglUnformatted;


  void showDialogWithFields(String bulan, bool aksi,DateTime dateTime, String tanggal,double BB, double PB, double LK,String uid, String idCheckUp) {
    showDialog(
      context: context,
      builder: (_) {
        if(aksi){
          BBcontroller.text = BB.toString();
          PBcontroller.text = PB.toString();
          LKcontroller.text = LK.toString();
          TGLcheckUp.text = tanggal.toString();
          _tglUnformatted = dateTime;
        }else{
          BBcontroller.text = '';
          PBcontroller.text = '';
          LKcontroller.text = '';
          TGLcheckUp.text = '';
        }
        return AlertDialog(
          title: aksi ? Text('Edit Data Pemeriksaan\n$bulan', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center,) : Text('Tambah Data Pemeriksaan\n$bulan', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dateTime(),
                    const SizedBox(height: 10),
                    _textField('BB (Kg)', Icons.monitor_weight, false, true, BBcontroller),
                    const SizedBox(height: 10),
                    _textField('PB (Cm)', Icons.straighten, false, true, PBcontroller),
                    const SizedBox(height: 10),
                    _textField('LK (Cm)', Icons.child_care, false, true, LKcontroller)
                  ],
                ), 
              )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color:Color(0xFF4D80DF))),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false){
                  CheckUp(_tglUnformatted!, double.parse(BBcontroller.text), double.parse(PBcontroller.text), double.parse(LKcontroller.text), uid, idCheckUp);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil disimpan.'),
                      backgroundColor:Color(0xFF4D80DF),
                    ),
                  );
                }                
              },
              child: const Text('Simpan', style: TextStyle(color:Color(0xFF4D80DF))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchDataGizi(widget.uid, false), 
      builder: (context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting :
            return const Center(
              child: CircularProgressIndicator(),
            );
          default :
            if(snapshot.hasError){
              return const Text(
                "Error saat membaca data..."
              );
            }else{
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: 
                      DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Tanggal\nPemeriksaan'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Umur\nBulan'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'BB\n(Kg)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'PB\n(Cm)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'LK\n(Cm)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Ket'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Aksi'
                              ,textAlign: TextAlign.center,)
                            )
                          ),
                        ], 
                        rows: <DataRow>[  
                          for(int i = 0; i < snapshot.data!.docs.length; i++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(snapshot.data!.docs[i]['periksa']? Text(getDate(snapshot.data!.docs[i]['tgl-periksa'] as Timestamp)) : const Text('-')),
                              DataCell(Text('${snapshot.data!.docs[i]['bulan']} Bulan')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text('${snapshot.data!.docs[i]['BB']} Kg'): const Text('-')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text('${snapshot.data!.docs[i]['TB']} Cm'): const Text('-')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text("${snapshot.data!.docs[i]['LK']} Cm"): const Text('-')),
                              DataCell(i < 1 ? const Text(' ') : 
                                      snapshot.data!.docs[i]['periksa'] ? 
                                      Text(generateKeterangan(
                                        snapshot.data!.docs[i]['BB'].toDouble(), 
                                        snapshot.data!.docs[(snapshot.data!.docs[i]['bulan']) - 1]['BB'].toDouble(),
                                        snapshot.data!.docs[i]['bulan'] as int,
                                        widget.gender == 'Laki-laki'? true : false,
                                        !(snapshot.data!.docs[(snapshot.data!.docs[i]['bulan']) - 1]['periksa']))) : const Text('-')),
                              DataCell(
                                Center(child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        var data = snapshot.data!.docs[i];
                                        data['periksa'] ? 
                                        showDialogWithFields("${data['bulan']} bulan",true, data['tgl-periksa'].toDate(), getDate(data['tgl-periksa'] as Timestamp), data['BB'], data['TB'], data['LK'], widget.uid, data.id) :
                                        showDialogWithFields("${data['bulan']} bulan",false, Timestamp.now().toDate(), '', 0, 0, 0, widget.uid, data.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF4D80DF), 
                                        ),
                                      child: snapshot.data!.docs[i]['periksa'] ? const Text('Edit', style: TextStyle(color: Colors.white),) : const Text('Tambah', style: TextStyle(color: Colors.white),),
                                    ),
                                    Visibility(
                                      visible: snapshot.data!.docs[i]['periksa'],
                                      child: ElevatedButton(
                                        onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Konfirmasi"),
                                                content: const Text("Apakah Anda yakin ingin menghapus data?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text("Batal", style: TextStyle(color:Color(0xFF4D80DF)),),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text('Data berhasil dihapus.'),
                                                          backgroundColor:Color(0xFF4D80DF),
                                                        ),
                                                      );
                                                      delCheckUp(widget.uid, snapshot.data!.docs[i].id);
                                                    },
                                                    child: const Text("Hapus", style: TextStyle(color: Color(0xFF4D80DF)),),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text('Hapus', style: TextStyle(color: Colors.white),)
                                      )
                                    )
                                  ],
                                )
                              ,) 
                            ),
                          ]
                        )
                      ]
                    )
                )
            );
          }
        }
      }
    );
  }
  Widget _dateTime(){
    return TextFormField(
      controller: TGLcheckUp,
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
            TGLcheckUp.text = formattedDate;
            _tglUnformatted = pickedDate;
          });
        }
      },
      decoration: InputDecoration(
        hintText: "Tanggal Pemeriksaan",
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
      keyboardType: isDigit ? const TextInputType.numberWithOptions(decimal:true) : TextInputType.text,
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

}


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RekapDetailed extends StatefulWidget {
  final String filter;
  const RekapDetailed({super.key, required this.filter});

  @override
  State<RekapDetailed> createState() => _RekapDetailedState();
}

class _RekapDetailedState extends State<RekapDetailed> {
  var _ctrlTgl = TextEditingController();
  DateTime? _tglUnformatted;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Text('Pilih Tanggal :', style: Theme.of(context).textTheme.bodyLarge),
             const SizedBox(width: 20,),
             Expanded(
              child: TextFormField(
                controller: _ctrlTgl,
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
                      _ctrlTgl.text = formattedDate;
                      _tglUnformatted = pickedDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Tanggal Rekap",
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color.fromARGB(255, 0, 0, 0)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 4),
                  ),
                ),
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              )
            )
             
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10), 
                child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Color(0xFF4D80DF), Color.fromRGBO(142, 176, 240, 1)
                ],
                begin: Alignment.center,
                end: FractionalOffset.bottomCenter,)
                ),         
              )
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20), 
                child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Color(0xFF4D80DF), Color.fromRGBO(142, 176, 240, 1)
                ],
                begin: Alignment.center,
                end: FractionalOffset.bottomCenter,)
                ),         
              )
            ),
            const SizedBox(height: 20)
            ],
          )
        )          
      ],
    );
    
    
  }
}
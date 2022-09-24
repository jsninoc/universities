import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universities/models/university.dart';
import 'package:universities/providers/universities_provider.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({ Key? key }) : super(key: key);

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {

  TextEditingController _qtyInputController = TextEditingController();

  Future<void> _openModal() async{
    final universitiesProvider = Provider.of<UniversitiesProvider>(context, listen: false);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Añadir estudiantes',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _qtyInputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  fillColor: Color(0xFFF8F8F8),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: Color(0xFFF8F8F8), width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: Color(0xFFF8F8F8), width: 0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      borderSide: BorderSide(width: 1.0, color: Colors.red)),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: const BorderSide(
                    style: BorderStyle.solid,
                    width: 2.0
                  )
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w900,
                  fontSize: 14
                )
              )
            ),
            ElevatedButton(
              onPressed: (){
                if(_qtyInputController.value.text != "" || int.parse(_qtyInputController.value.text) > 0) {
                  universitiesProvider.updateUniversityStudets(_qtyInputController.value.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14
                ),
              )
            )
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {

    University _university = Provider.of<UniversitiesProvider>(context).university;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.chevron_left)
        )
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20,),
                Text(
                  _university.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  _university.country,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Number of students',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  _university.studentsQty
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Domains',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 5,),
                Column(
                  children: _university.domains.map((domain) => 
                    Text(
                      domain
                    )
                  ).toList(),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Web Pages',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 5,),
                Column(
                  children: _university.webPages.map((webPage) => 
                    Text(
                      webPage
                    )
                  ).toList(),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    _openModal();
                  }, 
                  child: const Text('Add students number'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
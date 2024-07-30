import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/contents/category.dart';
import 'package:sipanda/pages/login.dart';
import 'package:sipanda/pages/read_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: const [
            AppsBar(),
            Expanded(child: Bodies(),)
          ],
        ),
      ), 
    );
  }
}

class Bodies extends StatelessWidget {
  const Bodies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10 ,left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu Dashboard",
              style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),),
          Expanded(child: 
          GridView.builder(
            shrinkWrap: true,
            itemCount: CategoryList.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24), 
            itemBuilder: (context, index){
              return CategoryCard(
                category : CategoryList[index]
              );
            })
          )
          
      ],
    );
  }
}
class AppsBar extends StatelessWidget {
  const AppsBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      gradient: LinearGradient(colors: [
        Color(0xFF4D80DF), Color.fromRGBO(142, 176, 240, 1)
      ],
      begin: Alignment.center,
      end: FractionalOffset.bottomCenter,)
      ),
      child: 
              StreamBuilder(
                stream: whoAmI(), 
                builder: (context, snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Text(
                        "Loading....",
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    default:
                      int indeks = 0;
                      int panjang = snapshot.data?.docs.length as int;
                      for (int i =0; i<panjang; i++){
                        if(snapshot.data!.docs[i].id == FirebaseAuth.instance.currentUser!.uid){
                          indeks = i;
                        }
                      }if(snapshot.hasError) {
                        return Text("Error Saat Membaca Data");
                      }else{
                        return 
                        Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                        Flexible(child: Text(
                "Halo, "+ snapshot.data?.docs[indeks]["nama"],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              )],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data?.docs[indeks]["level"],
                style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w300)
              )
            ],
          ),
        ],
      );
                      }
                  }
                })
            
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Read_Data_Page()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: 120,
              ),
            ),
            const SizedBox(height: 10,),
            Text(category.nama),
            Text(category.subNama, style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
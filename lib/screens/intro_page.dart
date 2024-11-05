import 'package:flutter/material.dart';
import 'package:online_store/screens/homepage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            //logo
            Image.asset('lib/images/mobile-shopping.png',height: 350,width: 250,),

            const SizedBox(height: 24),
            const Text('Endless choices, unbeatable prices',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            //title
            const SizedBox(height: 24),
            Text('your one-stop shop for quality products and effortless shopping!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700]),),
            const SizedBox(height: 48),

            //start now button
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[900],borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('shop now', style: TextStyle(color: Colors.white, fontSize: 25),),
                    ),
                    Icon(Icons.double_arrow, color: Colors.white,)
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Dome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget{
  final ValueNotifier<Alignment> _aligment=ValueNotifier(Alignment.bottomCenter);


  @override
  Widget build(BuildContext context){

    final appBar=AppBar(
      title: const Text('動畫範例'),
    );

    var btn=ElevatedButton.icon(
      icon:const Padding(
        padding:EdgeInsets.only(left: 20, top: 10,right: 0,bottom: 10),
        child:Icon(Icons.airplanemode_active,color: Colors.white)
      ),
      label: const Padding(
        padding:EdgeInsets.only(left: 0, top: 10,right: 20,bottom: 10),
        child:Text('起飛',style: TextStyle(fontSize: 18,color: Colors.white),),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: ()=>_aligment.value=Alignment.topCenter,
      );

    final widget=Center(
      child: Container(
        height: 500,
        child: Column(
          children: <Widget>[
            ValueListenableBuilder<Alignment>(
              builder: _animatedContainerBuilder,
                valueListenable: _aligment,
            ),
            Container(
              child: btn,
              margin: const EdgeInsets.symmetric(vertical: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
    final appHomePage= Scaffold(
      appBar: appBar,
      body: widget,
    );
    return appHomePage;
  }
  Widget _animatedContainerBuilder(BuildContext context,Alignment alignment,Widget? child){
    final wid= Expanded(
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
        child: const Icon(Icons.airplanemode_active,color: Colors.lightBlue,size: 50),
        alignment: alignment,
        onEnd: ()=>_aligment.value=Alignment.bottomCenter,
      ),
    );
    return wid;
  }
}

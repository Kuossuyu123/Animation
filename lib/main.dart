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
  final ValueNotifier<Alignment> _aligment=ValueNotifier(Alignment.bottomCenter);//飛機起始位置


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
      onPressed: ()=>_aligment.value=Alignment.topCenter,//對齊方式,飛行軌道
      );
    final widget=Center(
      child: Container(
        height: 500,
        child: Column(
          children: <Widget>[
            ValueListenableBuilder<Alignment>( //<>資料型態
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
    //結合AppBar和App操作畫面
    final appHomePage= Scaffold(
      appBar: appBar,
      body: widget,
    );
    return appHomePage;
  }
   //重建AnimatedContainer
  Widget _animatedContainerBuilder(BuildContext context,Alignment alignment,Widget? child){
    final wid= Expanded(
      child: AnimatedContainer(
        duration: const Duration(seconds: 3), //飛行時間//控制動畫持續時間
        curve: Curves.fastOutSlowIn, //飛機跑的模式//控制動畫速度的變化
        child: const Icon(Icons.airplanemode_active,color: Colors.lightBlue,size: 50),
        alignment: alignment,
        onEnd: ()=>_aligment.value=Alignment.bottomCenter,//飛機結束位置//動畫結束時執行它
      ),
    );
    return wid;
  }
}

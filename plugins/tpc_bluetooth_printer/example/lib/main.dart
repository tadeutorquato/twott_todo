// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:flutter/services.dart';
// import 'package:tpc_bluetooth_printer/tpc_bluetooth_printer.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       platformVersion =
//           await TpcBluetoothPrinter.platformVersion ?? 'Unknown platform version';
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//
//   test() async {
//     print(await TpcBluetoothPrinter.checkStatus(macAddress: "D0:2E:AB:AE:AD:02"));
//   }
//   listTest() async {
//     print(await TpcBluetoothPrinter.listPrinters());
//   }
//   printText(){
//     TpcBluetoothPrinter.bluetoothPrint(
//       textToPrint: "^XA^MNY^PON^LH0,0^JMA^XZ^XA^PQ1,,1,Y^LH25,25^CF0,40^FT0,0^CI13^FO0,50^GB580,376,5,B^FS^LRY^FO0,0^GB580,45,25,W^FS^FO15,10^A0,N35,45^FDTeste Impressora^FS^FO10,567^A0,N30,45^FDTPC^FS^FO250,570^A0,N20,25^FDWPRTO^FS^FO400,570^A0,N20,25^FD22/04/2022 15:34^FS^LRN^FO0,90^GB580,0,2,B^FS^FO0,152^GB580,0,2,B^FS^FO0,238^GB580,0,2,B^FS^FO0,294^GB580,0,2,B^FS^FO0,350^GB580,0,2,B^FS^FO290,237^GB0,116,2,B^FS^FO430,152^GB0,88,2,B^FS^FO10,60^A0,N25,20^FDFornecedor^FS^FO10,100^A0,N25,25^FDItem^FS^FO10,130^A0,N25,25^FDsku^FS^FO10,180^A0,N40,40^FDEAN^FS^FO440,165^A0,N25,25^FDClasse Sku^FS^FO10,248^A0,N20,20^FDRD^FS^FO10,275^A0,N20,20^FDCLALOC^FS^FO300,248^A0,N20,20^FD# Grupo ^FS^FO10,304^A0,N20,20^FDQtde. Padrao^FS^FO300,304^A0,N20,20^FD# Item^FS^FO10,360^A0,N20,20^FDLote / Validade Fornecedor^FS^BY2,,150^FO100,440^BCN,100,Y,N^FD>;010002025698011146266047447628^FS^FO105,160^BY2,,75^BCN,55,N,N^SN>;>807891000098967,1,Y^FS^FO250,357^BY2,,75^BCN,40,Y,N^SN>:>82324,1,Y^FS^FO115,65^A0,N30,40^FDGRUPO TPC^FS^FO70,100^A0,N25,25^FDCOLINT^FS^FO160,130^A0,N25,25^FD^FS^FO130,220^A0,N25,30^FD07891000098967^FS^FO60,245^A0,N25,30^FD000620218^FS^FO60,272^A0,N25,30^FD PPPCK^FS^FO450,190^A0,N40,40^FDY^FS^FO195,304^A0,N20,20^FDQtd.Receb^FS^FO200,323^A0,N30,50^FD20^FS^FO280,130^A0,N25,25^FDClaloc Cativo^FS^FO440,130^A0,N27,27^FD^FS^FO60,130^A0,N27,27^FD12228413^FS^FO10,323^A0,N30,40^FD12 X 9^FS^FO300,266^A0,N30,50^FD011146266^FS^FO300,323^A0,N30,50^FD106228296^FS^FO10,380^A0,N22,37^FD2324^FS^FO10,400^A0,N22,37^FD22/12/2022^FS^FS^FO525,312^BXN,1,200,0,0,1,~^FH\\^FD\\8ETPC0257891000098967\\8E035COLINT 12g BR\\8E021620218\\8E^FS^XZ",
//       macAddress: "D0:2E:AB:AE:AD:02").then(
//         (value) => print('conectado '+(value.toString()))
//       ).onError(((error, stackTrace) => print(error))
//       ).catchError(
//         (onError)=>print(onError)
//       ).whenComplete(() => print('complete'));
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(children: [
//             Text('Running on: $_platformVersion\n'),
//             ElevatedButton(onPressed: () => test(), child: const Text('Testar!')),
//             ElevatedButton(onPressed: () => printText(), child: const Text('Print!')),
//             ElevatedButton(onPressed: () => listTest(), child: const Text('List!')),
//           ])
//         ),
//       ),
//     );
//   }
// }

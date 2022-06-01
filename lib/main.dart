import 'package:flutter/material.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:tpc_bluetooth_printer/tpc_bluetooth_printer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCenter.startAsync(
    appSecretAndroid: '0b3130ae-6a61-4fe0-bfd2-8a3d9582f16f',
    appSecretIOS: '0b3130ae-6a61-4fe0-bfd2-8a3d9582f16f',
    enableDistribute: false,
  );
  await AppCenter.configureDistributeDebugAsync(enabled: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // void initAppCenter() async {
  //   var appSecretAndroid = "0b3130ae-6a61-4fe0-bfd2-8a3d9582f16f";
  //   var appSecretIOS = "0b3130ae-6a61-4fe0-bfd2-8a3d9582f16f";
  //
  //   await AppCenter.startAsync(appSecretAndroid: appSecretAndroid, appSecretIOS: appSecretIOS);
  // }

  @override
  void initState() {
    super.initState();
    //initAppCenter();

    AppCenter.trackEventAsync('_MyHomePageState.initState');
    
    //await _getImpressoraBtList();
  }
  
  final List<dynamic> _blueDevices = <Map<String, dynamic>>[];  
  
  _getImpressoraBtList() async {
    //setState(() => _isLoadingBt = true);
    var result = await TpcBluetoothPrinter.listPrinters().timeout(const Duration(seconds: 5), onTimeout: () => {'success':false, 'data':'Timeout'});
    if(result['success']){
      for(var d in result['data']){
        _blueDevices.add({'name':d['name'], 'address':d['address']});
      }
      //_atualizarImpressoras();
    } else {
      if(kDebugMode){print(result);}
      //_failed = true;
      //_reason = 'Não foi possível encontrar impressoras bluetooth';
    }
    //setState(() {
      //_isLoadingBt = false;
    //});

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

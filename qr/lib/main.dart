import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'first',
    routes: {
      'first': ((context) => intro()),
      'main': ((context) => ScanScreen())
    },
  ));
}

class intro extends StatefulWidget {
  const intro({super.key});

  @override
  State<intro> createState() => _introState();
}

class _introState extends State<intro> {
  void v() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, 'main');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    v();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            child: Image.asset('i/qr.png'),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String name = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {});
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        name = scanData.code!;
        if (name.isNotEmpty) {
          Vibration.vibrate(duration: 100);
        }
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (name.isNotEmpty) {}
  }

  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'QR code scanner',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        leading: DrawerButton(
          style: ButtonStyle(
            iconColor: MaterialStateColor.resolveWith((states) => Colors.white),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                arrowColor: Colors.green,
                currentAccountPicture: Image.asset('i/qr.png'),
                accountName: Text(
                  'QR code scanner',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
                accountEmail: Text('FlutterDeweloper2008')),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send message to Deweloper',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.telegram,
                    color: Colors.white,
                  )
                ],
              ),
              onTap: () => launch('https://t.me/hater08'),
            )
          ]),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.green.shade900,
            Colors.green.shade700
          ])),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.lightGreen, width: 3),
            ),
            child: Center(
              child: Container(
                height: 300,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: QRView(
                      overlay: QrScannerOverlayShape(
                          borderRadius: 20, borderColor: Colors.white),
                      key: qrKey,
                      onQRViewCreated: onQRViewCreated,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Text(
                '$name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                    controller?.toggleFlash();
                  });
                },
                child: Container(
                  height: 80,
                  child: Icon(
                    isFlashOn ? Icons.flashlight_off : Icons.flashlight_on,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      name = '';
                    });
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (name.isNotEmpty) {
                    launch(name);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Colors.green, Colors.black, Colors.green],
                      )),
                      height: 50,
                      width: 270,
                      child: Center(
                        child: Text(
                          'OPEN QR',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

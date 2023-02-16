import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../contsants.dart';
import 'MainPage.dart';

class VolReportPage extends StatefulWidget {
  @override
  State<VolReportPage> createState() => VolReportPageState();
}

class VolReportPageState extends State<VolReportPage> {
  final TextEditingController report = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return MainPageState.indexSettings == 0
        ? MainPage()
        :  Container(
      padding: EdgeInsets.only(top: 60, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.topRight,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (() => setState(() {
              MainPageState.indexSettings = 0;
            })),
          ),
          Container(
            child: const Text(
              "شاركنا رأيك",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: "PNU",
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 30.0),
              Container(
                height: 150.0,
                width: 300.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],

                        borderRadius: const BorderRadius.all(

                            Radius.circular(10.0))),
                    child: Center(
                      child: TextField(
                        controller: report,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder( //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 1, color: color_purple),
                          ),

                          border: OutlineInputBorder(


                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        maxLines: 30,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [color_blue, color_purple],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    SendReport();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent)),
                  child: const Text(
                    "إرسال",
                    style:
                    TextStyle(fontFamily: "PNU", color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );


  }
  SendReport() async {
    String username = "aynapp0@gmail.com"; //Your Email;
    String password = "xhbvlezesjmgxngg";

    String? uid = await FirebaseAuth.instance.currentUser!.email;

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add('aynapp0@gmail.com') //recipent email
      ..subject =
          'آراء المتطوعين:: ${DateTime.now()}' //subject of the email
      ..text =
          ' يوجد  رأي جديد من $uid  .\n${report.text.trim()}'; //body of the email

    try {


      final sendReport = await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "شكراً لمشاركتنا رأيك! تم الأرسال بنجاح",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
      ));
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "حصل خطأ.. حاول مجدداً",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 6),
        backgroundColor: const Color.fromARGB(255, 163, 21, 21),
      ));
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

}

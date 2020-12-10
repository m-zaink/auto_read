import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';

void main() => runApp(AutoReadApp());

class AutoReadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'AutoRead OTP',
            ),
          ),
          body: Column(
            children: [
              StreamBuilder<SmsMessage>(
                stream: SmsReceiver().onSmsReceived,
                builder: (context, snap) {
                  if ([ConnectionState.done, ConnectionState.active].contains(snap.connectionState) && snap.hasData) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(snap.data.body),
                      ),
                    );
                  }

                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snap.connectionState == ConnectionState.done && snap.hasError) {
                    return Center(
                      child: Text(snap.error),
                    );
                  }

                  return Container();
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

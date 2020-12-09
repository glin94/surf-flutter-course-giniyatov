import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key key, @required this.sight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: 188,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: Colors.deepPurple),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    color: Color(0xFFF5F5F5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          sight.name,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(height: 2),
                        Text(
                          sight.details,
                          maxLines: 1,
                          style: TextStyle(
                              color: Color(0xFF7C7E92),
                              fontFamily: "Roboto",
                              fontSize: 14),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              sight.type,
              style: TextStyle(
                  color: Colors.white, fontFamily: "Roboto", fontSize: 14),
            ),
          ),
          Positioned(
            top: 18,
            right: 19,
            child: Container(
              color: Colors.white,
              height: 18,
              width: 20,
            ),
          )
        ],
      ),
    );
  }
}

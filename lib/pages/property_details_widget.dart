import 'package:child_info/models/parks.dart';
import 'package:flutter/material.dart';

class PropertyDetailsWidget extends StatefulWidget {
  const PropertyDetailsWidget({
    Key? key,
    this.propertyRef,
  }) : super(key: key);

  final Parks? propertyRef;

  @override
  _PropertyDetailsWidgetState createState() => _PropertyDetailsWidgetState();
}


class _PropertyDetailsWidgetState extends State<PropertyDetailsWidget>
    with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
    );
  }
}
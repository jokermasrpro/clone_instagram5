import 'package:flutter/material.dart';




class CustomPopupMenu extends StatelessWidget {
  final Function(String) onSelected; // استدعاء الدالة عند اختيار خيار من القائمة

  const CustomPopupMenu({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected, // تحديد الوظيفة التي سيتم استدعاؤها عند اختيار الخيار
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          PopupMenuItem<String>(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          PopupMenuItem<String>(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ];
      },
    );
  }
}

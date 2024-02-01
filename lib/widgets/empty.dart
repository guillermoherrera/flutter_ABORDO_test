import 'package:flutter/material.dart';

import '../ui/ui_files.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Sin Registros', style: TextStyles.tStyleGrey12,),
            Image(image: AssetImage('assets/nodata.png'), width: 200),
          ],
        ),
      ),
    );
  }
}
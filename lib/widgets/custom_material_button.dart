import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool? loading;
  final bool? isNegative;
  final double? widthContainer;

  const CustomMaterialButton({super.key, required this.text, required this.onPressed, this.loading = false, this.isNegative, this.widthContainer});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 10,
      color: isNegative == true ? Colors.white : const Color.fromRGBO(209, 57, 41, 1),
      onPressed: onPressed,
      child: Container(
        width: widthContainer,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.00),
          gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isNegative == true ? const Color.fromRGBO(9, 85, 179, 1) : const Color.fromRGBO(209, 57, 41, 1),
              isNegative == true ? const Color.fromRGBO(9, 85, 179, 1) : const Color.fromRGBO(209, 57, 41, 1),
              isNegative == true ? const Color.fromRGBO(4, 68, 155, 1) : const Color.fromRGBO(159, 57, 41, 1),
              isNegative == true ? const Color.fromRGBO(4, 68, 155, 1) : const Color.fromRGBO(159, 57, 41, 1),
            ],
          ),
        ), 
        child: loading == true ?  Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(width: 10,),
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color.fromRGBO(209, 57, 41, 1)),
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                ),
              )
            ],
          ),
        ) : FittedBox(child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
      )
    );
  }
}
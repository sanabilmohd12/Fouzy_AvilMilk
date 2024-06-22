import 'package:flutter/material.dart';

callNext( var context,var classname, ) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => classname),
  );
}

callNextReplacement(var context,var className, ) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

back(var context) {
  Navigator.pop(context);
}
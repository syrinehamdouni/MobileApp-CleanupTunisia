part of values;

class BoxDecorationStyles {
  static const BoxDecoration fadingGlory = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF009624),
          Color.fromRGBO(98, 99, 102, 1),
          Color(0xFF80CBC4),
          Color(0xFFA5D6A7)
        ]),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    //border: Border.all(color: Colors.red, width: 5)
  );

  static final BoxDecoration fadingInnerDecor = BoxDecoration(
      color: Color(0xFF004040),
      borderRadius: BorderRadius.circular(20));
}

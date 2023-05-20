part of values;

class ButtonStyles {
  static final ButtonStyle blueRounded = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color(0xFF006064)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: HexColor.fromHex("246CFE")))));

  static final ButtonStyle imageRounded = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(HexColor.fromHex("181A1F")),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: HexColor.fromHex("666A7A"), width: 1))));
}

class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/images/page_indicator/1.png",
    title: "Bienvenue sur CleanUp !",
    subTitle:
        " Cette application est destinée aux citoyens \n qui cherchent à maintenir notre ville propre et saine.",
  ),
  Items(
    img: "assets/images/page_indicator/2.png",
    title: "En tant que citoyen",
    subTitle:
        "Vous pouvez utiliser notre application\n pour signaler les zones de déchets\n et contribuer à leur nettoyage.",
  ),
  Items(
    img: "assets/images/page_indicator/3.png",
    title: "Photographiez les \ndéchets autour de vous",
    subTitle: "nous vous aiderons à signaler leur\n emplacement aux autorités municipales \n pour une intervention rapide.",
  ),
  Items(
    img: "assets/images/page_indicator/4.png",
    title: "Merci de votre signalement !",
    subTitle: "Les employés municipaux travaillent dur\n pour nettoyer la zone signalée et \nmaintenir notre ville propre.",
  ),
];

class Onboarding {
  String image;
  String title;
  String description;

  Onboarding(
      {required this.image, required this.title, required this.description});

  static List<Onboarding> get list => [
        Onboarding(
          image: 'onboarding_one',
          title: 'Finance app the safest and most trusted',
          description: "Your finance work starts here. Our here to help you track and deal with speeding up your transactions.",
        ),
        Onboarding(
          image: 'The fastest transaction process only here',
          title: 'The fastest transaction process only here',
          description: "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
        ),
      ];
}

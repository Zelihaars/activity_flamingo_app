class Place {
  final String imageUrl;
  final String country;
  final String city;
  final String description;
  final String event;

  Place({required this.city, required this.country, required this.description, required this.imageUrl, required this.event});
}

final places = [
  Place(
      imageUrl: "assets/yer/elazig.jpg",
      city: "Elazığ",
      country: "Türkiye",
      description:
      "Elazığ, turizm potansiyeli yüksek olan bir ilimizdir. Târihî eserleri, tabiî güzellikleri ve zengin folkloruyla turisti çeken özelliklere sâhiptir.",
      event: ""),
  Place(
      imageUrl: "assets/yer/mardin.jpg",
      city: "Mardin",
      country: "Türkiye",
      description:
      "Mardin, mimari, etnografik, arkeolojik, tarihi ve görsel değerleri ile zamanın durduğu izlenimini veren Güneydoğunun şiirsel kentlerinden biridir. ",
      event: ""),
  Place(
      imageUrl: "assets/yer/tunceli.jpg",
      city: "Tunceli",
      country: "Türkiye",
      description:
      "Tümüyle Fırat Havzası içerisinde kalan İl, doğal sınırlarla kuşatılmış yüksek bir bölgedir. Doğu Toros Dağlarının uzantıları doğu-batı yönünde uzanarak ilin kuzeybatısını, kuzeyini ve kuzeydoğusunu hemen hemen bütünüyle kaplar.",
      event: "Rio Carnival"),
];

final events = [
  Place(
      imageUrl: "assets/yer/palu.jpg",
      city: "Elazığ",
      country: "Palu",
      description:
      "Tarihi bir kale olan Palu Kalesi'nde bizimle beraber eşşiz bir etkinliğe ne dersiniz",
      event: "Hiking"),
  Place(
      imageUrl: "assets/yer/rafting.jpg",
      city: "Tunceli",
      country: "Munzur",
      description:
      "Munzur suyunda macera dolu bir rafting etkinliğine katılmak ister misiniz.",
      event: "Rafting"),
  Place(
      imageUrl: "assets/yer/mastar.jpg",
      city: "Elazığ",
      country: "Maden",
      description:
      "2 bin 148 rakımlı Mastar Dağı'nın zirvesine tırmanış",
      event: "Trekking"),
];
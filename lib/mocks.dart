import 'package:places/data/model/place.dart';

/// Моковая геопозиция
final location = {
  "lat": 55.796127,
  "lon": 49.106405,
};

final List<Place> mocks = [
  Place(
    id: 1,
    name: "Парк Тысячелетия",
    urls: ["https://cont.ws/uploads/pic/2016/4/0_80c1a_ee4ab833_orig.jpg"],
    openingHours: [0, 0],
    description:
        "Парк в Вахитовском районе Казани. Встречается также альтернативное название парка - «парк Миллениум».",
    lat: 55.783375,
    lon: 49.123695,
    visitingDate: DateTime(2021, 04, 12),
    type: "Парк",
  ),
  Place(
    id: 2,
    name: "Apollo cafe",
    urls: [
      "https://avatars.mds.yandex.net/get-altay/1651981/2a0000016d6f62501dc7ee2d7390e05bdeb8/XXL"
    ],
    openingHours: [9, 18],
    description:
        "Благодаря нам Вы сможете насладиться сытными завтраками и основными блюдами нашего кафе, не выходя из дома. Вам не придется тратить время на кухне. Мы готовим из свежих и вкусных продуктов, упаковываем каждое блюда так,чтобы заказ был доставлен еще горячим.",
    lat: 55.791827,
    lon: 49.136234,
    visitingDate: DateTime(2021, 3, 28),
    type: "Ресторан",
  ),
  Place(
    id: 2,
    name: "Театр имени Г. Камала",
    urls: [
      "http://www.photokzn.ru/userfiles/pic640x340/img-20150420124517-890.jpg",
      "http://tur-kazan.ru/web/uploads/5a995e69c3c61.jpg",
      "http://elitat.ru/one/8068/1378902545.jpg",
    ],
    openingHours: [10, 20],
    description:
        "Татарский государственный академический театр имени Галиаскара Камала г. Казани, (Татарстан), на улице Татарстан и одноимённой площади.",
    lat: 55.7827008300091,
    lon: 49.11717827567945,
    visitingDate: DateTime(2021, 3, 25),
    type: "Особое место",
  ),
  Place(
    id: 2,
    name: "Мечеть «Кул-Шариф»",
    urls: [
      "https://upload.wikimedia.org/wikipedia/commons/d/d1/Kazan_Kremlin_Qolsharif_Mosque_08-2016_img2.jpg?uselang=ru"
    ],
    openingHours: [9, 20],
    description:
        "Главная соборная джума-мечеть республики Татарстан и города Казани (с 2005 года); расположена на территории Казанского кремля; одна из главных достопримечательностей города.",
    lat: 55.798298,
    lon: 49.105201,
    visitingDate: DateTime(2020, 8, 14),
    type: "Особое место",
  )
];

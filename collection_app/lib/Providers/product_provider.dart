import 'package:flutter/material.dart';
import './collection.dart';

class ProductProvider with ChangeNotifier {
    List<Collection> _items = [
    Collection(
      id: 'p1',
      title: 'Date night at 95th floor',
      location: 'Chicago',
      imageUrl:
          'https://i.pinimg.com/originals/34/98/cf/3498cf701a8138011a5faac8f58ef48f.jpg',
      description:
          'A great date place in Chicago. The view was breathtaking. The food is average tho',
      mood: Mood.Amazing,
    ),
    Collection(
      id: 'p2',
      title: 'Catching fall color',
      location: 'Devil\'s Lake',
      imageUrl:
          'https://i0.wp.com/www.devilslakewisconsin.com/wp-content/uploads/2019/01/DevilsDoorWay-Sunset.jpg?fit=1200%2C800&ssl=1',
      description:
          'I was able to watch sunset on Devil\'s Lake. It was absolutely beautiful',
      mood: Mood.Amazing,
    ),
    Collection(
      id: 'p3',
      title: 'Brunch at top of Chicago Athletic Association!',
      location: 'Chicago',
      imageUrl:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fcdn-image.travelandleisure.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1445637410%2Fcindys-rooftop-chicago-ch1015.jpg%3Fitok%3Dj-1yTb04&c=sc&poi=face&q=85',
      description:
          'So hard to get a spot, but it totally lives up to the hype!',
      mood: Mood.Amazing,
    ),
  ];

  var isFavoriate = false;

  List<Collection> get items{

      return [..._items];
  }

  List<Collection> get favoriateItem{
    return _items.where((i) => i.isFavoriate).toList();
  }

  Collection findById (String id){
     return items.firstWhere((index) => index.id == id);
  }

}
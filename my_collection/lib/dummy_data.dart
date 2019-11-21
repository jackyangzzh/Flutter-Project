import './Model/category.dart';
import 'package:flutter/material.dart';
import './Model/collection.dart';

const dummyData = const [
  Category(id: 'c1', title: 'Resturuants', color: Colors.purple),
  Category(id: 'c2', title: 'Hiking', color: Colors.orange),
  Category(id: 'c3', title: 'Keychain', color: Colors.red),
  Category(id: 'c4', title: 'Books', color: Colors.blue),
  Category(id: 'c5', title: 'Hotel', color: Colors.pink),
  Category(id: 'c6', title: 'Meals', color: Colors.yellow),
  Category(id: 'c7', title: 'Sneakers', color: Colors.green),
  Category(id: 'c8', title: 'Climbing', color: Colors.amber),
  Category(id: 'c9', title: 'Bars', color: Colors.lightBlue),
  Category(id: 'c10', title: 'Hype Collection', color: Colors.indigo),
  Category(id: 'c11', title: 'Train Watching', color: Colors.lime),
  Category(id: 'c12', title: 'Brunch', color: Colors.teal),
];

const dummyCollection = const [
  Collection(
    id: 'e1',
    categories: ['Resturuants', 'Brunch', 'Meals'],
    title: 'Sunday Brunch at Madison Sourdough',
    location: 'Madison',
    imageUrl:
        'http://ediblemadison.com/assets/page-headers/madison_sourdough-croissants-header.jpg',
    description:
        'I had a great Sunday brunch with my friends. They have the best crossiant there!',
    difficulty: Difficulty.Easy,
    wouldAgain: true,
    wouldRecommand: true,
  ),
  Collection(
    id: 'e2',
    categories: ['Bars', 'Resturuants'],
    title: 'Date night at 95th floor',
    location: 'Chicago',
    imageUrl:
        'https://i.pinimg.com/originals/34/98/cf/3498cf701a8138011a5faac8f58ef48f.jpg',
    description:
        'A great date place in Chicago. The view was breathtaking. The food is average tho',
    difficulty: Difficulty.Challenging,
    wouldAgain: false,
    wouldRecommand: true,
  ),
  Collection(
    id: 'e3',
    categories: ['Keychain', 'Hype Collection'],
    title: 'My birthday gift -- Gucci Keychain',
    imageUrl:
        'https://cdn-images.farfetch-contents.com/13/16/60/90/13166090_14273449_600.jpg',
    description:
        'This is a special keychain my girlfriend gifted for my birthday. Love it!',
    difficulty: Difficulty.Average,
    wouldAgain: true,
    wouldRecommand: true,
  ),
  Collection(
    id: 'e4',
    categories: ['Hiking', 'Climbing'],
    title: 'Catching fall color',
    location: 'Devil\'s Lake',
    imageUrl:
        'https://i0.wp.com/www.devilslakewisconsin.com/wp-content/uploads/2019/01/DevilsDoorWay-Sunset.jpg?fit=1200%2C800&ssl=1',
    description:
        'I was able to watch sunset on Devil\'s Lake. It was absolutely beautiful',
    difficulty: Difficulty.Challenging,
    wouldAgain: true,
    wouldRecommand: true,
  ),
  Collection(
    id: 'e5',
    categories: ['Sneakers', 'Hype Collection'],
    title: 'Finally Got it! Off White Shoes',
    imageUrl:
        'https://c.static-nike.com/a/images/w_1920,c_limit,f_auto/pv1p8loom2ykknqmdm1i/nike-the-ten-air-vapormax-off-white-white-release-date.jpg',
    description:
        'Camp outside the Nike store for 5 hours and I finally got it! So happy!',
    difficulty: Difficulty.Hard,
    wouldAgain: true,
    wouldRecommand: false,
  ),
  Collection(
    id: 'e6',
    categories: ['Brunch', 'Hotel', 'Meals', 'Resturuants'],
    title: 'Brunch at top of Chicago Athletic Association!',
    location: 'Chicago',
    imageUrl:
        'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fcdn-image.travelandleisure.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1445637410%2Fcindys-rooftop-chicago-ch1015.jpg%3Fitok%3Dj-1yTb04&c=sc&poi=face&q=85',
    description: 'So hard to get a spot, but it totally lives up to the hype!',
    difficulty: Difficulty.Challenging,
    wouldAgain: true,
    wouldRecommand: true,
  ),
  Collection(
    id: 'e7',
    categories: ['Climbing', 'Hiking', 'Train Watching'],
    title: 'Astounshing view from top of Fuji Mountain',
    location: 'Japan',
    imageUrl:
        'https://www.jrailpass.com/blog/wp-content/uploads/2016/05/FujiBulletTrain-1024x576.jpg',
    description: 'Beautiful view from the train of Fuji Mountain',
    difficulty: Difficulty.Average,
    wouldAgain: true,
    wouldRecommand: true,
  ),
];

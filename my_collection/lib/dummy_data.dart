import './Model/category.dart';
import 'package:flutter/material.dart';
import './Model/collection.dart';

const dummyData = const [
  Category(id: 'c1', title: 'Resturuants', color: Colors.purple),
  Category(id: 'c2', title: 'Hiking', color: Colors.orange),
  Category(id: 'c3', title: 'Keychain', color: Colors.red),
  Category(id: 'c4', title: 'Books', color: Colors.blue),
  Category(id: 'c5', title: 'Train Watching', color: Colors.pink),
  Category(id: 'c6', title: 'Meals', color: Colors.yellow),
  Category(id: 'c7', title: 'Sneakers', color: Colors.green),
  Category(id: 'c8', title: 'Climbing', color: Colors.amber),
  Category(id: 'c9', title: 'Bars', color: Colors.lightBlue),
  Category(id: 'c10', title: 'Hype collection', color: Colors.indigo),
  Category(id: 'c11', title: 'Bags', color: Colors.lime),
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
];

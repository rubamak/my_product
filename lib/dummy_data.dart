import 'package:flutter/cupertino.dart';
import 'package:my_product/modules/category.dart';
import 'package:my_product/modules/Families.dart';
import 'package:my_product/modules/products.dart';
import 'dart:io';

//داتا مبدأية افتراضية اشتخدم منها

List<Category> DUMMY_CATEGORY = [
  Category(categoryId: 1, categoryName: 'Food', image_location: 'images/categories/food.png'),
  Category(categoryId: 2, categoryName: 'Beverages', image_location: 'images/categories/drinks.jpeg'),
  Category(categoryId: 3, categoryName: 'Clothes',image_location: 'images/categories/dress.jpeg'),
  Category(categoryId: 4, categoryName: 'Handmade',image_location: 'images/categories/h.png'),
  Category(categoryId: 5, categoryName: 'Digital Services',image_location: 'images/categories/servoces.jpeg'),
];

List<Families> DUMMY_FAMILIES_STORES = [
  Families(
      familyName: 'Happy House ',
      description: 'small description',
      familyId: 1,
      categoryId: 4,
    familyImage: 'images/family.jpg',

  ),
  Families(
      familyName: 'New Home ',
      description: 'small description',
      familyId: 2,
      categoryId: 4,
      familyImage: 'images/family.jpg',
  ),
  Families(
      familyName: 'Soso made ',
      description: 'small description',
      familyId: 3,
      categoryId: 3,
      familyImage: 'images/family.jpg',
  ),
  Families(
      familyName: 'Little Service ',
      description: 'small descriptionssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      familyId: 4,
      categoryId: 5,
    familyImage: 'images/family.jpg',
  ),
  Families(
      familyName: 'Serve You',
      description: 'small description',
      familyId: 5,
      categoryId: 5,
    familyImage: 'images/family.jpg',
  ),
  Families(
      familyName: 'Drink Mind ',
      description: 'small description',
      familyId: 6,
      categoryId: 2,
    familyImage: 'images/family.jpg',
  ),
  Families(
      familyName: 'Happy Making ',
      description: 'small description',
      familyId: 7,
      categoryId: 1,
    familyImage: 'images/family.jpg',
  ),
];
List<Product> DUMMY_PRODUCTS = [
  Product(

    categoryName: "Handmade",
      familyId: 1,
      familyName: 'Happy House ',
      productId: 1,
      productName: "painted Cups",
      price: 10,
      productImage: "images/products/hand.jpg",
      description: "small descriptiondxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"),
  Product(
      categoryName: "Drinks",
      familyId: 6,
      familyName: 'Drink Mind ',
      productId: 2,
      productName: "Ice Coffee",
      price: 50,
      productImage:"images/products/ice.jpg",
      description: "small descriptionffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"),
  Product(
     categoryName: "Food",
      familyId: 7,
      familyName: 'Happy Making',
      productId: 3,
      productName: "Waffle",
      price: 15,
      productImage: "images/products/waff.png",
      description: "small description "),
  Product(
      categoryName: "Handmade",
      familyId: 2,
      familyName: 'New Home ',
      productId: 4,
      productName: "Ring ",
      price: 30,
      productImage: "images/products/ring.jpg",
      description: "small description"),
  Product(
      categoryName: "Clothes",
      familyId: 3,
      familyName: 'Soso made',
      productId: 5,
      productName: "crochet shirt ",
      price: 15,
      productImage: "images/products/shirtjpg.jpg",
      description: "small description"),
  Product(
      categoryName: "Digital Services",
      familyId: 4,
      familyName: 'Little Service ',
      productId: 6,
      productName: "make researches ",
      price: 50,
      productImage: "images/products/research.png",
      description: "small description"),
  Product(
      categoryName: "Food",
      familyId: 7,
      familyName: 'Happy Making ',
      productId: 7,
      productName: "Fatah",
      price: 20,
      productImage: "images/products/f.png",
      description: "small description "),

];


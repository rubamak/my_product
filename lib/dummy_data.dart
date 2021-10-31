import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_product/modules/category.dart';
import 'package:my_product/modules/family_store.dart';
import 'package:my_product/modules/product.dart';
import 'dart:io';

import 'package:my_product/modules/users.dart';

//داتا مبدأية افتراضية اشتخدم منها
//سموحه التحتوتحه



List<Category> DUMMY_CATEGORY = [
  Category(categoryId: "1", categoryName: 'Food', image_location: 'images/categories/food.png'),
  Category(categoryId: "2", categoryName: 'Beverages', image_location: 'images/categories/drinks.jpeg'),
  Category(categoryId: "3", categoryName: 'Clothes',image_location: 'images/categories/dress.jpeg'),
  Category(categoryId: "4", categoryName: 'Handmade',image_location: 'images/categories/h.png'),
  Category(categoryId: "5", categoryName: 'Digital Services',image_location: 'images/categories/servoces.jpeg'),
];

List<Users> DUMMY_USERS = [
  Users(
      lastName: '',
      username: '',
      password: '',
      firstName: '',
      email: '',
      userUid: '')


];


List<FamilyStore> DUMMY_FAMILIES_STORES = [
  FamilyStore(
      familyId:"1",
      familyName: 'Happy House ',
      description: 'small description',
      userId: "1",
      categoryId: "4",
    familyImage: 'images/family.jpg',

  ),
  FamilyStore(
    familyId: "2",
      familyName: 'New Home ',
      description: 'small description',
      userId: "2",
      categoryId: "4",
      familyImage: 'images/family.jpg',
  ),
  FamilyStore(
    familyId: "3",
      familyName: 'Soso made ',
      description: 'small description',
      userId: "3",
      categoryId: "3",
      familyImage: 'images/family.jpg',
  ),
  FamilyStore(
    familyId: "4",
      familyName: 'Little Service ',
      description: 'small descriptionssss',
      userId: "4",
      categoryId: "5",
    familyImage: 'images/family.jpg',
  ),
  FamilyStore(
    familyId: "5",
      familyName: 'Serve You',
      description: 'small description',
      userId: "5",
      categoryId: "5",
    familyImage: 'images/family.jpg',
  ),
  FamilyStore(
    familyId: "6",
      familyName: 'Drink Mind ',
      description: 'small description',
      userId: "6",
      categoryId: "2",
    familyImage: 'images/family.jpg',
  ),
  FamilyStore(
    familyId: "7",
      familyName: 'Happy Making ',
      description: 'small description',
      userId: "7",
      categoryId: "1",
    familyImage: 'images/family.jpg',
  ),
];
List<Product> DUMMY_PRODUCTS = [
  Product(
    categoryName: "Handmade",
      familyId: "1",
      familyName: 'Happy House ',
      productId: "1",
      productName: "painted Cups",
      price: 10,
      productImage: "images/products/hand.jpg",
      description: "small descriptiondxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"),
  Product(
      categoryName: "Drinks",
      familyId: "6",
      familyName: 'Drink Mind ',
      productId: "2",
      productName: "Ice Coffee",
      price: 50,
      productImage:"images/products/ice.jpg",
      description: "small descriptionffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"),
  Product(
     categoryName: "Food",
      familyId: "7",
      familyName: 'Happy Making',
      productId: "3",
      productName: "Waffle",
      price: 15,
      productImage: "images/products/waff.png",
      description: "small description "),
  Product(
      categoryName: "Handmade",
      familyId: "2",
      familyName: 'New Home ',
      productId: "4",
      productName: "Ring ",
      price: 30,
      productImage: "images/products/ring.jpg",
      description: "small description"),
  Product(
      categoryName: "Clothes",
      familyId: "3",
      familyName: 'Soso made',
      productId: "5",
      productName: "crochet shirt ",
      price: 15,
      productImage: "images/products/shirtjpg.jpg",
      description: "small description"),
  Product(
      categoryName: "Digital Services",
      familyId: "4",
      familyName: 'Little Service ',
      productId: "6",
      productName: "make researches ",
      price: 50,
      productImage: "images/products/research.png",
      description: "small description"),
  Product(
      categoryName: "Food",
      familyId: "7",
      familyName: 'Happy Making ',
      productId: "7",
      productName: "Fatah",
      price: 20,
      productImage: "images/products/f.png",
      description: "small description "),

];


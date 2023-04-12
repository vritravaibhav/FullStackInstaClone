

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagramclone/screens/feed_screen.dart';
import 'package:instagramclone/screens/post_screen.dart';
import 'package:instagramclone/screens/profile_screen.dart';
import 'package:instagramclone/screens/search_screen.dart';



  
const webScreenSize = 600;
 List<Widget> homeScreenItems = [
    FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          Text("notif"),
         ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];

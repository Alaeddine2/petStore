
# petstore

A simple flutter project to handle pet registration in a store.

![Dart](https://img.shields.io/badge/dart-v2.16.2-blue)
![Flutter](https://img.shields.io/badge/flutter-v2.10.3-brightgreen)

## Installation

Install petstore with cloning my code then run these commands

```bash
  flutter pub get
  flutter run
```
    
## Documentation roadmap

- About

- Project structure

- Dependencies 

- what's in the code

- Demonstration

## About

this petstore app project is based on GETX Dependency for the state
management, dependency injection and route management. 

Petstore has a main page contains a list of available, pending and sold 
pets with the option of filtring pets by name.

by clicking on the pet image you can see all the details, also you can edit or delete it.

the application UI is designed using flutter native Material. 

NB: You will find a demostration about the application below.
## Project structure

In this section I will explain the hierarchy of the most important folders and files of the application.

I will start with the assets folder, this folder provides the application along three other folders with (image, fonts, and icons): 

- images: for the offline images.
- fonts: contains the custom fonts to use in app.
- icons: contains svgs icon.

to use those resources in my app I have declared them in public.yaml

![App Screenshot](https://i.ibb.co/ZcRpMWP/assets.png)

For saving time, I will explain the content of the lib folder which is considered the application source code folder and contains six sub-folders :

- animation folder: contains every custom animations.
- controllers folder: contains application methods and variables.
- data folder: contains the constants data of the project (global variables and serve connection string).
- models folder: contains the application models.
- service folder: contains the methods and classes that related with the server or the phone Hardware.
- utils folder: contains the list of tools.
- views folder: contains the list of interfaces and widgets.
- main.dart: the startup file.

![App Screenshot](https://i.ibb.co/stxtztj/lib.png)


## plugins

In this section I will talk a little bit about the application plugins, 
its features and why I used it (not all of them).

- flutter_svg: It is a plugin for Drawing SVG files on a Flutter Widget, I have used it for generting icons from svg files.
- getx: It's the most liked plugin in flutter and I have used it the managing the state, Navigation between application routes, diplaying alerts and dialogs and dependency injection...
- carousel_slider: For displaying multiple images at the same moment.
- dio: A powerful Http client, which supports FormData For that I have used it instead of HTTP.
- cached_network_image: A flutter library to show images from the internet and keep them in the cache directory.

## Code explication

In this section I will take a look at the application and its source code.
NB: you will find comments inside the code explaining every class or method job.

**main.dart**

This is the first startup class and I have replaced `MaterialApp` from `material.dart` by `GetMaterialApp` from Getx package to allow Get routing, then I have initializated my routes extending from routes.dart.

**Listening to pets**

To fetch the pets data in a store I have created as a first step the models of a pet,its category and a tag.
then I have created the view of the page as you can see In the picture:

![alt text](https://i.ibb.co/qmWgxSj/Screenshot-20220722-142455.jpg)

NB: I have declared petStorePage as a ``statelessWidgets`` and this one of the most feature of Getx that make it unnecessary for our pages to be
a ``StatefulWidgets`` anymore, and this will help us make the app faster.

After creating the UI I have crafted its controller (you will get more infos in code comments), on controller creation the system 
will call to get pets api so the list of pets will display using the combination of the ``RxList``variable (pets) in controller and GetX widget in view.
also I added another list that contains all pets to make filters.

**Deleting a pet**

For the deleting feature I added a delete button in every pet card, when the user click on it, the view will launch a method with pet id so it will send a deleting request to the simple server.
 then depending on the server response code, the controller will remove the pet from ``pets``  and ``allPets`` list (to minimize the number of requests).

**Edit and add**

Here I have used the same dialog for those two features (to improve performance). I have selected the right feature with the index of the pet selected in the list, 
that I have sent from the UI (add pet dialog when index equal to null and edit if not). 
when the user click to update an existant pet 
a details page appear containing the collection of its photos inside a carousel, the list of tags, its name and its status,
so the user can edit the pet name by modifying the text field with validator (name should be not empty and only text allows) and he can change its status from ``dropdownButton``. 

![alt text](https://i.ibb.co/ZfdbzC9/Screenshot-20220722-155709.jpg)

When User click on add button he will be able to add pet name, multilpe photos, pet status.

On creating pets the system will test first with :
`List<String> photoImages = imagefilesCounter.value == 0 ? [] : await gettingImagesUrlList();` 
if the user upload images or not.
 if yes the system will upload those images to cloud first then
it will get the list of its urls to create the pet with.

**Notes**

For any connection with the server I have made `PetService.dart`.

Inside of ``ThemeUtils`` I prepared two application themes for the light  and the dark mode.

I figure out that the list of pets urls are not all working for that 
I have used ``cached_network_image`` package to catchup if the image url 
accually works or not.


## Demonstration

You can find a full Demonstration video in this link:

[![Watch the video](https://i0.wp.com/www.regendus.com/wp-content/uploads/2020/01/YouTube-Keeps-Pausing-On-Android.jpg?fit=1258%2C712&ssl=1)](https://www.youtube.com/watch?v=Q04zwLT-wT0)

## Important

I can use Angular side by side with nodejs and flutter
## application

You can download the apk from this link:

https://drive.google.com/file/d/1fTTydyRgt4lIz8hHVSCBmgc9ZaNcY1f4/view?usp=sharing

or 

https://l.facebook.com/l.php?u=https%3A%2F%2Fwww.dropbox.com%2Fs%2Fnv0rwatdiclsxux%2Fpet_store_v2.apk%3Fdl%3D0%26fbclid%3DIwAR1L2TDv8HNraKljgo8wYsQezNDrQaO1C_HLXklbb6hAS-kL0nbpOoQFXPo&h=AT3U1asmwzFrnknwB0LIcwdNsOATE_VsBoEd5_v1U0yunQuIlRgAQVMA6MUU7LBY4MumuK-oxyTKAdzkyOMR2XrcHorirvJj6l4Gck1-vZLyo53ziQuj1mU7wANtNCcoYIljSA


You will find the git repository here:

https://www.youtube.com/watch?v=Q04zwLT-wT0
## Authors

- [@Bouhajja Alaeddine](https://github.com/Alaeddine2)


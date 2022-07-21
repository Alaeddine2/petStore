
# petstore

A simple flutter project to manage pets in a pets store.


## Installation

Install petstore with cloning my code then run those commandes

```bash
  flutter pub get
  flutter run
```
    
## Documentation roadmap

- About

- Project structure

- Dependencies explication

- Code explication


## About

I have created petstore project based on GETX Dependency for the project
management, dependency injection, and route management. 

Petstore has a main page contains a list of available, pending and sold 
pets with the option of filtring pets by tags, category or name.

by clicking on pet image you can see all it details also you can edit or delete it.

I have used the flutter native Material design. 

NB: You will find a demostration about the application below.
## Project structure

In this section I will explain the utils of the most important folders and files of the application.

I will start with the assets folder, this folder is the ressource of the application contains three other 
folders (image, fonts, and icons): 

- images: for the offline images.
- fonts: contains the custom fonts to use in app.
- icons: contains svgs icon.

to use those ressouces in my app I have declarated them in public.yaml

![App Screenshot](https://i.ibb.co/ZcRpMWP/assets.png)

For saving time, I will explain the content of lib folder directly,
the application source code folder contains six sub-folders as:

- animation folder: contains every custom animations.
- data folder: contains the constants data of the project (global variables and serve connection string).
- models folder: contains the application models.
- service folder: contains the methods and classes that related with the server or the phone Hardware.
- utils folder: contains the list of tools.
- views folder: contains the list of interfaces and widgets.
- main.dart: the startup file.

![App Screenshot](https://i.ibb.co/stxtztj/lib.png)



## Authors

- [@Bouhajja Alaeddine](https://github.com/Alaeddine2)


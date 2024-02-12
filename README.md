# QML-Playground
### Projects list
- [Circular Progress Bar](https://github.com/Radissan27/QML-Playground/tree/master/circular-progress-bar/App)
### Setup
- Install Qt (the open source version) via Qt Online Installer from this [link](https://www.qt.io/download-open-source)
    - :exclamation:Make sure to also download the MinGW compiler, don't be [this](https://www.reddit.com/r/QtFramework/comments/1ao5imr/help_with_linking_qt6_to_my_cmake_project/) guy :laughing:
- Install VS Code
  - also install relevant plugins for C++, CMake, QML etc.
- Add Qt MingW compiler to VS Code kits
  - CTRL + SHIFT + P > Open Settings (UI) > Cmake: Additional Compiler Search Dirs > Add Item > \<path-to-Qt-install-location\>\Tools\mingwXXXX_64 > Ok

### How to create a project
I haven't figured out how to work with CMake settings regarding Qt in order to add my QML files so the only way to create a project is via Qt Creator as follows:
1. Create Project
2. Projects: Application(Qt) | Qt Quick Application
3. Enter name and location
4. :exclamation:Make sure the "Create a project that you can open in Qt Design Studio" checkbock is NOT checked
5. Select minimum version of Qt
6. Select MinGW 64-bit kit
7. Add to version control: None

Now you can work on the project either from Qt Creator or VS Code and it will behave the same.

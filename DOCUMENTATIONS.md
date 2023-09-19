# Firebase CLI Setup in Flutter Project

## Configuration Level
01. Open terminal and run command => flutter doctor
02. Fix all bug 
03. Install Firebase CLI Tools by terminal=> sudo npm install -g firebase-tools (npm install -g firebase-tools, npm i -g firebase-tools)
04. Login authorization by command => firebase login
05. Allow permission (Y/n) and enter Y to allow
06. Open terminal from any directory to check Flutter CLI activation => dart pub global activate flutterfire_cli
07. Add directory path by terminal => echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bash_profile
08. Check this path=> tail -2 ~/.bash_profile

## Project level 
01. Create a flutter project by terminal => flutter create PROJECT_NAME --template=app --platforms=ios,android,macos,web --org=com.google.firebase.presents --project-name=PROJECT_NAME
02. Open project
03. Open project level terminal or write this command => cd PROJECT_NAME/
04. Write this code for setup (Optional) => code .
05. Add firebase_core library by terminal => flutter pub add firebase_core
06. Configure this project by terminal => flutterfire configure
07. Select current project by arrow keys or space
08. Select current platform by arrow keys or space (android, ios, macos, web, etc)
09. Go to current project main function 
10. Import those libraries: import 'package:firebase_core/firebase_core.dart'; import 'firebase_options.dart';
11. Rename function name like: void main() to Future<void> main() async
12. Initialize flutter widget binding inside the main function like: WidgetsFlutterBinding.ensureInitialized();
13. Initialize firebase app inside the main function like: await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
14. Run root function;

## Continue with Tutorial Links:
01. Official link => https://firebase.google.com/docs/cli
02. Video Link => https://www.youtube.com/watch?v=FkFvQ0SaT1I
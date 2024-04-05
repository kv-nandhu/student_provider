import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studnet_provider/database/model.dart';
import 'package:studnet_provider/provider/helperclass.dart';
import 'package:studnet_provider/screen/splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox<Studentupdates>('student');
  if(!Hive.isAdapterRegistered(StudentupdatesAdapter().typeId)) {
    Hive.registerAdapter(StudentupdatesAdapter());
  }
  runApp( MyApp());
}
// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 66, 11, 11))
        ),
        
        home: ScreenSplash(),
      ),
    );
  }
}


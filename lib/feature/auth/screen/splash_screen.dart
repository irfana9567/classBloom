
import 'package:classbloom/core/constants/color_const.dart';
import 'package:classbloom/core/constants/image_const.dart';
import 'package:classbloom/feature/auth/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/global_variable/global_variable.dart';
import '../../auth/controller/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 5)).then((value) =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),)),);
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        ref.read(AuthControllerProvider.notifier).keepLogin(context));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: h*0.2,
              width: w*0.4,
              child: SvgPicture.asset(iconConst.logo,color: Palette.blackColor,),
            ),
          ),
          Text("Class Bloom",style: TextStyle(
              fontSize: w*0.1,
              color: Colors.green
            ),),
        ],
      ),
    );
  }
}



// Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: SizedBox(
//               height:w*0.2,
//               width:w*0.4,
//               child:SvgPicture.asset(iconConst.logo,color: Colors.black,),
//             ),
//           ),
//           Center(
//             child: Text("Class Bloom",style: TextStyle(
//               fontSize: w*0.1,
//               color: Colors.green
//             ),),
//           )
//         ],
//       )
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/home/widgets/emergency_information_widget.dart';
import 'package:fluttertest/modules/home/widgets/emergency_widget.dart';
import 'package:fluttertest/modules/new_request/page/new_request.dart';
import 'package:fluttertest/modules/profile/page/profile.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final fullName = fp.getRegisterUserName();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // final newProfilePageKey = GlobalHelper.genKey();
                      // fp.addPage(
                      //   key: newProfilePageKey,
                      //   content: ProfilePage(globalKey: newProfilePageKey),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.gray1, // color de fondo
                          borderRadius: BorderRadius.circular(
                              size.width), // igual al ClipRRect
                        ),
                        child: ClipRRect(
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/18875/18875354.png",
                            width: size.height * 0.06,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TitleWidget(
                    title: 'Hola, ',
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  TitleWidget(
                    title: GlobalHelper().firstWord(fullName),
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  GlobalHelper.navigateToPageRemove(context, '/loginPage');
                },
                child: Container(
                  // color: AppTheme.primaryMedium,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.primaryMedium),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_sharp,
                        size: size.width * 0.08,
                        color: AppTheme.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        title: "Salir",
                        fontSize: size.height * 0.02,
                        color: AppTheme.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
            child: const EmergencyInformationWidget(),
          ),
          const EmergencyWidget(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.03),
            child: TextWidget(
              title: '¿Deseas crear una nueva solicitud?',
              fontSize: size.height * 0.015,
            ),
          ),
          Center(
            child: FilledButtonWidget(
              text: 'CREAR NUEVA SOLICITUD',
              height: size.height * 0.08,
              width: size.width * 0.03,
              color: AppTheme.primaryMedium,
              textButtonColor: AppTheme.white,
              onPressed: () {
                final newRequestPageKey = GlobalHelper.genKey();
                fp.addPage(
                  key: newRequestPageKey,
                  content: NewRequestPage(globalKey: newRequestPageKey),
                );
              },
            ),
          ),
          // const SearchWidget(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TitleWidget(
          //     title: 'Mis Solictudes',
          //     fontSize: size.height * 0.04,
          //     fontWeight: FontWeight.w500,
          //     color: AppTheme.black,
          //   ),
          // ),
          // MyRequestsWidget(
          //   size: size,
          // )
        ],
      ),
    );
  }
}

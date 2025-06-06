import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/home/widgets/emergency_information_widget.dart';
import 'package:fluttertest/modules/home/widgets/emergency_widget.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late FunctionalProvider fp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fp = Provider.of<FunctionalProvider>(context, listen: false);
      fp.clearAllPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FunctionalProvider>(builder: (context, fp, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.gray1, // color de fondo
                          borderRadius:
                              BorderRadius.circular(size.width), // igual al ClipRRect
                        ),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/5231/5231019.png",
                            width: size.height * 0.06,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    TitleWidget(
                      title: 'Hola, ',
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                    TitleWidget(
                      title: 'Carolina',
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          GlobalHelper.navigateToPageRemove(
                              context, '/loginPage');
                        },
                        color: AppTheme.primaryMedium,
                        icon: Icon(
                          Icons.logout_sharp,
                          size: size.width * 0.1,
                        )),
                    TextWidget(
                      title: "Salir",
                      fontSize: size.height * 0.02,
                      color: AppTheme.primaryMedium,
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
              child: const EmergencyInformationWidget(),
            ),
            EmergencyWidget(),
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
                  GlobalHelper.navigateToPageRemove(context, '/newRequest');
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
    });
  }
}

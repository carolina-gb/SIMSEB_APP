import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/modules/home/widgets/my_requests_widget.dart';
import 'package:fluttertest/modules/home/widgets/search_widget.dart';
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
      return Stack(
        children: [
          Container(
            // color: AppTheme.naturalsMedium,
            height: size.height * 0.3,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                color: AppTheme.naturalsMedium),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          title: 'Bienvenido, ',
                          fontSize: size.height * 0.04,
                        ),
                        TextWidget(
                          title: 'Carolina González',
                          fontSize: size.height * 0.03,
                          color: AppTheme.primaryDarkest,
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                         GlobalHelper.navigateToPageRemove(context, '/loginPage');
                        },
                        icon: Icon(Icons.logout_sharp, size: size.width * 0.1,))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.035, bottom: size.height * 0.035),
                  child: FilledButtonWidget(
                    text: 'NUEVA SOLICITUD',
                    height: size.height * 0.08,
                    color: AppTheme.warning,
                    textButtonColor: AppTheme.black,
                    onPressed: () {
                       GlobalHelper.navigateToPageRemove(context, '/newRequest');
                    },
                  ),
                ),
                const SearchWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TitleWidget(
                    title: 'Mis Solictudes',
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.black,
                  ),
                ),
                MyRequestsWidget(
                  size: size,
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

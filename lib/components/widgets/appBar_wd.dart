import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ims_app/components/widgets/exit_button.dart';
import 'package:ims_app/utils/size_config.dart';

class AppBarWD extends StatelessWidget  implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final Widget? bottomWidget;


  const AppBarWD({super.key, required this.title, this.titleWidget, this.leading, this.bottomWidget});

  @override
  AppBar build(BuildContext context) {
    // TODO: implement build
    return _buildContent(context);
  }


  AppBar _buildContent(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height, // Set this height
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,

        // Status bar brightness (optional)
        statusBarIconBrightness:
        Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      leading: const SizedBox(),
      flexibleSpace: Padding(
        padding:  EdgeInsets.only(left: 10*SC.screenWidthProportion,right: 10*SC.screenWidthProportion,top: SC.getHeightStatusBar(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leading ?? const SizedBox(),

                titleWidget ??
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18 * SC.screenHeightProportion,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  const ExitButton(),
              ],),
            ),
            bottomWidget ?? SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(SC.screenWidth, SC.screenHeight * 0.12);


}

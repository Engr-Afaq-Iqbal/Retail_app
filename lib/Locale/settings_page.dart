import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Components/bottom_bar.dart';
import '/Config/app_config.dart';
import '/Locale/language_cubit.dart';
import '/Pages/login.dart';
import '/Services/storage_services.dart';
import '/Theme/colors.dart';

class LanguageList {
  final String? title;

  LanguageList({this.title});
}

class Settings extends StatefulWidget {
  final isForSetting;
  final bool allowToNaviGate;
  Settings({
    this.isForSetting = false,
    this.allowToNaviGate = true,
  });
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool sliderValue = false;
  late LanguageCubit _languageCubit;
  String? selectedLocal;

  addLanguageToSF(String localeLanguage, String localeCountryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('localeLanguage', localeLanguage);
    prefs.setString('localeCountryCode', localeCountryCode);
  }

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('change_language'.tr, //'Change Language',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold)),
        titleSpacing: 0,
        leading: widget.isForSetting
            ? IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              BlocBuilder<LanguageCubit, Locale>(
                builder: (context, currentLocale) {
                  selectedLocal ??= currentLocale.languageCode;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: AppConfig.languagesSupported.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RadioListTile(
                      value: AppConfig.languagesSupported.keys.elementAt(index),
                      groupValue: selectedLocal,
                      title: Text(
                        AppConfig
                            .languagesSupported[AppConfig
                                .languagesSupported.keys
                                .elementAt(index)]!
                            .name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: blackColor),
                      ),
                      onChanged: (langCode) => setState(() {
                        selectedLocal = langCode as String;
                      }),
                    ),
                  );
                },
              ),
              SizedBox(height: 100),
            ],
            physics: BouncingScrollPhysics(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(
              text: 'submit'.tr, //AppLocalization.of(context)!.addOptions!,
              onTap: () async {
                await AppStorage.setLocalizationData(selectedLocal);
                /*
                _languageCubit.setCurrentLanguage(AppStorage.lang, true);
                */
                _languageCubit.setCurrentLanguage(selectedLocal!, true);

                print(selectedLocal);
                if (selectedLocal == 'ar') {
                  addLanguageToSF('ar', 'AR');
                  Get.updateLocale(Locale('ar', 'AR'));
                } else if (selectedLocal == 'en') {
                  addLanguageToSF('en', 'US');
                  Get.updateLocale(Locale('en', 'US'));
                } else if (selectedLocal == 'pt') {
                  addLanguageToSF('pt', 'PT');
                  Get.updateLocale(Locale('pt', 'PT'));
                } else if (selectedLocal == 'fr') {
                  addLanguageToSF('fr', 'FR');
                  Get.updateLocale(Locale('fr', 'FR'));
                } else if (selectedLocal == 'id') {
                  addLanguageToSF('id', 'ID');
                  Get.updateLocale(Locale('id', 'ID'));
                } else if (selectedLocal == 'es') {
                  addLanguageToSF('es', 'SP');
                  Get.updateLocale(Locale('es', 'SP'));
                } else if (selectedLocal == 'it') {
                  addLanguageToSF('it', 'IT');
                  Get.updateLocale(Locale('it', 'IT'));
                } else if (selectedLocal == 'tr') {
                  addLanguageToSF('tr', 'TR');
                  Get.updateLocale(Locale('tr', 'TR'));
                } else if (selectedLocal == 'sw') {
                  addLanguageToSF('sw', 'SW');
                  Get.updateLocale(Locale('sw', 'SW'));
                } else if (selectedLocal == 'de') {
                  addLanguageToSF('de', 'GR');
                  Get.updateLocale(Locale('de', 'GR'));
                } else if (selectedLocal == 'ro') {
                  addLanguageToSF('ro', 'RO');
                  Get.updateLocale(Locale('ro', 'RO'));
                }
                if (widget.allowToNaviGate)
                  Get.offAll(LoginPage()); //TableSelectionPage());
                else {
                  Get.back();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

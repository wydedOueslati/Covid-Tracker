import 'dart:convert';

import 'package:covid19_news/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';


final prevention = [
  {'assets/images/distance.png':LocaleKeys.avoid_close.tr() +'\n'+LocaleKeys.contact.tr()},
  {'assets/images/wash_hands.png': LocaleKeys.clean_your_hands.tr()+'\n'+LocaleKeys.often.tr()},
  {'assets/images/mask.png': LocaleKeys.wear_a.tr()+'\n'+LocaleKeys.facemask.tr()},
];


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../config/config.dart';

class BoxIconsPicker {
  static Future<IconData?> showModal(BuildContext context) async {
    return await showModalBottomSheet<IconData?>(
      context: context,
      builder: (_) => _BoxIconsView(),
    );
  }
}

class _BoxIconsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(title: Text('Accessibility')),
            _BuildIcons(icons: _Categories.accessibility),
            ListTile(title: Text('Alert')),
            _BuildIcons(icons: _Categories.alert),
            ListTile(title: Text('Building')),
            _BuildIcons(icons: _Categories.building),
            ListTile(title: Text('Business')),
            _BuildIcons(icons: _Categories.business),
            ListTile(title: Text('Code')),
            _BuildIcons(icons: _Categories.code),
            ListTile(title: Text('Communication')),
            _BuildIcons(icons: _Categories.communication),
            ListTile(title: Text('Design')),
            _BuildIcons(icons: _Categories.design),
            ListTile(title: Text('Device')),
            _BuildIcons(icons: _Categories.device),
            ListTile(title: Text('E-Commerce')),
            _BuildIcons(icons: _Categories.ecommerce),
            ListTile(title: Text('Emoji')),
            _BuildIcons(icons: _Categories.emoji),
            ListTile(title: Text('Files & Folders')),
            _BuildIcons(icons: _Categories.filesAndFolders),
            ListTile(title: Text('Finance')),
            _BuildIcons(icons: _Categories.finance),
            ListTile(title: Text('Food & Beverage')),
            _BuildIcons(icons: _Categories.foodAndBeverage),
            ListTile(title: Text('Health')),
            _BuildIcons(icons: _Categories.health),
            Gap(defaultPadding * 2),
          ],
        ),
      ),
    );
  }
}

class _BuildIcons extends StatelessWidget {
  const _BuildIcons({required this.icons});

  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Wrap(
      spacing: defaultPadding,
      children: icons
          .map(
            (e) => IconButton(
              onPressed: () => Navigator.pop(context, e),
              icon: Icon(e, color: colors.primary),
            ),
          )
          .toList(),
    );
  }
}

class _Categories {
  static const accessibility = [
    BoxIcons.bx_universal_access,
    BoxIcons.bx_accessibility,
    BoxIcons.bx_captions,
    BoxIcons.bx_info_circle,
    BoxIcons.bx_question_mark,
    BoxIcons.bx_body,
    BoxIcons.bx_handicap,
    BoxIcons.bx_help_circle,
    BoxIcons.bx_info_square,
    BoxIcons.bx_low_vision,
    BoxIcons.bx_braille,
  ];

  static const alert = [
    BoxIcons.bx_error_alt,
    BoxIcons.bx_bell_minus,
    BoxIcons.bx_bell_off,
    BoxIcons.bx_bell_plus,
    BoxIcons.bx_bell,
    BoxIcons.bx_error_circle,
    BoxIcons.bx_error,
  ];

  static const building = [
    BoxIcons.bx_hard_hat,
    BoxIcons.bx_home_alt_2,
    BoxIcons.bx_buildings,
    BoxIcons.bx_building_house,
    BoxIcons.bx_home,
    BoxIcons.bx_home_alt,
    BoxIcons.bx_home_circle,
    BoxIcons.bx_arch,
    BoxIcons.bx_home_heart,
    BoxIcons.bx_church,
    BoxIcons.bx_home_smile,
  ];

  static const business = [
    BoxIcons.bx_scatter_chart,
    BoxIcons.bx_bar_chart_alt_2,
    BoxIcons.bx_slideshow,
    BoxIcons.bx_line_chart,
    BoxIcons.bx_pie_chart_alt_2,
    BoxIcons.bx_briefcase_alt_2,
    BoxIcons.bx_sticker,
    BoxIcons.bx_paper_plane,
    BoxIcons.bx_note,
    BoxIcons.bx_pin,
    BoxIcons.bx_task,
    BoxIcons.bx_paperclip,
  ];

  static const code = [
    BoxIcons.bx_shield_minus,
    BoxIcons.bx_shield_plus,
    BoxIcons.bx_math,
    BoxIcons.bx_qr,
    BoxIcons.bx_qr_scan,
    BoxIcons.bx_bug_alt,
    BoxIcons.bx_code,
    BoxIcons.bx_check_shield,
    BoxIcons.bx_bug,
    BoxIcons.bx_terminal,
    BoxIcons.bx_data,
    BoxIcons.bx_command,
  ];

  static const communication = [
    BoxIcons.bx_phone,
    BoxIcons.bx_message,
    BoxIcons.bx_microphone,
    BoxIcons.bx_send,
    BoxIcons.bx_voicemail,
    BoxIcons.bx_support,
    BoxIcons.bx_envelope,
    BoxIcons.bx_share,
    BoxIcons.bx_hash,
    BoxIcons.bx_at,
    BoxIcons.bx_chat,
    BoxIcons.bx_dialpad,
  ];

  static const design = [
    BoxIcons.bx_color,
    BoxIcons.bx_paint_roll,
    BoxIcons.bx_palette,
    BoxIcons.bx_brush_alt,
    BoxIcons.bx_brush,
    BoxIcons.bx_paint,
    BoxIcons.bx_spray_can,
    BoxIcons.bx_color_fill,
    BoxIcons.bx_eraser,
    BoxIcons.bx_vector,
  ];

  static const device = [
    BoxIcons.bx_memory_card,
    BoxIcons.bx_mouse_alt,
    BoxIcons.bx_printer,
    BoxIcons.bx_desktop,
    BoxIcons.bx_devices,
    BoxIcons.bx_laptop,
    BoxIcons.bx_mobile_alt,
    BoxIcons.bx_usb,
    BoxIcons.bx_joystick,
    BoxIcons.bx_mouse,
    BoxIcons.bx_radar,
    BoxIcons.bx_battery,
    BoxIcons.bx_child,
    BoxIcons.bx_tv,
    BoxIcons.bx_fingerprint,
    BoxIcons.bx_hdd,
  ];

  static const ecommerce = [
    BoxIcons.bx_cart_add,
    BoxIcons.bx_cart_download,
    BoxIcons.bx_store_alt,
    BoxIcons.bx_basket,
    BoxIcons.bx_purchase_tag,
    BoxIcons.bx_receipt,
    BoxIcons.bx_gift,
    BoxIcons.bx_cart,
    BoxIcons.bx_package,
    BoxIcons.bx_shopping_bag,
    BoxIcons.bx_barcode,
    BoxIcons.bx_store,
    BoxIcons.bx_closet,
  ];

  static const emoji = [
    BoxIcons.bx_party,
    BoxIcons.bx_ghost,
    BoxIcons.bx_meh_alt,
    BoxIcons.bx_wink_tongue,
    BoxIcons.bx_happy_alt,
    BoxIcons.bx_cool,
    BoxIcons.bx_tired,
    BoxIcons.bx_smile,
    BoxIcons.bx_angry,
    BoxIcons.bx_happy_heart_eyes,
    BoxIcons.bx_dizzy,
    BoxIcons.bx_wink_smile,
    BoxIcons.bx_confused,
    BoxIcons.bx_sleepy,
    BoxIcons.bx_shocked,
    BoxIcons.bx_happy_beaming,
    BoxIcons.bx_meh_blank,
    BoxIcons.bx_laugh,
    BoxIcons.bx_upside_down,
    BoxIcons.bx_happy,
    BoxIcons.bx_meh,
    BoxIcons.bx_sad,
    BoxIcons.bx_bot,
  ];

  static const filesAndFolders = [
    BoxIcons.bx_file_find,
    BoxIcons.bx_archive_in,
    BoxIcons.bx_archive_out,
    BoxIcons.bx_folder_minus,
    BoxIcons.bx_folder_plus,
    BoxIcons.bx_folder,
    BoxIcons.bx_archive,
    BoxIcons.bx_file,
    BoxIcons.bx_export,
    BoxIcons.bx_folder_open,
    BoxIcons.bx_import,
    BoxIcons.bx_box,
    BoxIcons.bx_file_blank,
  ];

  static const finance = [
    BoxIcons.bx_money_withdraw,
    BoxIcons.bx_candles,
    BoxIcons.bx_wallet_alt,
    BoxIcons.bx_credit_card_alt,
    BoxIcons.bx_bitcoin,
    BoxIcons.bx_lira,
    BoxIcons.bx_ruble,
    BoxIcons.bx_rupee,
    BoxIcons.bx_euro,
    BoxIcons.bx_pound,
    BoxIcons.bx_won,
    BoxIcons.bx_yen,
    BoxIcons.bx_shekel,
    BoxIcons.bx_dollar,
    BoxIcons.bx_credit_card,
    BoxIcons.bx_wallet,
    BoxIcons.bx_dollar_circle,
    BoxIcons.bx_money,
    BoxIcons.bx_coin,
    BoxIcons.bx_coin_stack,
    BoxIcons.bx_donate_heart,
  ];

  static const foodAndBeverage = [
    BoxIcons.bx_sushi,
    BoxIcons.bx_cheese,
    BoxIcons.bx_lemon,
    BoxIcons.bx_baguette,
    BoxIcons.bx_fork,
    BoxIcons.bx_knife,
    BoxIcons.bx_bowl_rice,
    BoxIcons.bx_bowl_hot,
    BoxIcons.bx_popsicle,
    BoxIcons.bx_fridge,
    BoxIcons.bx_dish,
    BoxIcons.bx_cake,
    BoxIcons.bx_food_tag,
    BoxIcons.bx_food_menu,
    BoxIcons.bx_coffee,
    BoxIcons.bx_beer,
    BoxIcons.bx_coffee_togo,
    BoxIcons.bx_wine,
    BoxIcons.bx_drink,
    BoxIcons.bx_cookie,
  ];

  static const health = [
    BoxIcons.bx_shower,
    BoxIcons.bx_injection,
    BoxIcons.bx_dna,
    BoxIcons.bx_plus_medical,
    BoxIcons.bx_band_aid,
    BoxIcons.bx_health,
    BoxIcons.bx_clinic,
    BoxIcons.bx_heart,
    BoxIcons.bx_pulse,
    BoxIcons.bx_first_aid,
    BoxIcons.bx_dumbbell,
    BoxIcons.bx_bed,
    BoxIcons.bx_bath,
    BoxIcons.bx_test_tube,
    BoxIcons.bx_heart_circle,
    BoxIcons.bx_heart_square,
    BoxIcons.bx_blanket,
    BoxIcons.bx_bone,
    BoxIcons.bx_bong,
    BoxIcons.bx_brain,
    BoxIcons.bx_vial,
    BoxIcons.bx_capsule,
    BoxIcons.bx_donate_blood,
  ];
}

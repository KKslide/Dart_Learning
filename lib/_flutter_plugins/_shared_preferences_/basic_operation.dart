import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  // late SharedPreferences _prefs; // 老写法
  late SharedPreferencesAsync _prefs; // 新写法
  int _current_tab = 1;

  @override
  void initState() {
    super.initState();
    // 初始化 SharedPreferences 实例
    _initSharedPreferences();

  }

  Future<void> _initSharedPreferences() async {
    // _prefs = await SharedPreferences.getInstance();
    _prefs = SharedPreferencesAsync();
  }

  List<Widget> _renderSetButtons () {
    return [
      TextButton(
        onPressed: () async { await _prefs.setInt('counter', 10); }, 
        child: Text('SetInt')
      ),
      TextButton(
        onPressed: () async { await _prefs.setBool('repeat', true); }, 
        child: Text('SetBool')
      ),
      TextButton(
        onPressed: () async { await _prefs.setDouble('decimal', 1.5); }, 
        child: Text('SetDouble')
      ),
      TextButton(
        onPressed: () async { await _prefs.setString('action', 'Start'); }, 
        child: Text('SetString')
      ),
      TextButton(
        onPressed: () async { await _prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']); }, 
        child: Text('SetList')
      ),
    ];
  }

  List<Widget> _renderGetButtons () {
    return [
      TextButton(
        onPressed: () async { 
          final int? counter = await _prefs.getInt('counter'); 
          print('counter value: $counter');
        }, 
        child: Text('Get Int')
      ),
      TextButton(
        onPressed: () async { final bool? repeat = await _prefs.getBool('repeat'); }, 
        child: Text('Get Bool')
      ),
      TextButton(
        onPressed: () async { final double? decimal = await _prefs.getDouble('decimal'); }, 
        child: Text('Get Double')
      ),
      TextButton(
        onPressed: () async { final String? action = await _prefs.getString('action'); }, 
        child: Text('Get String')
      ),
      TextButton(
        onPressed: () async { final List<String>? items = await _prefs.getStringList('items'); }, 
        child: Text('Get List')
      ),
    ];
  }

  List<Widget> _renderRemoveButtons () {
    return [
      TextButton(
        onPressed: () async { await _prefs.remove('counter'); }, 
        child: Text('RemoveInt')
      ),
      TextButton(
        onPressed: () async { await _prefs.remove('repeat'); }, 
        child: Text('RemoveBool')
      ),
      TextButton(
        onPressed: () async { await _prefs.remove('decimal'); }, 
        child: Text('RemoveDouble')
      ),
      TextButton(
        onPressed: () async { await _prefs.remove('action'); }, 
        child: Text('RemoveString')
      ),
      TextButton(
        onPressed: () async { await _prefs.remove('items'); }, 
        child: Text('RemoveList')
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('localstorage'),
      ),
      body: Column(
        children: [
          Text('check local storage by open the plugin page=>>> $_current_tab'),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => setState(() => _current_tab = 1), 
                child: Text('Set')
              ),
              TextButton(
                onPressed: () => setState(() => _current_tab = 2), 
                child: Text('Get')
              ),
              TextButton(
                onPressed: () => setState(() => _current_tab = 3), 
                child: Text('Remove')
              ),
              TextButton(
                onPressed: () => setState(() => _current_tab = 4), 
                child: Text('Clear')
              ),
            ],
          ),
          Divider(),
          Column(
            children: switch (_current_tab) {
              1 => _renderSetButtons(),
              2 => _renderGetButtons(),
              3 => _renderRemoveButtons(),
              4 => [
                TextButton(
                  onPressed: () async {
                    await _prefs.clear();
                  }, 
                  child: Text('Clear everything')
                )
              ],
              _ => [Text('')]
            }
          )
        ],
      ),
    );
  }
}


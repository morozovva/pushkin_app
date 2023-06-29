package com.example.pushkin_app

import io.flutter.embedding.android.FlutterActivity

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("dd2ecff0-59f7-49e5-9cfc-971e0a3ca1df") // Your generated API key
    super.configureFlutterEngine(flutterEngine)
  }
}
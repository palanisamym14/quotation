package com.quotation.quotation

import android.content.*
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.core.content.PermissionChecker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.util.Log
import androidx.annotation.NonNull
import android.net.Uri

import java.io.File


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "launchFile")
                .setMethodCallHandler { call, result ->
                    if (call.method.equals("viewPdf") || call.method.equals("viewExcel")) {
                        print(call)
                        val path: String? =  call.argument("file_path")
                        if (!checkPermission(android.Manifest.permission.READ_EXTERNAL_STORAGE)) {
                            requestPermission(arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE))
                        } else {
                            if(path != null)
                             launchFile(path)
                        }
                    }
                }
    }

    private fun requestPermission(permission: Array<String>) {
        ActivityCompat.requestPermissions(this, permission, 1)
    }

    private fun checkPermission(permission: String): Boolean {
        return if (VERSION.SDK_INT < VERSION_CODES.M) {
            true
        } else {
            if (ContextCompat.checkSelfPermission(this, permission) === PermissionChecker.PERMISSION_GRANTED) {
                true
            } else {
                false
            }
        }
    }

    private fun launchFile(filePath: String) {
        val file = File(filePath)
        if (file.exists()) {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
            intent.addCategory("android.intent.category.DEFAULT")
            var uri: Uri? = null
            uri = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                val packageName: String = this.getPackageName()
                FileProvider.getUriForFile(this, "$packageName.fileProvider", File(filePath))
            } else {
                Uri.fromFile(file)
            }
            if (filePath.contains(".pdf")) intent.setDataAndType(uri, "application/pdf") else intent.setDataAndType(uri, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            try {
                this.startActivity(intent)
            } catch (e: Exception) {
                //Could not launch the file.
            }
        }
    }
}
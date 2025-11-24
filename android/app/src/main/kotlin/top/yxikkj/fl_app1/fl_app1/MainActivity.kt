package top.yxikkj.app1

import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 启用高刷新率模式
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Android 11 (API 30) 及以上
            window.attributes.preferredDisplayModeId = getHighestRefreshRateModeId()
        } else {
            // Android 6.0 (API 23) 到 Android 10 (API 29)
            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
            val params = window.attributes
            params.preferredRefreshRate = getHighestRefreshRateValue()
            window.attributes = params
        }
    }

    private fun getHighestRefreshRateModeId(): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val display = display
            if (display != null) {
                val modes = display.supportedModes
                var maxRefreshRate = 60f
                var modeId = 0

                modes.forEach { mode ->
                    if (mode.refreshRate > maxRefreshRate) {
                        maxRefreshRate = mode.refreshRate
                        modeId = mode.modeId
                    }
                }
                return modeId
            }
        }
        return 0
    }

    private fun getHighestRefreshRateValue(): Float {
        val display = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            display
        } else {
            @Suppress("DEPRECATION")
            windowManager.defaultDisplay
        }

        if (display != null) {
            val modes = display.supportedModes
            var maxRefreshRate = 60f

            modes.forEach { mode ->
                if (mode.refreshRate > maxRefreshRate) {
                    maxRefreshRate = mode.refreshRate
                }
            }
            return maxRefreshRate
        }
        return 60f
    }
}

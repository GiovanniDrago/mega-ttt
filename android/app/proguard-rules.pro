# Flutter specific
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# SharedPreferences
-keep class androidx.lifecycle.** { *; }

# URL Launcher
-keep class androidx.browser.** { *; }

# OkHttp / HTTP client
-dontwarn okhttp3.**
-dontwarn okio.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# Package info
-keep class androidx.core.** { *; }

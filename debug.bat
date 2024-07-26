@echo off

set isEmulator=true

if "%isEmulator%"=="false" (
adb connect localhost:5554
adb -s emulator-5554 install build/src/android-build/build/outputs/apk/debug/android-build-debug.apk
) else (
adb -d install build/src/android-build/build/outputs/apk/debug/android-build-debug.apk
)

adb shell am start -n com.cypetech.ShoppingList/org.qtproject.qt.android.bindings.QtActivity

:MyLabel
for /f "delims=" %%a in ('adb shell pidof com.cypetech.ShoppingList') do set pid=%%a
if "%pid%"=="" goto MyLabel
adb logcat | findstr %pid%
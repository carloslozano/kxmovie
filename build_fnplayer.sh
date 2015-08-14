RUN_CLANG_STATIC_ANALYZER=NO xcodebuild -configuration Release -target kxmovie -sdk iphoneos -localizationPath clean build
RUN_CLANG_STATIC_ANALYZER=NO xcodebuild -configuration Release -target kxmovie -sdk iphonesimulator -localizationPath clean build  
lipo -create -output libFNPlayer.a build/Release-iphoneos/libkxmovie.a build/Release-iphonesimulator/libkxmovie.a

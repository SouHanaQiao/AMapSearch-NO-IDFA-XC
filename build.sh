# AMapSearch-NO-IDFA (9.7.0)
curl https://a.amap.com/lbs/static/zip/AMap_iOS_Search_Lib_V9.7.0.zip -o AMapSearch-NO-IDFA.zip
unzip AMapSearch-NO-IDFA.zip -d AMapSearch-NO-IDFA

xcframeworkName="AMapSearchKit"

function process {
    L_PATH=$1
    OUTPUT_PATH=$2
    lipo $L_PATH/$xcframeworkName.framework/$xcframeworkName -thin arm64 -output $L_PATH/$xcframeworkName-arm64
    lipo $L_PATH/$xcframeworkName.framework/$xcframeworkName -thin armv7 -output $L_PATH/$xcframeworkName-armv7
    lipo $L_PATH/$xcframeworkName.framework/$xcframeworkName -thin x86_64 -output $L_PATH/$xcframeworkName-x86_64
    lipo $L_PATH/$xcframeworkName.framework/$xcframeworkName -thin arm64 -output $L_PATH/$xcframeworkName-sim-arm64

    mkdir $L_PATH/o
    
    cd $L_PATH/o

    ar x ../$xcframeworkName-sim-arm64

    ../../script.sh ./ arm64 9.0 15.5
        
    ar crv ../$xcframeworkName-sim-arm64 ./*.o
    
    cd ../../

    lipo -create -output $L_PATH/$xcframeworkName-armv7_arm64 $L_PATH/$xcframeworkName-armv7 $L_PATH/$xcframeworkName-arm64
    lipo -create -output $L_PATH/$xcframeworkName-arm64_x86_64 $L_PATH/$xcframeworkName-sim-arm64 $L_PATH/$xcframeworkName-x86_64

    mkdir $L_PATH/iphone-os $L_PATH/iphone-sim
    cp -r $L_PATH/$xcframeworkName.framework $L_PATH/iphone-os
    cp -r $L_PATH/$xcframeworkName.framework $L_PATH/iphone-sim

    cp $L_PATH/$xcframeworkName-armv7_arm64 $L_PATH/iphone-os/$xcframeworkName.framework/$xcframeworkName
    cp $L_PATH/$xcframeworkName-arm64_x86_64 $L_PATH/iphone-sim/$xcframeworkName.framework/$xcframeworkName

    rm -rf $OUTPUT_PATH/*

    xcodebuild -create-xcframework -framework $L_PATH/iphone-os/$xcframeworkName.framework -framework $L_PATH/iphone-sim/$xcframeworkName.framework -output $OUTPUT_PATH/$xcframeworkName.xcframework

#    zip -r $OUTPUT_PATH.zip $OUTPUT_PATH
    cd $OUTPUT_PATH
    zip -r $L_PATH.zip $xcframeworkName.xcframework
    mv $L_PATH.zip ../$L_PATH.zip
    cd ../../
}


process 'AMapSearch-NO-IDFA' './output/AMapSearch-NO-IDFA'

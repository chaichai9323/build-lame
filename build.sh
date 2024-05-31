#!/bin/bash

cd "$(cd "$(dirname "$0")"; pwd)"
curDir=$(pwd)

sourceDir="$1"

archs=("arm64" "x86_64")
minversion="13.0"

libs=""

cd $sourceDir

for ((i=0; i < ${#archs[@]}; i++))
do
  	arch=${archs[$i]}
  	host=""
  	platform=""
  	flag=""
  	if [ $arch == "arm64" ]; then
  		host="arm-apple-darwin"
  		platform="iphoneos"
  		flag="iphoneos"
  	else
  		host="x86_64-apple-darwin"
  		platform="iphonesimulator"
  		flag="ios-simulator"
  	fi

  	./configure \
  	--disable-shared \
  	--disable-frontend \
  	--host=$host \
  	--prefix=$curDir/$arch \
  	CC="xcrun -sdk $platform clang -arch $arch" \
  	CFLAGS="-arch $arch -m${flag}-version-min=${minversion}" \
  	LDFLAGS="-arch $arch -m${flag}-version-min=${minversion}"
  	make clean
	make -j8
	make install

	libs=$libs"$arch/lib/libmp3lame.a "
done

cd $curDir

lipo -create $libs -output Mp3Lame/Mp3Lame/libmp3lame.a

cp -f $curDir/${archs[0]}/include/lame/* Mp3Lame/Mp3Lame/

for i in ${archs[@]}; do
	rm -rf $i
done

sh exportXCFramework.sh Mp3Lame/Mp3Lame.xcodeproj

cd $curDir

git checkout .

# echo $arch"完成"
#!/bin/sh

#script name：filename.sh
sourcedir=$1
arch=$2
minVersion=$3
sdk=$4

echo sourcedir: $1, arch: $2, minVersion: $3, sdk: $4
cd $sourcedir

list_alldir(){
    for file2 in `ls -a $1`
    do
       if [ x"$file2" != x"." -a x"$file2" != x".." ];then
            if [ -d "$1/$file2" ];then
                echo "$1/$file2"
                list_alldir "$1/$file2"
            fi
        fi
    done
} 
names=$(list_alldir $sourcedir)
echo " " > names.txt
for j in ${names[*]} $1
do
        echo $j

        ls -l $j | awk '/^-.*/{print tmpname1$9}' tmpname1="$tmpname" | sed '/^ *$/d ' >> names.txt
done

totals=$(cat names.txt | wc -l)
array=$(awk '/.*\.[ch]$/{print $1}
        /.*\.cc$/{print $1;}
        /.*\.cpp$/{print $1;}
        /.*\.o$/{print $1;}
' names.txt)
for j in ${array[*]}
do
        echo '开始转换' $j
#        xcrun vtool -arch $arch -set-build-version 7 $minVersion $sdk -replace -output $j $j
        ../../arm64-to-simulator $j 9 15 false
        echo '转换 ' $j  ' 结果'
        xcrun vtool -arch arm64 -show $j
done

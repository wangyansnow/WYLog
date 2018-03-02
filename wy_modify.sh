#! /bin/bash

function wy_modify() {
    target=$1
    target_temp=${target}+".temp"

    sed -e 's/wangyansnow. All/wangyansnow All/g' ${target} > ${target_temp}
    mv ${target_temp} ${target}
}

function wy_read_dir() {
    for wy_file in `ls $1` #注意此处这是两个反引号，表示运行系统命令
    do

    if [ -f $1"/"$wy_file ]
    then
        if [[ $wy_file =~ \.swift$ ]]
        then
            wy_modify $1"/"$wy_file
        fi

        if [[ $wy_file =~ \.h$ ]]
        then
            wy_modify $1"/"$wy_file
        fi

        if [[ $wy_file =~ \.m$ ]]
        then
            wy_modify $1"/"$wy_file
        fi
    fi
    if [ -d $1"/"$wy_file ]
    then
        wy_read_dir  $1"/"$wy_file
    fi

    done
}

sh_path=$(cd "$(dirname "${BASH_SOURCE-$0}")"; pwd)
#读取第一个参数
wy_read_dir ${sh_path}

git add .
git commit -m "去掉github连接后面的."
git pull
git push





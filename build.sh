#!/bin/bash

# エラーを踏んだらそこで停止
set -e

# 今日の日付を yyyymmdd 形式で取得
DATE=$(date '+%Y%m%d')

# 対象ファイル
SOURCE="./index.html"
OUT_DIR="out"
RELEASE_DIR="release"
DIST_FILE="${OUT_DIR}/index.html"
ZIP_NAME="index_${DATE}.zip"
ZIP_PATH="${RELEASE_DIR}/${ZIP_NAME}"

# 初期化
rm -rf $OUT_DIR 
rm -rf $RELEASE_DIR 
mkdir -p $OUT_DIR
mkdir -p $RELEASE_DIR
chmod 755 $OUT_DIR
chmod 755 $RELEASE_DIR


# sedコマンドで置換処理 
echo "バージョン表記を書き換えます:" $DATE
if sed "s/RELEASE_DATE/${DATE}/g" ${SOURCE} > ${DIST_FILE}; then
    echo "書き換え完了" 
else
    echo "書き換え失敗"
fi

# パーミッションを直しておく
chmod 644 $DIST_FILE

# 置換後のファイルを圧縮して zip 形式にする
echo "ファイルを圧縮します:${DIST_FILE}>${ZIP_PATH}"
if [ $COMSPEC != "" ]; then
    # windows powershell
    echo "powershell mode"
    if ! powershell compress-archive $DIST_FILE $ZIP_PATH; then
        echo "${DIST_FILE}の圧縮に失敗しました。"
    fi
else
    # maybe unix OS
    echo "zip mode"
    if ! zip $ZIP_PATH  $DIST_FILE; then
        echo "${DIST_FILE}の圧縮に失敗しました。"
    fi    
fi

echo "$ZIP_PATH released"

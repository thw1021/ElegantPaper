#! /bin/bash
#
# build.sh
# Copyright (C) 2019 Guowei Chen <icgw@outlook.com>
#
# Distributed under terms of the GPL license.
#
set -e

#
# 获取 TeX 文件名
#
# if [[ $# == "1" ]]; then
#   fileName=$1
# else
#   echo "---------------------------------------------------------------------------"
#   echo "Usage: "$0" <filename>"
#   echo "TeX engine pdflatex"
#   echo "Bib engine bibtex"
#   echo "---------------------------------------------------------------------------"
#   exit
# fi
# fileName=${fileName%".tex"}

fileName="elegantpaper-cn"

rm -rf temp/ docs/

# 设置 LaTeX 环境变量和搜索路径为当前目录
# export TEXINPUTS=".//:$TEXINPUTS" # *.tex 的路径
# export BIBINPUTS=".//:$BIBINPUTS" # *.bib 的路径
# export BSTINPUTS=".//:$BSTINPUTS" # *.bst 的路径

tmpDir="temp"
if [[ ! -d ${tmpDir} ]]; then
  mkdir -p ${tmpDir}/
fi

latexmk -xelatex -file-line-error -halt-on-error -interaction=nonstopmode -output-directory=temp -synctex=1  ${fileName}.tex

# 设置 PDF 阅读器
if [[ `uname` == "Linux" ]]; then
  pdfViwer="evince"
else
  pdfViwer="open"
fi

# ${pdfViwer} ./${tmpDir}/${fileName}.pdf || exit
echo "---------------------------------------------------------------------------"
echo "finished..."
echo "---------------------------------------------------------------------------"

docDir="docs"
if [[ ! -d ${docDir} ]]; then
  mkdir -p ${docDir}/
fi
cp ./${tmpDir}/*.pdf ${docDir}/

${pdfViwer} ./${docDir}/${fileName}.pdf || exit
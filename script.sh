#!/bin/sh

echo 'insira a url ssh do repositorio de destino '

read REPO1

echo 'insira o nome exato da sua branch'

read BRANCH1

git remote add temp $REPO1

git push temp $BRANCH1:main

git remote remove temp 

echo 'Processo terminado'
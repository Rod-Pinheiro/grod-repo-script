#!/bin/sh

echo 'insira a url ssh do repositorio de destino '

read REPO1

git remote add temp $REPO1

git push -u temp $REPO1

git remote remove temp 

echo 'repositorio copiado!'
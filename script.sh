# Esse script pode ser usado pra copiar o repositorio local para um novo repositorio previamente criado
# usando a url ssh


#!/bin/sh

echo 'insira a url ssh do repositorio de destino '

read REPO1

echo 'insira o nome exato da sua branch'

read BRANCH1

echo 'insira o nome do projeto'

read PROJECT

git remote add temp $REPO1

git push temp $BRANCH1:main

git remote remove temp 

echo 'Processo terminado'
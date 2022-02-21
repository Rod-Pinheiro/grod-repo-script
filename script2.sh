# Esse script depende que pacote gh do github esteja instalado
# cria a repositorio remoto e faz o push automaticamente

# execucao do script: ./script2.sh myproject projectFolder

#!/bin/sh

echo 'iniciando'

LOCAL_BRANCHS=$(git --git-dir $2/.git for-each-ref --format="%(if)%(authorname)%(then)%(refname:short)%(end)" refs/heads/ --sort=authordate)
echo "digite o nome da sua branch:\n\n$LOCAL_BRANCHS\n\n"
read USER_BRANCH_INPUT

USER_BRANCH=$(git --git-dir $2/.git for-each-ref --format="%(if)%(authorname)%(then) %(refname:short)%(end)" refs/heads/"*$USER_BRANCH_INPUT*" )

git --git-dir $2/.git checkout $USER_BRANCH
git --git-dir $2/.git checkout -b main

if [ "$3" = "private" ]
then
    gh repo create $1 --private --source=$2 --remote=$1 --push
else
    read -p "Voce gostaria de apagar os testes e o README?
    Isso apagara todos os .test.js do projeto (y/n)?" CONT
    if [ $CONT = "y" ]
    then
        git --git-dir $2/.git --work-tree=$2 rm "*.test.js" "*.md" "cypress" -r --ignore-unmatch
        git --git-dir $2/.git --work-tree=$2 commit -a -m "Remove os testes e o README da Trybe"
        
    fi
    gh repo create $1 --public --source=$2 --remote=$1 --push
fi

git --git-dir $2/.git checkout $USER_BRANCH
git --git-dir $2/.git branch -D main


git --git-dir $2/.git remote remove $1

gh repo view $1 -w


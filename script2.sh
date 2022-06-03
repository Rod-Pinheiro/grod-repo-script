# Esse script depende que pacote gh do github esteja instalado
# cria a repositorio remoto e faz o push automaticamente

# execucao do script: ./script2.sh projectName ../projectFolder

#!/bin/sh

echo 'iniciando'

# Definindo qual branch sera usada para criar o repositorio remoto

LOCAL_BRANCHS=$(git --git-dir $2/.git for-each-ref --format="%(if)%(authorname)%(then)%(refname:short)%(end)" refs/heads/ --sort=authordate)
echo "digite o nome da sua branch:\n\n$LOCAL_BRANCHS\n\n"
read USER_BRANCH_INPUT

USER_BRANCH=$(git --git-dir $2/.git for-each-ref --format="%(if)%(authorname)%(then) %(refname:short)%(end)" refs/heads/"*$USER_BRANCH_INPUT*" )

git --git-dir $2/.git checkout $USER_BRANCH
git --git-dir $2/.git checkout -b $USER_BRANCH$1

# ----------------------------------------------------------------------------------------------------------------------

# Verifica se o usuario gostaria de apagar os testes e o Readme do projeto

read -p "Voce gostaria de apagar os testes e o README?
Isso apagara todos os .test.js do projeto (y/n)?" CONT
if [ $CONT = "y" ]
then
    git --git-dir $2/.git --work-tree=$2 rm "*.test.js" "*.md" "cypress*" ".trybe" -r --ignore-unmatch
    cp ./utils/README.md $2/README.md
    git --git-dir $2/.git --work-tree=$2 add -A
    git --git-dir $2/.git --work-tree=$2 status
    git --git-dir $2/.git --work-tree=$2 commit -m "Remove os testes e o README da Trybe"
    
fi

# ----------------------------------------------------------------------------------------------------------------------

# Cria o repositorio remoto

if [ "$3" = "private" ]
then
    gh repo create $1 --private --source=$2 --remote=$1 --push
else
    
    gh repo create $1 --public --source=$2 --remote=$1 --push
fi

# ----------------------------------------------------------------------------------------------------------------------

gh repo edit $1 --default-branch main

# Restaura o repositorio local

git --git-dir $2/.git checkout -f $USER_BRANCH
git --git-dir $2/.git branch -D -q $USER_BRANCH$1
git --git-dir $2/.git remote remove $1

# ----------------------------------------------------------------------------------------------------------------------


# Finaliza o script com sucesso
echo "$(tput setaf 2)Processo Concluido$(tput sgr 0)"
echo "Gostaria de abrir o repositorio no navegador? (y/n)"
read OPEN_BROWSER

if [ $OPEN_BROWSER = "y" ]
then
echo "$(tput setaf 2)Abrindo $1 $(tput sgr 0)"
    gh repo view $1 -w
fi
# ----------------------------------------------------------------------------------------------------------------------


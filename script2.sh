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

gh repo create $1 --private --source=$2 --remote=temp --push



git --git-dir $2/.git checkout $USER_BRANCH
git --git-dir $2/.git branch -D main


git --git-dir $2/.git remote remove temp 

gh repo view $1 -w


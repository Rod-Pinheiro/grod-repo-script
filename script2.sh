# Esse script depende que pacote gh do github esteja instalado 
# cria a repositorio remoto e faz o push automaticamente

# execucao do script: ./script2.sh myproject projectFolder

#!/bin/sh

echo 'iniciando'

gh repo create $1 --private --source=$2 --remote=temp --push

# $2 git remote remove temp -> ./script2.sh: 10: ../sd-014-a-project-zoo-functions: Permission denied

gh repo view $1 -w
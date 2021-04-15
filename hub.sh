hub() {
data=$(cat<<DATA
usage:
  clone <username/reponame> | <reponame>
  create (optional reponame)
  list
  login
  logout
  push
  status
DATA
)
  if [ $# = 1 ] ; then
    case $1 in
      create) git init ; gh repo create $(basename `pwd`) -d '' --private -y ;;
      list) gh repo list ;;
      login) gh auth login -w ;;
      logout) gh auth logout ;;
      push) git add -A ; git commit -m "`date -u`" ; git push | git push -u origin master | git push -u origin main ;;
      status) gh auth status ;;
      *) echo $data ; false ;;
    esac
  elif [ $# = 2 ] ; then
    case $1 in
      clone) gh repo clone $2 ;;
      create) git init ; gh repo create $2 -d '' --private -y ;;
      *) echo $data ; false ;;
    esac
  else
    echo $data ; false
  fi
}
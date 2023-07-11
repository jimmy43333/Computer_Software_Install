## Install Git in Ubuntu
sudo apt-get update <br>
sudo apt-get install git <br>
git config --global user.name "Your name" <br>
git config --global user.email "Your email" <br>

#### reference
>https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-14-04  

## Install Git in Windows  
#### reference
>https://git-scm.com/  
>http://code.google.com/p/tortoisegit/    

## Install Git in Mac  
check the git : git --version  
#### reference  
>http://www.macworld.co.uk/how-to/mac-software/how-use-git-github-on-your-mac-3639136/  

## Reference
>https://git-scm.com/doc  
>https://git-scm.com/book/zh-tw/v2/開始-Git-安裝教學

## How to write good README.md
>https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project

### First time use git in local file
    git init <br>             //Create .git directory
    git add .                 //Add all existing file in the index 
    git commit -m "comment"   //Add the first comment
    git status <br>           //Check the status

### Clone the repository from github  
    git clone "URL.git"
  
### Work with online repository  
    git remote -v                   //Check the repository  
    git remote add origin “URL”     //Add the new repository to local file   
    git pull origin master          //pull the file from master  
    git push -u origin master       //upload the file after add  

### Remote control
    git remote add origin URL <br>     
    git remote rm "name" <br> 
    git remote rename "origin" "new" <br>  
    git pull origin master  
    git push -u origin master <br> 

### Branch
    git branch branchName
    git checkout branchName
    (checkout to the master)
    git merge branchName

    git branch -d <branch> //Remove Branch

### Reset commit
    git reset --soft HEAD^  #uncommit and remain the change
    git reset --hard HEAD^  #uncommit and remove the change

### log
    git log --oneline
    git rebase 

function create-python
    set --local project_name $argv[1]
    set_color F85
    mkdir $project_name
    echo created package $project_name
    cd $project_name
    touch main.py
    echo created main.py

    echo "def main():
      pass

      if __name__ == '__main__':
        main()
      " >main.py
    create-venv
    echo created virtual environment
    git init
    gh repo create $project_name --private
    set_color F85
    echo created repo on github
    set_color normal
    git add .
    git commit -m 'initial commit'
    git remote add origin ( string join '' git@github.com-xavierwallis:xavierwallis/ $project_name )
    git push origin main
    set_color F85
    echo successfully pushed to github at ( string join '' git@github.com-xavierwallis:xavierwallis/ $project_name )

end

#! /bin/bash 

SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")


if ! [ -x "$(command -v git)" ]; 
then
    echo "Git not instaled or not configured properly."
    exit
fi
if ! [ -x "$(command -v docker)" ]; 
then
    echo "Docker not instaled or not configured properly."
    exit
fi

while [[ $project != "5" ]]
do  
    echo "Choose a project to build "
    echo ""
    echo ""

    echo " 1. Fund Manager Service"
    echo " 2. Investor Service"
    echo " 3. Investor UI"
    echo " 4. Fund Manager UI"
    echo " 5. Exit"
    echo ""
    echo ""
    echo " Please input project : "

    read project

    if [ $project == "1" ]; then 
        if ! [ -x "$(command -v mvn)" ]; 
        then
            echo "Maven not instaled or not configured properly."
            exit
        fi
        echo "Fund Manager Service is starting to build ..."
        echo "Pulling from git .."
        cd "${SCRIPTPATH}/fund_manager_rest"
        git pull
        if [ $? -eq 0 ]; then
            echo "Pull Success.. Building.."
            mvn clean package
            if [ $? -eq 0 ]; then
                echo "Maven build success.. building docker image"
                docker rm -f fund-manager-0.0.1
                docker rmi fund-manager-0.0.1
                docker build -t fund-manager-0.0.1 .
                if [ $? -eq 0 ]; then
                    echo "docker build success!"
                fi
            fi            
            
        else
            echo "Pull Failed !"
            exit
        fi       
        echo "Press any key to continue ..."
        cd "${SCRIPTPATH}/.."
        read 

    elif [ $project == "2" ]; then 
        if ! [ -x "$(command -v mvn)" ]; 
        then
            echo "Maven not instaled or not configured properly."
            exit
        fi
        echo "Investor Service is starting to build ..."
        echo "Pulling from git .."
        cd "${SCRIPTPATH}/InvestorRESTCode"
        git pull
        if [ $? -eq 0 ]; then
            echo "Pull Success.. Building.."
            mvn clean package
            if [ $? -eq 0 ]; then
                echo "Maven build success.. building docker image"
                docker rm -f investor-0.0.1
                docker rmi investor-0.0.1
                docker build -t investor-0.0.1 .
                if [ $? -eq 0 ]; then
                    echo "docker build success!"
                fi
            fi          
            
        else
            echo "Pull Failed !"
            exit
        fi  
        echo "Press any key to continue ..."
        cd "${SCRIPTPATH}/.."
        read 

    elif [ $project == "delegated3" ]; then 
        if ! [ -x "$(command -v npm)" ]; 
        then
            echo "Npm not instaled or not configured properly."
            exit
        fi
        if ! [ -x "$(command -v node)" ]; 
        then
            echo "Node not instaled or not configured properly."
            exit
        fi
        echo "Investor UI is starting to build ..."
        echo "Pulling from git .."
        cd "${SCRIPTPATH}/investor-ui"
        git pull
        if [ $? -eq 0 ]; then
            echo "Pull Success.. Building.."
            npm install
            if [ $? -eq 0 ]; then
                echo "Npm install success.. building project.."
                npm run build:prod
                if [ $? -eq 0 ]; then
                    echo "build success.. building docker image.."
                    docker rm -f innovate2020-investor
                    docker rmi innovate2020-investor
                    docker build -t innovate2020-investor:latest -t innovate2020-investor:0.0.0 .
                    if [ $? -eq 0 ]; then
                        echo "docker build success!"
                    fi
                fi
            fi  
        else
            echo "Pull Failed !"
            exit
        fi  
                  
        echo "Press any key to continue ..."
        cd "${SCRIPTPATH}/.."
        read 
    elif [ $project == "3" ]; then 
        if ! [ -x "$(command -v npm)" ]; 
        then
            echo "Npm not instaled or not configured properly."
            exit
        fi
        if ! [ -x "$(command -v node)" ]; 
        then
            echo "Node not instaled or not configured properly."
            exit
        fi
        echo "Investor UI is starting to build ..."
        echo "Pulling from git .."
        cd "${SCRIPTPATH}/investor-ui-new"
        git pull
        if [ $? -eq 0 ]; then
            echo "Pull Success.. Building.."
            npm install
            if [ $? -eq 0 ]; then
                echo "Npm install success.. building project.."
                npm run build:prod
                if [ $? -eq 0 ]; then
                    echo "build success.. building docker image.."
                    docker rm -f innovate2020
                    docker rmi innovate2020
                    docker build -t innovate2020:latest -t innovate2020:0.0.0 .
                    if [ $? -eq 0 ]; then
                        echo "docker build success!"
                    fi
                fi
            fi  
        else
            echo "Pull Failed !"
            exit
        fi  
                  
        echo "Press any key to continue ..."
        cd "${SCRIPTPATH}/.."
        read
    elif [ $project == "4" ]; then 
        if ! [ -x "$(command -v npm)" ]; 
        then
            echo "Npm not instaled or not configured properly."
            exit
        fi
        if ! [ -x "$(command -v node)" ]; 
        then
            echo "Node not instaled or not configured properly."
            exit
        fi 
        echo "Fund manager UI is starting to build ..."
        echo "Pulling from git .."
        cd "${SCRIPTPATH}/fund-manager-ui"
        git pull
        if [ $? -eq 0 ]; then
            echo "Pull Success.. Building.."
            npm install
            if [ $? -eq 0 ]; then
                echo "Npm install success.. building project.."
                npm run build:prod
                if [ $? -eq 0 ]; then
                    echo "build success.. building docker image.."
                    docker rm -f innovate2020-fund-manager
                    docker rmi innovate2020-fund-manager
                    docker build -t innovate2020-fund-manager:latest -t innovate2020-fund-manager:0.0.0 .
                    if [ $? -eq 0 ]; then
                        echo "docker build success!"
                    fi
                fi
            fi  
        else
            echo "Pull Failed !"
            exit
        fi  
                  
        echo "Press any key to continue ..."
        cd "${SCRIPTPATH}/.."

    elif [ $project == "5" ]; then
        echo "Exiting ..."
        exit
    else
        echo "Unrecognized option. Please retry"
    fi  
      
done
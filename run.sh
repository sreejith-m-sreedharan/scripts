#! /bin/bash 
SERVER_IP=$1

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

DEFAULT_IP="192.168.1.60"

FUND_MANAGER_PORT="9081"
INVESTOR_PORT="8081"
BLOCK_CHAIN_PORT="8080"

if [[ $SERVER_IP == "" ]]; then

    EC2_INSTANCE="$(hostname  -I 2>/dev/null)"

    if [[ $EC2_INSTANCE == "" ]]; then
        EC2_INSTANCE="$DEFAULT_IP"
    fi
else
    EC2_INSTANCE="$SERVER_IP"
fi

FUND_MANAGER_URL="http://$EC2_INSTANCE:$FUND_MANAGER_PORT"
BLOCK_CHAIN_URL="http://vmfalcon.southindia.cloudapp.azure.com:$BLOCK_CHAIN_PORT/api"
INVESTOR_URL="http://$EC2_INSTANCE:$INVESTOR_PORT"



if ! [ -x "$(command -v docker)" ]; 
then
    echo "Docker not instaled or not configured properly."
    exit
fi


while [[ $project != "5" ]]
do  
    echo "Choose a project to deploy "
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
        echo "Fund Manager Service is starting ..."    
        docker rm -f fund-manager-0.0.1
        docker run -d -t --name fund-manager-0.0.1 -p "$FUND_MANAGER_PORT:$FUND_MANAGER_PORT" fund-manager-0.0.1
        if [ $? -eq 0 ]; then
            echo "Docker run completed Successfully!"
        else
            echo "Docker run failed"
        fi
        echo "Press any key to continue ..."
        read 

    elif [ $project == "2" ]; then 
        echo "Investor Service is starting ..."
        docker rm -f investor-0.0.1
        docker run -d -t --name investor-0.0.1 -p "$INVESTOR_PORT:$INVESTOR_PORT" investor-0.0.1
        if [ $? -eq 0 ]; then
            echo "Docker run completed Successfully!"
        else
            echo "Docker run failed"
        fi
        echo "Press any key to continue ..."
        read 

    elif [ $project == "delegated3" ]; then 
        echo "Investor UI is starting ..."
        docker rm -f innovate2020-investor
        docker run -d -t --name innovate2020-investor -e FUND_MANAGER_URL="$FUND_MANAGER_URL" -e BLOCK_CHAIN_URL="$BLOCK_CHAIN_URL" -e INVESTOR_URL="$INVESTOR_URL" -p 9000:80  innovate2020-investor:latest . 
        if [ $? -eq 0 ]; then
            echo "Docker run completed Successfully!"
        else
            echo "Docker run failed"
        fi
        echo "Press any key to continue ..."
        read 
    elif [ $project == "3" ]; then 
        echo "Investor UI is starting ..."
        docker rm -f innovate2020
        docker run -d -t --name innovate2020 -e FUND_MANAGER_URL="$FUND_MANAGER_URL" -e BLOCK_CHAIN_URL="$BLOCK_CHAIN_URL" -e INVESTOR_URL="$INVESTOR_URL" -p 80:80  innovate2020:latest . 
        if [ $? -eq 0 ]; then
            echo "Docker run completed Successfully!"
        else
            echo "Docker run failed"
        fi
        echo "Press any key to continue ..."
        read 
    elif [ $project == "4" ]; then          
        echo "Fund manager UI is starting ..."
        docker rm -f innovate2020-fund-manager
        docker run -d -t --name innovate2020-fund-manager -e FUND_MANAGER_URL="$FUND_MANAGER_URL" -e BLOCK_CHAIN_URL="$BLOCK_CHAIN_URL" -e INVESTOR_URL="$INVESTOR_URL" -p 81:80  innovate2020-fund-manager:latest . 
        if [ $? -eq 0 ]; then
            echo "Docker run completed Successfully!"
        else
            echo "Docker run failed"
        fi
        echo "Press any key to continue ..."
        read 
    elif [ $project == "5" ]; then
        echo "Exiting ..."
        exit
    else
        echo "Unrecognized option. Please retry"
    fi  
      
done
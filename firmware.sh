#!/bin/bash

# Skrypt instalujący pakiety firmware

# Funkcja wyświetlająca pytanie i oczekująca na odpowiedź użytkownika
ask_question() {
    local answer
    printf "\e[33m%s\e[0m (t/n): " "$1"
    while true; do
        read -rsn1 answer
        if [[ $answer =~ ^[tTnN]$ ]]; then
            printf "%s " "$answer"  # wypisanie odpowiedzi bez przenoszenia do nowej linii
            break
        fi
    done
    echo ""  # przechodzi do nowej linii
    if [[ $answer == [Tt] ]]; then
        return 0
    else
        return 1
    fi
}

clear
printf "\e[34m%s\e[0m\n" "Instalacja pakietów firmware"

# Pytanie o sterowniki WiFi INTEL
if ask_question "Czy zainstalować sterowniki WiFi INTEL?"; then
    intel=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Instalacja pakietów firmware"
# Pytanie o sterowniki Broadcom
if ask_question "Czy zainstalować sterowniki WiFi Broadcom?"; then
    broadcom=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Instalacja pakietów firmware"
# Pytanie o sterowniki NVIDIA
if ask_question "Czy zainstalować sterowniki NVIDIA?"; then
    nvidia=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Instalacja pakietów firmware"
# Pytanie o niewolne sterowniki
if ask_question "Czy zainstalować niewolne sterowniki?"; then
    nonfree=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Instalacja pakietów firmware"


# Instalacja odpowiednich pakietów firmware na podstawie odpowiedzi
if [[ $intel ]]; then
    echo "Instalowanie sterowników WiFi INTEL..."
    apt install -y firmware-iwlwifi
fi


if [[ $broadcom ]]; then
    echo "Instalowanie sterowników Broadcom..."
    apt install -y firmware-brcm80211
fi


if [[ $nvidia ]]; then
    echo "Instalowanie sterowników NVIDIA..."
    apt install -y linux-headers-amd64 nvidia-driver firmware-misc-nonfree
fi


if [[ $nonfree ]]; then
    echo "Instalowanie niewolnych sterowników..."
    apt install -y firmware-linux-nonfree firmware-misc-nonfree
fi

if [[ $nonfree ]]; then
    echo "Instalowanie firmware-realtek..."
    apt install -y firmware-realtek
fi

echo "Instalacja pakietów firmware zakończona."

#!/bin/bash

# Skrypt konfigurujący system Debian

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


# Pytania użytkownika
clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy skonfigurować katalog /sbin?"; then
    sbin=true
fi
if [[ $sbin ]]; then
    ./sbin.sh
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy wyłączyć dźwięk "beep" (podczas wylogowania)?"; then
    beep=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."

clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy skonfigurować Bluetooth?"; then
    bluetooth=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy skonfigurować dodawanie repozytoriów (software-properties)?"; then
    repo=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy zainstalować sterowniki?"; then
    firmware=true
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear
printf "\e[34m%s\e[0m\n" "Konfiguracja Debiana"

if ask_question "Czy skonfigurować język systemu?"; then
    user=true
fi
if [[ $user ]]; then
    ./lang.sh
fi
read -rsn1 -p "Naciśnij Enter aby kontynuować..."
clear


# Uruchomienie odpowiednich skryptów
if [[ $firmware ]]; then
    ./firmware.sh
fi

if [[ $beep ]]; then
    ./beep.sh
fi

if [[ $bluetooth ]]; then
    ./bluetooth.sh
fi

if [[ $repo ]]; then
    ./repo.sh
fi

echo "Zakończono pomyślnie. Uruchom ponownie komputer."

#!/bin/bash

# Skrypt dodający /sbin do zmiennej PATH i do pliku .bashrc użytkownika

# Dodanie /sbin do zmiennej PATH tymczasowo dla bieżącej sesji
export PATH=$PATH:/sbin
echo "Dodano /sbin do zmiennej PATH dla bieżącej sesji."

# Zapytanie o nazwę użytkownika
read -p "Podaj nazwę użytkownika, dla którego chcesz dodać /sbin do PATH: " username

# Sprawdzanie, czy użytkownik istnieje
if id "$username" &>/dev/null; then
    echo "Użytkownik $username istnieje."

    # Ścieżka do pliku .bashrc w katalogu domowym użytkownika
    user_home=$(eval echo ~$username)
    bashrc_file="$user_home/.bashrc"

    # Sprawdzanie, czy wpis już istnieje w pliku .bashrc
    if grep -Fxq 'PATH="$PATH:/sbin"' "$bashrc_file"; then
        echo "Wpis PATH=\"$PATH:/sbin\" już istnieje w pliku $bashrc_file."
    else
        # Dodanie wpisu na końcu pliku .bashrc
        echo 'PATH="$PATH:/sbin"' >> "$bashrc_file"
        echo "Dodano PATH=\"$PATH:/sbin\" do pliku $bashrc_file."
    fi
else
    echo "Użytkownik $username nie istnieje. Sprawdź nazwę użytkownika i spróbuj ponownie."
fi

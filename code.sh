set -e -o verbose

# code

if [ -d ~/Code/Arch ]; then rm -rf ~/Code/Arch; fi
git clone git@github.com:GrzegorzKozub/Arch.git ~/Code/Arch

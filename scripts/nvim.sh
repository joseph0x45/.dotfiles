curl -o nvim.zip https://dotfiler.onrender.com/get_nvim
mkdir -p ~/.config/nvim
unzip -o nvim.zip -d  ~/.config/nvim
mv ~/.config/nvim/after ~/.config/nvim/lua ~/.config/nvim/init.lua ~/.config
rm -rf ~/.config/nvim
rm nvim.zip

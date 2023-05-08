curl -o nvim.zip https://dotfiler.onrender.com/get_nvim
mkdir -p ~/.config/nvim
unzip -o nvim.zip -d  ~/.config/nvim
mv ~/.config/nvim/nvim/after ~/.config/nvim/nvim/lua ~/.config/nvim/nvim/init.lua ~/.config/nvim
rm -rf ~/.config/nvim/nvim
rm nvim.zip

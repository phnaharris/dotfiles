function install_programminglanguage {
	if [ "$(is_installed ruby)" == "0" ]; then
		echo "Installing ruby"
		apt install ruby-full -y
		gem install jekyll bundler -y
	fi
	if [ "$(is_installed elixir)" == "0" ]; then
		echo "Installing elixir"
		apt install elixir erlang -y
	fi
	if [ "$(is_installed rustup)" == "0" ]; then
		echo "Installing rust"
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source "$HOME/.cargo/env"
		rustup update
	fi
	if [ "$(is_installed go)" == "0" ]; then
		echo "Installing golang"
		apt install golang -y
	fi
	if [ "$(is_installed fnm)" == "0" ]; then # Cannot detect if nvm was installed or not
		echo "Installing fnm - Fast Node Manager"
		curl --install-dir "$HOME/.fnm" -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | zsh
		fnm install node
		npm install -g yarn -y
		npm install -g gulp -y
	fi
}

function install_alacritty { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	if [ "$(is_installed alacritty)" == "0" ]; then
		apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
		git clone https://github.com/alacritty/alacritty.git
		cargo build --release
		cd alacritty || exit
		cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
		cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
		desktop-file-install extra/linux/Alacritty.desktop
		update-desktop-database
		cd ..
		rm -r ../alacritty
	fi
}

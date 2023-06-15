# --delete -> delete files in dest which are not in source
# --exclude="/.*/" -> exclude all dot-directories in home folder (like ~/.mozilla, ~/.vscode etc)
# --include=".ssh/" -> exclude the above, other than the ~/.ssh
# Other excludes -> exclude node_modules etc anywhere they appear in the file-tree
rsync --archive --verbose --delete \
--include=".ssh/" \
--exclude="/.*/" \
--exclude="node_modules/" \
--exclude=".pnpm-store/" \
--exclude="rubygems/" \
--exclude=".cache/" \
~/ /mnt/HDD/home_apb

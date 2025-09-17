#!/bin/bash

uv sync
uv run pre-commit install

echo "" >> ~/.bashrc
echo "# Function to display git branch in prompt" >> ~/.bashrc
cat << 'EOF' >> ~/.bashrc
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\$ '
EOF

echo "Setting git configs..."
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME
git config --global core.editor 'vim'
git config --global alias.pushf 'push --force-with-lease'
git config --global alias.acpf '!git add . && git commit && git pushf'
git config --global alias.re '!git fetch && git rebase origin/main && git pushf'
git config --global alias.re2 '!git fetch && git rebase origin/main && git rebase -i HEAD~2 && git pushf'
git config --global pull.rebase true
git config --global push.default simple

echo "Dev container post-creation setup complete."
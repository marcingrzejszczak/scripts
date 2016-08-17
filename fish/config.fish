# Sample config

# Install fundle - https://github.com/tuvistavie/fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

set -g fish_color_user magenta
set -g fish_color_host yellow
set -g fish_prompt_git_status_git_dir '⚒'
set -g fish_prompt_git_remote_space ' '

set -gx JAVA_HOME /usr/lib/jvm/default-java
set -gx IDEA_HOME ~/apps/JetBrains/intellij
set -gx GIT_EDITOR="mcedit"

set -gx PATH $JAVA_HOME/bin $PATH
set -gx PATH $IDEA_HOME/bin $PATH
set -gx PATH ~/.local/bin/ $PATH

set -gx PATH $PATH (find ~/.sdkman/*/current/bin -maxdepth 0)`

. $HOME/.config/fish/informative_git_prompt.fish
. $HOME/.config/fish/function/sdkman.fish
. $HOME/.config/fish/function/gnupg.fish

#alias gradle gw

function idea --description 'Starts Intellij IDEA'
    idea.sh
end

function jdk7 --description 'Set Java to jdk7'
    sudo rm -f /usr/lib/jvm/default-java
    sudo ln -s /usr/lib/jvm/jdk1.7.0_79 /usr/lib/jvm/default-java
end

function jdk8 --description 'Set Java to jdk8'
    sudo rm -f /usr/lib/jvm/default-java
    sudo ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java
end

function brightness_max --description 'Set max brightness'
     echo 4302 | sudo tee /sys/class/backlight/intel_backlight/brightness
end

function brightness_min --description 'Set min brightness'
     echo 100 | sudo tee /sys/class/backlight/intel_backlight/brightness
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  printf '%s ' (__informative_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '

  set_color $fish_color_normal

end

function fish_right_prompt -d "Write out the right prompt"

  # Time
  set_color -o black
  echo (date +%R)
  set_color $fish_color_normal

end

fundle plugin 'tuvistavie/fish-ssh-agent'

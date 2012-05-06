## DeeDot — a tool for managing your ~/dotfile/ symlinks ##

    $  git clone https://github.com/yourself/dotfiles.git
    $  cd dotfiles
    $  ./deedot
    $  ls -l ~/.bashrc
    ~/.bashrc -> ~/dotfiles/.bashrc

    # Your dotfiles are safe.  Deedot won't overwrite anything.

DeeDot is a tool to make managing your dotfile symlinks in $HOME easy, allowing you to keep all your dotfiles in a single directory.

Hosting is up to you. Using whatever VCS you prefer, or even rsync, you can easily distribute your dotfiles repository across multiple hosts.

## Usage ##

Run deedot, fix the file conflicts that it notes, run deedot...   repeat until it doesn't report any conflicts.

Deedot recognizes three different ways to incorporate ~/dotfiles/ settings into the working versions:

* **Symlink** — If you don't want any local-machine overrides. For example, ~/.bashrc can just be a symlink to ~/dotfiles/.bashrc.

* **Source** — Some file types have the ability to 'source' another file.

* **Text substitution** — Deedot will read the text from *.subst files, and copy-n-paste it into the middle of the working version.
  
## Machine-specific overrides — via source ##

One way to have local machine-specific settings that override the global repository settings is to use the 'source' feature available in some file types.  For example, ~/.bashrc can contain:

    # Pull in the global settings
    [ -f ~/dotfiles/.bashrc ] && source ~/dotfiles/.bashrc

    # Override the global settings for this specific machine
    export TERM=xtermc

Deedot [knows about each file type](https://github.com/DeeNewcum/deedot/blob/f0e7bfcef3344eb4dc05f95f223aafc73cb9d11c/deedot#L129-136), and will suggest the appropriate 'source' line.

## Machine-specific overrides — via text substitution ##

For files that don't have 'source' capability, text substitution is available as a fallback.

For example, deedot will update the section of ~/.ssh/config every time it's run: 

    ######## MODIFICATIONS HERE WILL BE OVERWRITTEN BY CONTENTS OF: ~/dotfiles/.ssh/config.subst ########
    Host github.com
        User git
        IdentityFile ~/.ssh/github.priv
    ######## END SUBSTITUTION FROM: ~/dotfiles/.ssh/config.subst ########
    
    Host webstaging.work.com
        User my-username
    
    # ... a bunch of other private stuff that I don't want to make available on the public repository.

## Similar projects ##

* [GNU stow](http://www.inductiveload.com/posts/basic-use-of-gnu-stowxstow/) — though written for other purposes, it does symlink jujitsu, so it [works well for this](https://github.com/aspiers/shell-env)
* [dotfiles](https://github.com/jbernard/dotfiles) by Jon Bernard
* [homesick](https://github.com/technicalpickles/homesick) by Josh Nichols
* [sync-dotfiles](https://github.com/xolox/sync-dotfiles) by Peter Odding
* [git-home-history](http://jean-francois.richard.name/ghh/git-home-history.html) by Jean-Francois Richard
* [dot-files](https://github.com/bartman/dot-files) by Bart Trojanowski
* [git-home](http://git-home.chezwam.org/) — dead?

## My personal config files ##

If you're curious, mine are [available here](https://github.com/DeeNewcum/dotfiles).

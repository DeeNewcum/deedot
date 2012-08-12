## DeeDot ##

    $  git clone https://github.com/yourself/dotfiles.git
    $  cd dotfiles
    $  ./deedot
    $  ls -l ~/.bashrc
    ~/.bashrc -> ~/dotfiles/.bashrc

    # Your dotfiles are safe.  DeeDot won't overwrite anything.

DeeDot is a tool for installing dotfile symlinks in your $HOME, allowing you to keep your versioned dotfiles under a single directory.

Host your dotfiles in any version control system (even rsync), and voila, your dotfiles are available across multiple machines.

## Usage ##

Run DeeDot, fix the file conflicts that it notes, run DeeDot...   repeat until it doesn't report any conflicts.

DeeDot recognizes three different ways to incorporate ~/dotfiles/ settings into the working versions in $HOME:

* **Symlink** — If you don't want any local-machine overrides. For example, ~/.bashrc can just be a symlink to ~/dotfiles/.bashrc.

* **Source** — Some file types have the ability to 'source' another file.

* **Text substitution** — DeeDot will read the text from *.subst files, and copy-n-paste it into the middle of the working version.
  
## Machine-specific overrides — via source ##

One way to have local machine-specific settings that override the global repository settings is to use the 'source' feature available in some file types.  For example, ~/.bashrc can contain:

    # Pull in the global settings
    [ -f ~/dotfiles/.bashrc ] && source ~/dotfiles/.bashrc

    # Override the global settings for this specific machine
    export TERM=xtermc

DeeDot [knows about each file type](https://github.com/DeeNewcum/deedot/blob/f0e7bfcef3344eb4dc05f95f223aafc73cb9d11c/deedot#L129-136), and will suggest the appropriate 'source' line.

## Machine-specific overrides — via text substitution ##

For files that don't have 'source' capability, text substitution is available as a fallback.

For example, DeeDot will update the section of ~/.ssh/config every time it's run: 

    ######## MODIFICATIONS HERE WILL BE OVERWRITTEN BY CONTENTS OF: ~/dotfiles/.ssh/config.subst ########
    Host github.com
        User git
        IdentityFile ~/.ssh/github.priv
    ######## END SUBSTITUTION FROM: ~/dotfiles/.ssh/config.subst ########
    
    Host webstaging.work.com
        User my-username
    
    # ... a bunch of other private stuff that I don't want to make available on the public repository.

DeeDot can also do variable interpolation for environment variables, when in text-substitution mode.  For example, in .gitconfig.subst:

    [core]
        # global gitignore settings
        excludesfile = <<$HOME>>/.gitignore

## Minimal requirements ##

DeeDot requires only Perl, and doesn't need any extra modules.  It is designed to run on as many Un*xes as possible.

## Examples of DeeDot in use ##

* [my personal config files are here](https://github.com/DeeNewcum/dotfiles).
* (if you use DeeDot and have a public repo, please contact me if I can list it here)

## Similar projects ##

* [GNU stow](http://www.inductiveload.com/posts/basic-use-of-gnu-stowxstow/) — though written for other purposes, it does symlink jujitsu, so it works well for this
        [[1]](https://github.com/aspiers/shell-env)
        [[2]](https://github.com/chrra/dotfiles)
        [[3]](https://github.com/jmdeldin/dotfiles)
* [homedir](https://github.com/docwhat/homedir) by Christian Höltje [[1]](https://github.com/willnorris/homedir-packages) [[2]](https://github.com/docwhat/homedir-examples)
* [dotfiles](http://pypi.python.org/pypi/dotfiles) by Jon Bernard
* [git-home-history](http://jean-francois.richard.name/ghh/) by Jean-Francois Richard
* [homesick](https://github.com/technicalpickles/homesick) by Josh Nichols [[1]](https://github.com/technicalpickles/dotpickles)
* [sync-dotfiles](http://peterodding.com/code/python/sync-dotfiles/) by Peter Odding
* [dotfile-manager](http://blog.steve.org.uk/poppa_s_got_a_brand_new_bang_.html) [[1]](http://repository.steve.org.uk/cgi-bin/hgwebdir.cgi/dotfiles/file/adf1e61952a0)
* [dot-files](https://github.com/bartman/dot-files) by Bart Trojanowski
* [git-home](http://git-home.chezwam.org/) — dead?


# Authors:
# https://github.com/AlexBio
# https://github.com/dbb
#
# Debian-related zsh aliases and functions for zsh

# Use aptitude if installed, or apt-get if not.
# You can just set apt_pref='apt-get' to override it.
if [[ -e $( which aptitude ) ]]; then
    apt_pref='aptitude'
else
    apt_pref='apt-get'
fi

# Use sudo by default if it's installed
if [[ -e $( which sudo ) ]]; then
    use_sudo=1
fi

# Aliases ###################################################################
# These are for more obscure uses of apt-get and aptitude that aren't covered
# below.
alias ag='apt-get'
alias at='aptitude'

# Some self-explanatory aliases
alias afs='apt-file search --regexp'
alias acs="apt-cache search"
alias aps='aptitude search'
alias as="aptitude -F \"* %p -> %d \n(%v/%V)\" \
		--no-gui --disable-columns search"	# search package
alias asrc='apt-get source'
alias av='apt-cache policy'

alias au='su -c "aptitude update && aptitude safe-upgrade"'
alias aud='su -c "aptitude update"'
alias aug='su -c "aptitude safe-upgrade"'
alias ai="sudo aptitude install"

# apt-file
alias afs='apt-file search --regexp'

# These are apt-get only
alias asrc='apt-get source'
alias ap='apt-cache policy'

# superuser operations ######################################################
if [[ $use_sudo -eq 1 ]]; then
# commands using sudo #######
    alias aac="sudo $apt_pref autoclean"
    alias abd="sudo $apt_pref build-dep"
    alias ac="sudo $apt_pref clean"
    alias ad="sudo $apt_pref update"
    alias adg="sudo $apt_pref update && sudo $apt_pref upgrade"
    alias adu="sudo $apt_pref update && sudo $apt_pref dist-upgrade"
    alias afu='sudo apt-file update'
    alias ag="sudo $apt_pref upgrade"
    alias ai="sudo $apt_pref install"
    alias ap="sudo $apt_pref purge"
    alias ar="sudo $apt_pref remove"

    # apt-get only
    alias ads="sudo $apt_pref dselect-upgrade"
    
    # Install all .deb files in the current directory.
    # Warning: you will need to put the glob in single quotes if you use:
    # glob_subst
    alias di='sudo dpkg -i ./*.deb'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) \
        ?not(~n`uname -r`))'


# commands using su #########
else
    alias aac='su -ls "'"$apt_pref"' autoclean" root'
    abd() {
        cmd="su -lc '$apt_pref build-dep $@' root"
        print "$cmd"
        eval "$cmd"
    }
    alias ac='su -ls "'"$apt_pref"' clean" root'
    alias ad='su -lc "'"$apt_pref"' update" root'
    alias adg='su -lc "'"$apt_pref"' update && aptitude safe-upgrade" root'
    alias adu='su -lc "'"$apt_pref"' update && aptitude dist-upgrade" root'
    alias afu='su -lc "apt-file update"'
    alias ag='su -lc "'"$apt_pref"' safe-upgrade" root'
    ai() {
        cmd="su -lc 'aptitude -P install $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ap() {
        cmd="su -lc '$apt_pref -P purge $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ar() {
        cmd="su -lc '$apt_pref -P remove $@' root"
        print "$cmd"
        eval "$cmd"
    }

    # Install all .deb files in the current directory
    # Assumes glob_subst is off
    alias di='su -lc "dpkg -i ./*.deb" root'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='su -lc '\''aptitude remove -P ?and(~i~nlinux-(ima|hea) \
        ?not(~n`uname -r`))'\'' root'
fi


# Misc. #####################################################################
# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

# install a single .deb package
alias di='sudo dpkg -i '

# Install all .deb files in the current directory.
# Warning: you will need to put the glob in single quotes if you use:
# glob_subst
alias dia='su -c "dpkg -i ./*.deb"'

# Create a basic .deb package
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'





# Functions #################################################################
# create a simple script that can be used to 'duplicate' a system
apt-copy() {
    print '#!/bin/sh'"\n" > apt-copy.sh

    cmd="$apt_pref install "

    for p in ${(f)"$(aptitude search -F "%p" --disable-columns \~i)"}; {
        cmd="${cmd} ${p}"
    }

    print $cmd "\n" >> apt-copy.sh

    chmod +x apt-copy.sh
}


# Kernel-package building shortcut
kerndeb () {
    # temporarily unset MAKEFLAGS ( '-j3' will fail )
    MAKEFLAGS=$( print - $MAKEFLAGS | perl -pe 's/-j\s*[\d]+//g' )		
    print '$MAKEFLAGS set to '"'$MAKEFLAGS'"
	appendage='-custom' # this shows up in $ (uname -r )
    revision=$(date +"%Y%m%d") # this shows up in the .deb file name

    make-kpkg clean

    time fakeroot make-kpkg --append-to-version "$appendage" --revision \
        "$revision" kernel_image kernel_headers
}


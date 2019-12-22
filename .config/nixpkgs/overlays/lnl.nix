self: super:

{
  userPackages = super.userPackages or {} // {
    # My packages
    inherit (self)
      bat
      exa
      fd
      go
      hyperfine
      neovim
      nodejs
      tldr
    ;

    inherit (self.gitAndTools)
      diff-so-fancy
    ;

    # Default packages
    inherit (self)
      cacert
      nix
    ;
  };
}

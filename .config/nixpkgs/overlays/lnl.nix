self: super:

{
  userPackages = super.userPackages or {} // {
    # My packages
    inherit (self)
      exa
      fd
      go
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

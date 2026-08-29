{
  services = {
    openssh = {
      enable = true;
      settings = {};
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

This flake unpacks the .dmg for the aarch64 .dmg of Zen Browser

Add this to your inputs:
```
zen-browser-darwin = {
      url = "github:darbster145/zen-browser-darwin";
    };
```
Then add this to systempackages:
```
environment.systemPackages = with pkgs; [
  inputs.zen-browser-darwin.packages.darwin.aarch64
];
```

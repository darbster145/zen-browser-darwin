This flake for Zen Browser on Nix-Darwin.



Add this to your inputs:
```
zen-browser-darwin = {
      url = "github:darbster145/zen-browser-darwin";
    };
```

Then in the ```configuration.nix``` under ```environment.systemPackages``` add
```
  inputs.zen-browser-darwin.packages."${system}"
```

This flake takes the .dmg for your architecture and unpacks it and install it in your nix store. It does not build zen-browser from source. This flake will need to me updated everytime there is a new release of Zen Browser. I will try to keep it updated. Feel free to fork it and update if need be. 

This is also my first 'real' flake I've made for a program and I am still learning. If you have any suggestions, please send a pull request or open an issue. 

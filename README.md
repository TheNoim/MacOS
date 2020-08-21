# MacOS helper scripts

## Spaces helper

I hate the delay and the animations while switching between spaces. You can use [yabai](https://github.com/koekeishiya/yabai) to switch without any animations and delays. However, the build in next and prev are not optimal if you use multiple monitors. The `yabai-functions.sh` script is a small helper script to cycle through your spaces, but only on your current monitor. You can combine it with a tool like [BetterTouchTools](https://folivora.ai/) or [skhd](https://github.com/koekeishiya/skhd) to create keyboard shortcuts. 

#### Example

Cycle one space forward:

```bash
./yabai-functions.sh next
```

Cycle one space back:

```bash
./yabai-functions.sh back
```

Go to the first space on the current monitor:

```bash
./yabai-functions.sh first
```

Go to the last space on the current monitor:

```bash
./yabai-functions.sh last
```

#### Requirements

You need to install [yabai](https://github.com/koekeishiya/yabai) of course and also start the daemon. Next you need to install [jq](https://stedolan.github.io/jq/). 

The easiest way is to use [brew](https://brew.sh):

```bash
brew install jq koekeishiya/formulae/yabai
sudo yabai --install-sa
brew services start yabai
killall Dock
```

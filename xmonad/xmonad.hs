import Data.Map qualified as M
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Renamed
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- TokyoNight Colors
colorBg = "#1a1b26" -- background
colorFg = "#a9b1d6" -- foreground
colorBlk = "#32344a" -- black
colorRed = "#f7768e" -- red
colorGrn = "#9ece6a" -- green
colorYlw = "#e0af68" -- yellow
colorBlu = "#7aa2f7" -- blue
colorMag = "#ad8ee6" -- magenta
colorCyn = "#0db9d7" -- cyan
colorBrBlk = "#444b6a" -- bright black

-- Appearance
myBorderWidth = 2

myNormalBorderColor = colorBrBlk

myFocusedBorderColor = colorMag

-- Gaps (matching dwm: 3px all around)
mySpacing = spacingWithEdge 2

-- Workspaces
myWorkspaces = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]

-- Mod key (Super/Windows key)
myModMask = mod4Mask

-- Terminal
myTerminal = "alacritty"

-- Monitors
myStartupHook :: X ()
myStartupHook = do
  spawnOnce "xrandr --output eDP1 --mode 1920x1080 --pos 0x0 --output DP1 --primary --mode 1920x1080 --rate 180 --pos 1920x0"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "xwallpaper --zoom ~/wallpapers/sushi_original.png"
  spawnOnce "fcitx5 -d"
  spawnOnce "clipmenud"
  spawnOnce "/usr/lib/polkit-kde-authentication-agent-1"

-- Layouts
myLayoutHook =
  avoidStruts $
        renamed [Replace "Tall"] (mySpacing tall)
        ||| renamed [Replace "Wide"] (mySpacing (Mirror tall))
        ||| renamed [Replace "Full"] (mySpacing Full)
        ||| renamed [Replace "Spiral"] (mySpacing (spiral (6 / 7)))
  where
    tall = ResizableTall 1 (3 / 100) (11 / 20) []

-- Window rules (matching dwm config)
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "kdenlive" --> doShift "三"
    ]
    <+> insertPosition Below Newer

-- Key bindings (matching dwm as closely as possible)
myKeys =
  -- Launch applications
  [ ("M-<Return>", spawn myTerminal)
  , ("M-d", spawn "rofi -show drun -theme ~/.config/rofi/config.rasi")
  , ("<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
  , ("M-e", spawn "thunar")
  , ("M-S-b", spawn "brave")
  , ("C-M1-<Delete>", spawn "~/.config/xmonad/manager.sh")
  , ("C-M1-p", spawn "~/.config/xmonad/power.sh")
  , ("C-M1-l", spawn "~/.config/xmonad/lock.sh")
  , -- Window management
    ("M-q", kill)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-<Tab>", windows W.focusDown)
  , -- Master area
    ("M-h", sendMessage Expand)
  , ("M-g", sendMessage Shrink)
  , ("M-i", sendMessage (IncMasterN 1))
  , ("M-p", sendMessage (IncMasterN (-1)))
  , -- Layout switching
    ("M-t", sendMessage $ JumpToLayout "Tall")
  , ("M-f", sendMessage $ JumpToLayout "Full")
  , ("M-c", sendMessage $ JumpToLayout "Spiral")
  , ("M-n", sendMessage NextLayout)
  , -- Floating
    ("M-S-<Space>", withFocused toggleFloat)
  , -- Gaps (z to increase, x to decrease, a to toggle)
    ("M-z", incWindowSpacing 3)
  , ("M-x", decWindowSpacing 3)
  , ("M-a", toggleWindowSpacingEnabled >> toggleScreenSpacingEnabled)
  , ("M-S-a", setWindowSpacing (Border 3 3 3 3) >> setScreenSpacing (Border 3 3 3 3))
  , -- Quit/Restart
    ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
  , --Clipboard
    ("M-v", spawn "clipmenu")
  ,-- Keychords for tag navigation (Mod+Space then number)
    ("M-1", windows $ W.greedyView "一")
  , ("M-2", windows $ W.greedyView "二")
  , ("M-3", windows $ W.greedyView "三")
  , ("M-4", windows $ W.greedyView "四")
  , ("M-5", windows $ W.greedyView "五")
  , ("M-6", windows $ W.greedyView "六")
  , ("M-7", windows $ W.greedyView "七")
  , ("M-8", windows $ W.greedyView "八")
  , ("M-9", windows $ W.greedyView "九")
  , -- Volume controls
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +3%")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -3%")
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ("<xF86XK_MonBrightnessUp>",   spawn "brightnessctl set +3%")
  , ("<xF86XK_MonBrightnessDown>", spawn "brightnessctl set 3%-")
  ]
    ++
    -- Standard TAGKEYS behavior (Mod+# to view, Mod+Shift+# to move)
    [ (mask ++ "M-" ++ [key], windows $ action tag)
    | (tag, key) <- zip myWorkspaces "一二三四五六七八九"
    , (action, mask) <- [(W.greedyView, ""), (W.shift, "S-")]
    ]

-- Helper function for toggling float
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else W.float w (W.RationalRect 0.15 0.15 0.7 0.7) s
    )

-- XMobar PP (Pretty Printer) configuration
myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = xmobarColor colorBrBlk "" " │ "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = xmobarColor colorCyn ""
    , ppHidden = xmobarColor colorFg ""
    , ppHiddenNoWindows = xmobarColor colorBrBlk ""
    , ppUrgent = xmobarColor colorRed colorYlw
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (xmobarColor colorCyn "" "[") (xmobarColor colorCyn "" "]") . xmobarColor colorFg "" . ppWindow
    formatUnfocused = wrap (xmobarColor colorBrBlk "" "[") (xmobarColor colorBrBlk "" "]") . xmobarColor colorBrBlk "" . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

-- Main configuration
myConfig =
  def
    { modMask = myModMask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , layoutHook = myLayoutHook
    , manageHook = myManageHook <+> manageDocks
    , startupHook = myStartupHook
    }
    `additionalKeysP` myKeys

-- XMobar status bar configuration

myStatusBar =
  mconcat
    [ statusBarProp "/usr/bin/xmobar -x 0 ~/.config/xmobar/xmobarrc" (pure myXmobarPP)
    , statusBarProp "/usr/bin/xmobar -x 1 ~/.config/xmobar/xmobarrc" (pure myXmobarPP)
    ]


main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . withEasySB myStatusBar defToggleStrutsKey $ myConfig

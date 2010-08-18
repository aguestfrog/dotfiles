import XMonad
import XMonad.Hooks.DynamicLog
import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
-- for media buttons
import Graphics.X11.ExtraTypes.XF86


import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
myTerminal :: String
myTerminal = "urxvt"

myBrowser :: String
myBrowser = "chromium-browser"
 
main = do
  xmproc <- spawnPipe "xmobar ~/.xmobarrc"
  xmonad $ defaultConfig
   { terminal    = myTerminal
   , modMask     = mod4Mask
   , borderWidth = 1
   , normalBorderColor  = "#000000"
   , focusedBorderColor = "#999999"
   , manageHook = manageDocks <+> manageHook defaultConfig
   , layoutHook = avoidStruts  $  layoutHook defaultConfig
   , logHook = dynamicLogWithPP $ xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
   , keys          = \c -> mykeys c `M.union` keys defaultConfig c 
   }
  where
    mykeys (XConfig {modMask = modm}) = M.fromList $
         [ ((modm , xK_Return), spawn $ myTerminal)
         , ((modm, xK_f), spawn myBrowser) 
         --, ((modm, xK_i), spawn "urxvtc -e ~/bin/starticq.sh")
         , ((0, xF86XK_AudioMute), spawn "amixer -q set PCM toggle")
         , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 1-")
         , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -q set Master 1+")
         , ((0, xF86XK_AudioStop), spawn "ncmpcpp stop")
         , ((0, xF86XK_AudioPrev), spawn "ncmpcpp prev")
         , ((0, xF86XK_AudioNext), spawn "ncmpcpp next")
         , ((0, xF86XK_AudioPlay), spawn "ncmpcpp toggle")

         , ((0, xF86XK_Sleep), spawn "sudo pm-suspend")
         , ((mod4Mask .|. shiftMask, xK_z), spawn "xlock -mode blank") 
         ] -- consult http://hackage.haskell.org/packages/archive/X11/1.5.0.0/doc/html/Graphics-X11-ExtraTypes-XF86.html


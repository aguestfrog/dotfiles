import XMonad
import XMonad.Hooks.DynamicLog
import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
myTerminal :: String
myTerminal = "urxvt"

myBrowser :: String
myBrowser = "~/bin/chromium"
 
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
         , ((modm, xK_y), spawn (myBrowser++" --app spiegel.de"))
         , ((modm, xK_u), spawn (myBrowser++" --app heise.de"))
         , ((modm, xK_i), spawn (myBrowser++" --app reddit.com"))
         , ((modm, xK_o), spawn (myBrowser++" --app slashdot.org"))
         , ((modm, xK_m), spawn (myBrowser++" --app 'https://meebo.com'"))
         --, ((modm, xK_i), spawn "urxvtc -e ~/bin/starticq.sh")
         --, ((0      , 0x1008ff16 ), spawn "ncmpcpp prev")
         --, ((0      , 0x1008ff17 ), spawn "ncmpcpp next")
         --, ((0      , 0x1008ff14 ), spawn "ncmpcpp toggle")
         , ((0 , 0x1008ff11  ), spawn "amixer -q set Master 1-")   -- mod1-down %! Decrease audio volume
         , ((0 , 0x1008ff13    ), spawn "amixer -q set Master 1+")   -- mod1-up   %! Increase audio volume

         , ((0, 0x1008ff2f), spawn "sudo pm-suspend")
         , ((mod4Mask .|. shiftMask, xK_z), spawn "xlock -mode blank")
         ]


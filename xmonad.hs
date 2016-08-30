import XMonad
import XMonad.Util.Run
import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Layout
import XMonad.Layout.DragPane
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig

modm = mod3Mask

colorNormalBorderColor = "#D2D7D3"
colorFocusedBorderColor = "#ECF0F1"
colorDzenBackground = colorFocusedBorderColor
colorDzenForeground = "#67809F"
myFont = "Roboto:normal:size=16:antialias=true"

dzenMargin = 0
leftDzenWidth = 1000
rightDzenWidth = 1920 - (dzenMargin * 2) - leftDzenWidth
dzenHeight = 32

dzenLeftCommand = "dzen2"
  ++ " -p"
  ++ " -x '" ++ (show dzenMargin) ++ "'"
  ++ " -y '" ++ (show dzenMargin) ++ "'"
  ++ " -h '" ++ (show dzenHeight) ++ "'"
  ++ " -w '" ++ (show leftDzenWidth) ++ "'" 
  ++ " -bg '" ++ colorDzenBackground ++ "'"
  ++ " -fg '" ++ colorDzenForeground ++ "'"
  ++ " -fn '" ++ myFont ++ "'"
  ++ " -ta l"

dzenRightCommand = "conky -c ~/.conkyrc"
  ++ "| dzen2 "
  ++ " -x '" ++ (show $ dzenMargin + leftDzenWidth) ++ "'"
  ++ " -y '" ++ (show dzenMargin) ++ "'"
  ++ " -h '" ++ (show dzenHeight) ++ "'"
  ++ " -w '" ++ (show rightDzenWidth)  ++ "'" 
  ++ " -bg '" ++ colorDzenBackground ++ "'"
  ++ " -fg '" ++ colorDzenForeground ++ "'"
  ++ " -fn '" ++ myFont ++ "'"
  ++ " -ta r"

main = do
  dzenLeft <- spawnPipe dzenLeftCommand
  dzenRight <- spawnPipe dzenRightCommand

  xmonad $ defaultConfig 
    { 
      modMask = modm
    , terminal = "urxvt"
    , startupHook = myStartupHook
    , borderWidth = 6
    , normalBorderColor = colorNormalBorderColor
    , focusedBorderColor = colorFocusedBorderColor
    , layoutHook = avoidStruts $ toggleLayouts fullLayout normalLayout
    , manageHook = manageHook defaultConfig <+> manageDocks
    , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
    , logHook = myLogHook dzenLeft
    }
    
    `additionalKeys`
    [ 
      -- Full screen
      ((modm, xK_f), sendMessage ToggleLayout) 
      
      -- Dmenu
      , ((modm, xK_p), spawn "~/.dmenurc") 

      -- restart xmonad
      , ((mod4Mask, xK_q), spawn "killall dzen2 && killall feh && xmonad --restart")
    ]

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP 
  {
      ppCurrent = dzenColor colorDzenBackground colorDzenForeground . pad . pad
    --, ppVisible = id
     , ppHidden = id . pad . pad
    -- , ppHiddenNoWindows = id
    -- , ppUrgent = id
    -- , ppWsSep = " "
    -- , ppSep = " | "
    , ppLayout = const ""
    , ppTitle = const ""
    , ppOutput = hPutStrLn h . ("  " ++)
  }

myStartupHook = do
  -- spawn "hhp" -- hide mouse cursor
  spawn "feh --bg-fill ~/Pictures/wallpapers/wallpaper-gradient.png"
  -- spawn "compton --config ~/.config/compton/compton.conf -b"

fullLayout = Full
--fullLayout = avoidStruts $ noBorders Full

normalLayout = 
  (smartSpacing 8 $ ResizableTall 1 (3/100) (3/5) [])

-------------------------------------------------------------------------------
-- xmonad.hs for xmonad-darcs
-------------------------------------------------------------------------------
-- Compiler flags --
{-# LANGUAGE NoMonomorphismRestriction #-}

-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import XMonad.Util.Run (safeSpawn)

-- actions
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops --for handling full screen chrome

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.Tabbed
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.GridVariants
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.WindowNavigation

-------------------------------------------------------------------------------
-- Theme --
sbase03 =       "#002b36"
sbase02 =       "#073642"
sbase01 =       "#586e75"
sbase00 =       "#657b83"
sbase0  =       "#839496"
sbase1  =       "#93a1a1"
sbase2  =       "#eee8d5"
sbase3  =       "#fdf6e3"
syellow =       "#b58900"
sorange =       "#cb4b16"
sred    =       "#dc322f"
smagenta=       "#d33682"
sviolet =       "#6c71c4"
sblue   =       "#268bd2"
scyan   =       "#2aa198"
sgreen  =       "#859900"

-------------------------------------------------------------------------------
-- Main --
main :: IO ()
main = xmonad =<< statusBar cmd pp kb conf
  where 
    uhook = withUrgencyHookC NoUrgencyHook urgentConfig
    cmd = "bash -c \"tee >(xmobar -x0) | xmobar -x1\""
    pp = customPP
    kb = toggleStrutsKey
    conf = uhook myConfig

-------------------------------------------------------------------------------
-- Configs --
myConfig = defaultConfig { workspaces = workspaces'
                         , modMask = modMask'
			 , handleEventHook = fullscreenEventHook
                         , borderWidth = borderWidth'
                         , normalBorderColor = normalBorderColor'
                         , focusedBorderColor = focusedBorderColor'
                         , terminal = terminal'
                         , keys = keys'
                         , layoutHook = avoidStruts $  layoutHook'
                         , manageHook = manageHook' <+> manageDocks
                         }

-------------------------------------------------------------------------------
-- Window Management --
manageHook' = composeAll [ isFullscreen             --> doFullFloat
			 -- [isFullscreen --> (doF W.focusDown <+> doFullFloat,
                         , className =? "Deluge"    --> doShift "0"
                         , insertPosition Below Newer
                         , transience'
                         ]


-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP = defaultPP { ppCurrent = xmobarColor sgreen "" . wrap "<" ">"
                     , ppHidden = xmobarColor syellow ""
                     , ppHiddenNoWindows = xmobarColor sbase0 ""
                     , ppUrgent = xmobarColor sred "" . wrap "[" "]" 
                     , ppLayout = xmobarColor "#C9A34E" ""
                     , ppTitle =  xmobarColor sorange "" . shorten 80
                     , ppSep = xmobarColor "#429942" "" " | "
                     }
-- GridSelect
myGSConfig = defaultGSConfig { gs_cellwidth = 160 }

-- urgent notification
urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

-- borders
borderWidth' = 3
normalBorderColor'  = sbase0
focusedBorderColor' = sred

-- tabs
tabTheme1 = defaultTheme { decoHeight = 16
                         , activeColor = sbase03
                         , activeBorderColor = "#a6c292"
                         , activeTextColor = sgreen
                         , inactiveBorderColor = sbase0
                         }

-- workspaces
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- layouts
layoutHook' = windowNavigation (tile ||| mtile ||| tab ||| full ||| sp)
  where
    golden = toRational (2/(1+sqrt(5)::Double))
    rt = ResizableTall 1 (2/100) (1/2) []
    tile = renamed [Replace "[]="] $ smartBorders rt
    mtile = renamed [Replace "M[]="] $ smartBorders $ Mirror rt
    tab = renamed [Replace "T"] $ noBorders $ tabbed shrinkText tabTheme1
    full = renamed [Replace "[]"] $ noBorders Full 
    sp =  renamed [Replace "[s]"] $ smartBorders $ spiral golden

-------------------------------------------------------------------------------
-- Terminal --
terminal' = "termite"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' = mod4Mask

-- keys
toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,               xK_e     ), safeSpawn (XMonad.terminal conf) []) 
    , ((modMask,               xK_p     ), safeSpawn "dmenu_run" []) 
    , ((modMask .|. shiftMask, xK_p     ), safeSpawn "gmrun" [])
    , ((modMask .|. shiftMask, xK_m     ), safeSpawn "claws-mail" [])
    , ((modMask,	       xK_w     ), safeSpawn "google-chrome" [])
    , ((modMask,               xK_f     ), spawn "termite -e ranger" )
    , ((modMask,               xK_i     ), safeSpawn "inkscape" [])
    , ((modMask .|. shiftMask, xK_g     ), safeSpawn "gimp" [])
    , ((modMask,	       xK_m     ), safeSpawn "matlab -desktop" [])
    , ((modMask,	       xK_v     ), safeSpawn "VirtualBox" [])
    , ((modMask .|. shiftMask, xK_m     ), safeSpawn "mendeleydesktop" [])
    -- , ((modMask,	       xK_o     ), safeSpawn "xterm" [])
    , ((modMask .|. shiftMask, xK_c     ), kill)

    -- grid
    , ((modMask              , xK_g     ), goToSelected myGSConfig)

    -- workspaces
    , ((modMask,	       xK_Left  ), prevWS)
    , ((modMask,	       xK_Right ), nextWS)
    , ((modMask,           xK_y     ), nextScreen)

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) 
    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_h     ), sendMessage $ Go XMonad.Layout.WindowNavigation.L)
    , ((modMask,               xK_l     ), sendMessage $ Go XMonad.Layout.WindowNavigation.R)
    , ((modMask,               xK_k     ), sendMessage $ Go XMonad.Layout.WindowNavigation.U)
    , ((modMask,               xK_j     ), sendMessage $ Go XMonad.Layout.WindowNavigation.D)
    --, ((modMask,               xK_j     ), windows W.focusDown)
    --, ((modMask,               xK_k     ), windows W.focusUp)
    -- , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask,               xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage $ Swap XMonad.Layout.WindowNavigation.L)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage $ Swap XMonad.Layout.WindowNavigation.R)
    , ((modMask .|. shiftMask, xK_k     ), sendMessage $ Swap XMonad.Layout.WindowNavigation.U)
    , ((modMask .|. shiftMask, xK_j     ), sendMessage $ Swap XMonad.Layout.WindowNavigation.D)
    --, ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    --, ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask .|. controlMask, xK_h     ), sendMessage Shrink)
    , ((modMask .|. controlMask, xK_l     ), sendMessage Expand)
    , ((modMask .|. controlMask, xK_j     ), sendMessage MirrorShrink)
    , ((modMask .|. controlMask, xK_k     ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- volume
    , ((0		     ,0x1008FF11), spawn "sh /usr/bin/vol_down")
    , ((0		     ,0x1008FF13), spawn "sh /usr/bin/vol_up")
    , ((0		     ,0x1008FF12), spawn "sh /usr/bin/mute_toggle")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- was greedyView instead of view
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_z, xK_x] [0..]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------


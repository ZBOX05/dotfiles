#Requires AutoHotkey v2.0
#NoTrayIcon  ; 不显示托盘图标
#SingleInstance Force
ProcessSetPriority "High" ; 提高脚本优先级，防止卡顿时脚本被系统挂起

; ==============================================================================
; 0. 自动提权
; ==============================================================================
if not A_IsAdmin {
    try Run '*RunAs "' A_ScriptFullPath '"'
    ExitApp
}

; ==============================================================================
; 全局配置：滚轮限流阈值 (毫秒)
; 如果觉得滚轮反应太慢，可以把 40 改小 (比如 20)；如果还是卡报警，改大 (比如 60)
; ==============================================================================
WheelDelay := 40

; ==============================================================================
; 1. 路径配置
; ==============================================================================

; Zen Browser
ZenPath := "E:\Application\Zen Browser\zen.exe"
if !FileExist(ZenPath)
    ZenPath := EnvGet("LocalAppData") . "\Zen Browser\zen.exe"

; QQ
QQPath := "E:\Application\Tencent\QQNT\QQ.exe"

; Windows Terminal
WTPath := "explorer.exe shell:AppsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App"

; Spotify (UWP 应用，用 Shell 方式启动)
SpotifyPath := "explorer.exe shell:AppsFolder\SpotifyAB.SpotifyMusic_zpdnekdrzrea0!Spotify"

; ==============================================================================
; 2. App 管理函数
; ==============================================================================
ManageApp(winTitle, exePath, mode := "Open") {
    if (mode == "Close") {
        DetectHiddenWindows True
        if WinExist(winTitle)
            WinClose(winTitle)
        DetectHiddenWindows False
        return
    }

    ; 第一步：检查可见窗口（不开 DetectHiddenWindows）
    if WinExist(winTitle) {
        try {
            WinActivate(winTitle)
            if (WinGetMinMax(winTitle) == -1)
                WinRestore(winTitle)
            WinActivate(winTitle)
        }
        catch {
            try Run exePath
        }
        return
    }

    ; 第二步：检查隐藏窗口（托盘应用）
    DetectHiddenWindows True
    if WinExist(winTitle) {
        hwnd := WinExist(winTitle)
        DetectHiddenWindows False
        try {
            ; 用 PostMessage SC_RESTORE 恢复窗口，比 WinShow 更温和
            ; WM_SYSCOMMAND = 0x0112, SC_RESTORE = 0xF120
            PostMessage 0x0112, 0xF120, 0, , "ahk_id " hwnd
            Sleep 150  ; 给应用时间响应
            WinActivate("ahk_id " hwnd)
        }
        catch {
            try Run exePath
        }
        return
    }
    DetectHiddenWindows False

    ; 第三步：真的没有窗口 -> 启动程序
    try
        Run exePath
    catch
        MsgBox "找不到程序，请检查路径是否正确: `n" exePath
}

; --- Win + 键 跳转 ---
#z:: ManageApp("ahk_exe zen.exe", ZenPath, "Open")
+#z:: ManageApp("ahk_exe zen.exe", ZenPath, "Close")

#q:: ManageApp("ahk_exe QQ.exe", QQPath, "Open")
+#q:: ManageApp("ahk_exe QQ.exe", QQPath, "Close")

#t:: ManageApp("ahk_exe WindowsTerminal.exe", WTPath, "Open")
+#t:: ManageApp("ahk_exe WindowsTerminal.exe", WTPath, "Close")

#s:: ManageApp("ahk_exe Spotify.exe", SpotifyPath, "Open")
+#s:: ManageApp("ahk_exe Spotify.exe", SpotifyPath, "Close")

; ==============================================================================
; 3. 鼠标侧键增强 (God Mode)
; ==============================================================================

; ------------------------------------------------------------------------------
; A. 前进键 (XButton2) - 操作层
; ------------------------------------------------------------------------------

; 1. 移动窗口
XButton2 & LButton::
{
    Send "{Alt down}{LButton down}"
    KeyWait "LButton"
    Send "{LButton up}{Alt up}"
}

; 2. 调整大小
XButton2 & RButton::
{
    Send "{Alt down}{RButton down}"
    KeyWait "RButton"
    Send "{RButton up}{Alt up}"
}

; 3. 切换窗口 (Alt+Tab) -> 滚轮上下 (这里不加限流，因为AltTab自带系统级节奏，加了反而卡)
XButton2 & WheelDown::AltTab
XButton2 & WheelUp::ShiftAltTab

; 4. 关闭窗口 (点击右上角叉号效果) -> 滚轮向右
XButton2 & WheelRight:: WinClose "A"

; 5. 最大化 -> 滚轮向左
XButton2 & WheelLeft:: WinMaximize "A"

; 6. 三段式
XButton2 & MButton::
{
    try {
        status := WinGetMinMax("A")
        if (status == 1)
            WinRestore "A"
        else if (status == 0)
            WinMinimize "A"
    }
}

; 恢复前进键默认功能
XButton2:: Send "{Browser_Forward}"

; ------------------------------------------------------------------------------
; B. 后退键 (XButton1) - 状态与布局层
; ------------------------------------------------------------------------------

; 1. 切换到上一个工作区 -> 滚轮向上 【已修复：增加限流】
XButton1 & WheelUp::
{
    if (A_TimeSincePriorHotkey < WheelDelay) ; 限流检查
        return
    Send "!s"
}

; 2. 切换到下一个工作区 -> 滚轮向下 【已修复：增加限流】
XButton1 & WheelDown::
{
    if (A_TimeSincePriorHotkey < WheelDelay)
        return
    Send "!a"
}

; 3. GlazeWM 窗口左移
XButton1 & WheelLeft:: Send "!+{Left}"

; 4. GlazeWM 窗口右移
XButton1 & WheelRight:: Send "!+{Right}"

; 5. 刷新当前活动窗口 -> 按住后退侧键，再按鼠标中键
XButton1 & MButton::
{
    if WinActive("ahk_exe ChatGPT.exe")
        Send "^r"
    else
        Send "{F5}"
}

; 恢复后退键默认功能
XButton1:: Send "{Browser_Back}"

; ==============================================================================
; 4. Tab / Ctrl / RButton 逻辑 (已修复：增加限流)
; ==============================================================================

GroupAdd "RButtonApps", "ahk_exe firefox.exe"
GroupAdd "RButtonApps", "ahk_exe explorer.exe"
GroupAdd "RButtonApps", "ahk_exe msedge.exe"
GroupAdd "RButtonApps", "ahk_exe Code.exe"
GroupAdd "RButtonApps", "ahk_exe zen.exe"
GroupAdd "RButtonApps", "ahk_exe Obsidian.exe"
GroupAdd "RButtonApps", "ahk_exe Acrobat.exe"
GroupAdd "RButtonApps", "ahk_exe WindowsTerminal.exe"
GroupAdd "RButtonApps", "ahk_exe ChatGPT.exe"
GroupAdd "RButtonApps", "ahk_exe vitis-ide.exe"
GroupAdd "RButtonApps", "ahk_exe chrome.exe"
GroupAdd "RButtonApps", "ahk_exe QQ.exe"
GroupAdd "RButtonApps", "ahk_exe Spotify.exe"

global g_rbutton_scrolled := false

#HotIf WinActive("ahk_group RButtonApps")
RButton::
{
    global g_rbutton_scrolled := false
    KeyWait "RButton"
    if (!g_rbutton_scrolled)
        Send "{RButton}"
}
#HotIf

; --- 下面的滚轮逻辑是最容易导致报警的地方，已全部添加防抖 ---

#HotIf WinActive("ahk_group RButtonApps") and !WinActive("ahk_exe QQ.exe") and GetKeyState("RButton", "P")
WheelUp::
{
    if (A_TimeSincePriorHotkey < WheelDelay) ; 防止一次滚动触发50次Tab
        return
    global g_rbutton_scrolled := true
    SendInput "^+{Tab}"
}
WheelDown::
{
    if (A_TimeSincePriorHotkey < WheelDelay)
        return
    global g_rbutton_scrolled := true
    SendInput "^{Tab}"
}
WheelLeft::
{
    global g_rbutton_scrolled := true
    SendInput "^t"
}
WheelRight::
{
    global g_rbutton_scrolled := true
    SendInput "^w"
}
#HotIf

#HotIf WinActive("ahk_exe QQ.exe") and GetKeyState("RButton", "P")
WheelUp::
{
    if (A_TimeSincePriorHotkey < WheelDelay)
        return
    global g_rbutton_scrolled := true
    SendInput "^{Up}"
}
WheelDown::
{
    if (A_TimeSincePriorHotkey < WheelDelay)
        return
    global g_rbutton_scrolled := true
    SendInput "^{Down}"
}
WheelLeft::
{
    global g_rbutton_scrolled := true
    SendInput "^f"
}
WheelRight::
{
    global g_rbutton_scrolled := true
    SendInput "^h"
}
#HotIf

^+F5:: Reload
^+F12:: ExitApp
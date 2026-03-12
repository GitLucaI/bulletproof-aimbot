local _g1 = game:GetService("Players")
local _g2 = game:GetService("Teams") 
local _g3 = game:GetService("UserInputService")
local _g4 = game:GetService("RunService")
local _ts = game:GetService("TweenService")
local _p0 = _g1.LocalPlayer
local _c0 = workspace.CurrentCamera

local _S = {
    _L = {}, 
    _A = false, 
    _T = nil, 
    _P = "Head",
    _K1 = Enum.UserInputType.MouseButton2,
    _K2 = Enum.UserInputType.MouseButton3,
    _Sp = 1,
    _mK = nil,
    _op = true,
    _V = {
        _m = Color3.fromRGB(24, 26, 30),
        _h = Color3.fromRGB(34, 37, 43),
        _s = Color3.fromRGB(0, 255, 127),
        _u = Color3.fromRGB(255, 65, 65),
        _ac = Color3.fromRGB(50, 55, 65)
    }
}

local _G = Instance.new("ScreenGui", _p0.PlayerGui)
_G.Name = "B_P_A_" .. math.random(100, 999)
_G.ResetOnSpawn = false

local function _rnd(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
end

local _M = Instance.new("Frame", _G)
_M.Size = UDim2.new(0, 380, 0, 580)
_M.Position = UDim2.new(0.5, -190, 0.5, -290)
_M.BackgroundColor3 = _S._V._m
_M.BorderSizePixel = 0
_M.Active = true
_M.Draggable = true
_M.ClipsDescendants = true
_rnd(_M, 15)

local _H = Instance.new("Frame", _M)
_H.Size = UDim2.new(1, 0, 0, 50)
_H.BackgroundColor3 = _S._V._h
_rnd(_H, 15)

local _Tl = Instance.new("TextLabel", _H)
_Tl.Size = UDim2.new(1, -100, 1, 0)
_Tl.Position = UDim2.new(0, 15, 0, 0)
_Tl.BackgroundTransparency = 1
_Tl.Text = "Bulletproof Aimbot"
_Tl.TextColor3 = Color3.new(1, 1, 1)
_Tl.Font = Enum.Font.Code
_Tl.TextSize = 18
_Tl.TextXAlignment = Enum.TextXAlignment.Left

local _mB = Instance.new("TextButton", _H)
_mB.Size = UDim2.new(0, 35, 0, 35)
_mB.Position = UDim2.new(1, -45, 0.5, -17)
_mB.BackgroundColor3 = _S._V._ac
_mB.Text = "-"
_mB.TextColor3 = Color3.new(1, 1, 1)
_mB.Font = Enum.Font.Code
_mB.TextSize = 20
_rnd(_mB, 8)

local _Cn = Instance.new("Frame", _M)
_Cn.Size = UDim2.new(1, 0, 1, -50)
_Cn.Position = UDim2.new(0, 0, 0, 50)
_Cn.BackgroundTransparency = 1

local _Sf = Instance.new("ScrollingFrame", _Cn)
_Sf.Size = UDim2.new(1, -20, 0, 200)
_Sf.Position = UDim2.new(0, 10, 0, 10)
_Sf.BackgroundColor3 = _S._V._ac
_Sf.BackgroundTransparency = 0.8
_Sf.BorderSizePixel = 0
_Sf.ScrollBarThickness = 1
_rnd(_Sf, 10)

local _Ly = Instance.new("UIListLayout", _Sf)
_Ly.Padding = UDim.new(0, 6)

local function _gnr()
    local n, d = nil, math.huge
    for p, v in pairs(_S._L) do
        if v and p ~= _p0 and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            local mR = _p0.Character and _p0.Character:FindFirstChild("HumanoidRootPart")
            if r and mR then
                local m = (r.Position - mR.Position).Magnitude
                if m < d then d = m n = p end
            end
        end
    end
    return n
end

local function _updBtn(p)
    local b = _Sf:FindFirstChild(p.Name)
    if b then b.BackgroundColor3 = _S._L[p] and _S._V._s or _S._V._u end
end

local function _tgl(p, v)
    if p == _p0 then return end
    _S._L[p] = (v ~= nil and v or not _S._L[p])
    _updBtn(p)
end

local function _rfsh()
    for _, x in pairs(_Sf:GetChildren()) do if x:IsA("TextButton") then x:Destroy() end end
    for _, t in pairs(_g2:GetTeams()) do
        local b = Instance.new("TextButton", _Sf)
        b.Size = UDim2.new(1, -10, 0, 30)
        b.Text = " [TEAM] " .. t.Name:upper()
        b.BackgroundColor3 = _S._V._h
        b.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        b.Font = Enum.Font.Code
        _rnd(b, 5)
        b.MouseButton1Click:Connect(function()
            local plrs = t:GetPlayers()
            if #plrs > 0 then
                local s = not _S._L[plrs[1]]
                for _, p in pairs(plrs) do _tgl(p, s) end
            end
        end)
    end
    for _, p in pairs(_g1:GetPlayers()) do
        if p ~= _p0 then
            local b = Instance.new("TextButton", _Sf)
            b.Name = p.Name
            b.Size = UDim2.new(1, -10, 0, 30)
            b.Text = " " .. p.Name
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Font = Enum.Font.Code
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.BackgroundColor3 = _S._L[p] and _S._V._s or _S._V._u
            _rnd(b, 5)
            b.MouseButton1Click:Connect(function() _tgl(p) end)
        end
    end
end

local _Ct = Instance.new("Frame", _Cn)
_Ct.Size = UDim2.new(1, -20, 0, 260)
_Ct.Position = UDim2.new(0, 10, 0, 220)
_Ct.BackgroundTransparency = 1

local function _bldB(txt, pos, sz, cb)
    local b = Instance.new("TextButton", _Ct)
    b.Size = sz or UDim2.new(0.31, 0, 0, 35)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = _S._V._ac
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 11
    _rnd(b, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

_bldB("HEAD", UDim2.new(0,0,0,0), nil, function() _S._P = "Head" end)
_bldB("TORSO", UDim2.new(0.34,0,0,0), nil, function() _S._P = "UpperTorso" end)
_bldB("LEGS", UDim2.new(0.68,0,0,0), nil, function() _S._P = "LeftLowerLeg" end)
_bldB("ALL", UDim2.new(0,0,0,40), UDim2.new(0.48,0,0,35), function() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, true) end end)
_bldB("NONE", UDim2.new(0.52,0,0,40), UDim2.new(0.48,0,0,35), function() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, false) end end)

local _AtB = _bldB("AUTO MODE: OFF", UDim2.new(0,0,0,80), UDim2.new(1,0,0,35), function()
    _S._A = not _S._A
    _AtB.Text = "AUTO MODE: " .. (_S._A and "ON" or "OFF")
    _AtB.BackgroundColor3 = _S._A and _S._V._s or _S._V._ac
end)

local _SpB = _bldB("SPEED: 100%", UDim2.new(0,0,0,120), UDim2.new(1,0,0,35), function()
    _S._Sp = (_S._Sp <= 0.2) and 1 or _S._Sp - 0.2
end)

local _K1B = _bldB("BIND LOCK: MB2", UDim2.new(0,0,0,160), UDim2.new(0.48,0,0,35), function() _S._mK = "K1" end)
local _K2B = _bldB("BIND SWIT: MB3", UDim2.new(0.52,0,0,160), UDim2.new(0.48,0,0,35), function() _S._mK = "K2" end)

local _Inf = Instance.new("TextLabel", _M)
_Inf.Size = UDim2.new(1, -20, 0, 50)
_Inf.Position = UDim2.new(0, 10, 1, -55)
_Inf.BackgroundTransparency = 1
_Inf.Text = "SYS_READY..."
_Inf.TextColor3 = Color3.new(0.6, 0.6, 0.6)
_Inf.Font = Enum.Font.Code
_Inf.TextSize = 11

_mB.MouseButton1Click:Connect(function()
    _S._op = not _S._op
    _mB.Text = _S._op and "-" or "+"
    _ts:Create(_M, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {Size = _S._op and UDim2.new(0, 380, 0, 580) or UDim2.new(0, 380, 0, 50)}):Play()
end)

_g4.RenderStepped:Connect(function()
    if _S._mK then _Inf.Text = "LISTENING FOR INPUT..." return end
    if _S._A then local n = _gnr() if n then _S._T = n end end
    if _S._T and _S._T.Character and _S._T.Character:FindFirstChild("Humanoid") and _S._T.Character.Humanoid.Health <= 0 then
        _S._T = _S._A and _gnr() or nil
    end
    local iP = false
    if _S._K1.Name:find("MouseButton") then iP = _g3:IsMouseButtonPressed(_S._K1) else iP = _g3:IsKeyDown(_S._K1) end
    if iP and _S._T then
        local c = _S._T.Character
        local p = c and c:FindFirstChild(_S._P)
        if p then
            local _l = CFrame.lookAt(_c0.CFrame.Position, p.Position)
            _c0.CFrame = _c0.CFrame:Lerp(_l, _S._Sp)
        end
    end
    _SpB.Text = "LOCK SPEED: " .. math.floor(_S._Sp * 100) .. "%"
    _Inf.Text = "TARGET: " .. (_S._T and _S._T.Name:upper() or "NONE") .. "\nPART: " .. _S._P:upper()
end)

_g3.InputBegan:Connect(function(i, g)
    if _S._mK then
        local _k = (i.UserInputType == Enum.UserInputType.Keyboard) and i.KeyCode or i.UserInputType
        if _S._mK == "K1" then _S._K1 = _k _K1B.Text = "LOCK: " .. _k.Name
        elseif _S._mK == "K2" then _S._K2 = _k _K2B.Text = "SWIT: " .. _k.Name end
        _S._mK = nil return
    end
    if not g and i.UserInputType == _S._K2 then _S._T = _gnr() end
end)

_g1.PlayerAdded:Connect(_rfsh)
_g1.PlayerRemoving:Connect(function(p) _S._L[p] = nil _rfsh() end)
_rfsh()

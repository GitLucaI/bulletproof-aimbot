local _g1 = game:GetService("Players")
local _g2 = game:GetService("Teams") 
local _g3 = game:GetService("UserInputService")
local _g4 = game:GetService("RunService")
local _ts = game:GetService("TweenService")
local _cg = game:GetService("CoreGui")
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
    _E = false,
    _W = false,
    _Tr = false,
    _Fv = false,
    _Fr = 150,
    _OpM = false,
    _V = {
        _m = Color3.fromRGB(20, 22, 26),
        _h = Color3.fromRGB(30, 32, 38),
        _s = Color3.fromRGB(0, 200, 100),
        _u = Color3.fromRGB(200, 50, 50),
        _ac = Color3.fromRGB(45, 48, 55)
    }
}

local _G = Instance.new("ScreenGui")
_G.Name = "B_P_A_EXTREME"
_G.ResetOnSpawn = false
_G.DisplayOrder = 9999
_G.Parent = _cg

local _fO = Drawing.new("Circle")
_fO.Visible = false
_fO.Thickness = 1.5
_fO.Color = Color3.new(1, 1, 1)
_fO.Transparency = 0.7
_fO.NumSides = 64
_fO.Radius = _S._Fr

local _tL = {}

local function _rnd(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
end

local _M = Instance.new("Frame", _G)
_M.Size = UDim2.new(0, 380, 0, 700)
_M.Position = UDim2.new(0.5, -190, 0.5, -350)
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
_Tl.Text = "OVERLORD TARGETING SYSTEM"
_Tl.TextColor3 = Color3.new(1, 1, 1)
_Tl.Font = Enum.Font.Code
_Tl.TextSize = 16
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
_Sf.Size = UDim2.new(1, -20, 0, 160)
_Sf.Position = UDim2.new(0, 10, 0, 10)
_Sf.BackgroundColor3 = _S._V._ac
_Sf.BackgroundTransparency = 0.8
_Sf.BorderSizePixel = 0
_Sf.ScrollBarThickness = 1
_rnd(_Sf, 10)

local _Ly = Instance.new("UIListLayout", _Sf)
_Ly.Padding = UDim.new(0, 6)
_Ly.SortOrder = Enum.SortOrder.LayoutOrder

local function _vChk(p)
    if not _S._W then return true end
    local c = _p0.Character
    if not c or not p then return false end
    local rP = p:FindFirstChild(_S._P)
    local mP = c:FindFirstChild("Head")
    if not rP or not mP then return false end
    local rPms = RaycastParams.new()
    rPms.FilterType = Enum.RaycastFilterType.Exclude
    rPms.FilterDescendantsInstances = {c, p.Parent}
    local r = workspace:Raycast(mP.Position, (rP.Position - mP.Position).Unit * (rP.Position - mP.Position).Magnitude, rPms)
    return not r
end

local function _inFov(p)
    if not _S._Fv then return true end
    local c = p.Character
    if not c or not c:FindFirstChild(_S._P) then return false end
    local screenPos, onScreen = _c0:WorldToViewportPoint(c[_S._P].Position)
    if not onScreen then return false end
    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2)).Magnitude
    return dist <= _S._Fr
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
        b.LayoutOrder = 1
        _rnd(b, 5)
        b.MouseButton1Click:Connect(function()
            local plrs = t:GetPlayers()
            if #plrs > 0 then
                local s = not _S._L[plrs[1]]
                for _, p in pairs(plrs) do _tgl(p, s) end
                b.BackgroundColor3 = s and _S._V._s or _S._V._h
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
            b.LayoutOrder = 999
            b.BackgroundColor3 = _S._L[p] and _S._V._s or _S._V._u
            _rnd(b, 5)
            b.MouseButton1Click:Connect(function() _tgl(p) end)
        end
    end
end

local _Ct = Instance.new("Frame", _Cn)
_Ct.Size = UDim2.new(1, -20, 0, 480)
_Ct.Position = UDim2.new(0, 10, 0, 180)
_Ct.BackgroundTransparency = 1

local function _bldB(txt, pos, sz, cb)
    local b = Instance.new("TextButton", _Ct)
    b.Size = sz or UDim2.new(0.31, 0, 0, 30)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = _S._V._ac
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 10
    _rnd(b, 6)
    b.MouseButton1Click:Connect(function() cb(b) end)
    return b
end

_bldB("HEAD", UDim2.new(0,0,0,0), nil, function() _S._P = "Head" end)
_bldB("TORSO", UDim2.new(0.34,0,0,0), nil, function() _S._P = "UpperTorso" end)
_bldB("LEGS", UDim2.new(0.68,0,0,0), nil, function() _S._P = "LeftLowerLeg" end)
_bldB("SELECT ALL", UDim2.new(0,0,0,36), UDim2.new(0.48,0,0,30), function() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, true) end end)
_bldB("DESELECT ALL", UDim2.new(0.52,0,0,36), UDim2.new(0.48,0,0,30), function() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, false) end end)

local _OpB = _bldB("OPPOSING TEAM", UDim2.new(0,0,0,72), UDim2.new(1,0,0,30), function(b) 
    _S._OpM = not _S._OpM 
    b.BackgroundColor3 = _S._OpM and _S._V._s or _S._V._u
    for _,p in pairs(_g1:GetPlayers()) do if p ~= _p0 then _tgl(p, _S._OpM and p.Team ~= _p0.Team or false) end end 
end)
_OpB.BackgroundColor3 = _S._V._u

local _AtB = _bldB("AUTO LOCK", UDim2.new(0,0,0,108), UDim2.new(1,0,0,30), function(b) _S._A = not _S._A b.BackgroundColor3 = _S._A and _S._V._s or _S._V._u end)
_AtB.BackgroundColor3 = _S._V._u

local _EsB = _bldB("TOGGLE ESP / CHAMS", UDim2.new(0,0,0,144), UDim2.new(1,0,0,30), function(b) _S._E = not _S._E b.BackgroundColor3 = _S._E and _S._V._s or _S._V._u end)
_EsB.BackgroundColor3 = _S._V._u

local _TrB = _bldB("TOGGLE TRACERS", UDim2.new(0,0,0,180), UDim2.new(1,0,0,30), function(b) _S._Tr = not _S._Tr b.BackgroundColor3 = _S._Tr and _S._V._s or _S._V._u end)
_TrB.BackgroundColor3 = _S._V._u

local _FvB = _bldB("TOGGLE FOV CIRCLE", UDim2.new(0,0,0,216), UDim2.new(1,0,0,30), function(b) _S._Fv = not _S._Fv b.BackgroundColor3 = _S._Fv and _S._V._s or _S._V._u _fO.Visible = _S._Fv end)
_FvB.BackgroundColor3 = _S._V._u

local _WcB = _bldB("WALL CHECK", UDim2.new(0,0,0,252), UDim2.new(1,0,0,30), function(b) _S._W = not _S._W b.BackgroundColor3 = _S._W and _S._V._s or _S._V._u end)
_WcB.BackgroundColor3 = _S._V._u

local _SpB = _bldB("LOCK SPEED: 100%", UDim2.new(0,0,0,288), UDim2.new(1,0,0,30), function(b) _S._Sp = (_S._Sp <= 0.2) and 1 or _S._Sp - 0.2 b.Text = "LOCK SPEED: " .. math.floor(_S._Sp * 100) .. "%" end)

local _K1B = _bldB("BIND LOCK: MB2", UDim2.new(0,0,0,324), UDim2.new(0.48,0,0,30), function() _S._mK = "K1" end)
local _K2B = _bldB("BIND SWITCH: MB3", UDim2.new(0.52,0,0,324), UDim2.new(0.48,0,0,30), function() _S._mK = "K2" end)

local _Inf = Instance.new("TextLabel", _M)
_Inf.Size = UDim2.new(1, -20, 0, 45)
_Inf.Position = UDim2.new(0, 10, 1, -50)
_Inf.BackgroundTransparency = 1
_Inf.Text = "READY"
_Inf.TextColor3 = Color3.new(0.6, 0.6, 0.6)
_Inf.Font = Enum.Font.Code
_Inf.TextSize = 10

_mB.MouseButton1Click:Connect(function()
    _S._op = not _S._op
    _mB.Text = _S._op and "-" or "+"
    _ts:Create(_M, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = _S._op and UDim2.new(0, 380, 0, 700) or UDim2.new(0, 380, 0, 50)}):Play()
end)

local function _gnr()
    local n, d = nil, math.huge
    for p, v in pairs(_S._L) do
        if v and p ~= _p0 and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            if _vChk(p.Character) and _inFov(p) then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                local mR = _p0.Character and _p0.Character:FindFirstChild("HumanoidRootPart")
                if r and mR then
                    local m = (r.Position - mR.Position).Magnitude
                    if m < d then d = m n = p end
                end
            end
        end
    end
    return n
end

_g4.RenderStepped:Connect(function()
    if _S._mK then _Inf.Text = "LISTENING..." return end
    if _S._A then local n = _gnr() if n then _S._T = n end end
    if _S._T and (_S._T.Character == nil or (_S._T.Character:FindFirstChild("Humanoid") and _S._T.Character.Humanoid.Health <= 0) or not _vChk(_S._T.Character) or not _inFov(_S._T)) then
        _S._T = _S._A and _gnr() or nil
    end

    local iP = false
    if _S._K1.Name:find("MouseButton") then iP = _g3:IsMouseButtonPressed(_S._K1) else iP = _g3:IsKeyDown(_S._K1) end
    if iP and _S._T then
        local c = _S._T.Character
        local p = c and c:FindFirstChild(_S._P)
        if p then _c0.CFrame = _c0.CFrame:Lerp(CFrame.lookAt(_c0.CFrame.Position, p.Position), _S._Sp) end
    end

    _fO.Position = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2)
    _fO.Visible = _S._Fv
    _Inf.Text = "TARGET: " .. (_S._T and _S._T.Name:upper() or "NONE") .. " | PART: " .. _S._P:upper()

    for _, p in pairs(_g1:GetPlayers()) do
        if p == _p0 then continue end
        local c = p.Character
        local s = _S._L[p] and _S._E
        
        if not _tL[p] then _tL[p] = Drawing.new("Line") end
        local tracer = _tL[p]
        tracer.Visible = false

        if c and c:FindFirstChild("HumanoidRootPart") then
            local r = c.HumanoidRootPart
            local h = c:FindFirstChild("BPA_H") or Instance.new("Highlight", c)
            h.Name = "BPA_H"
            h.Enabled = s
            h.FillTransparency = 0.5
            h.OutlineColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            h.FillColor = Color3.new(1, 1, 1)

            local b = r:FindFirstChild("BPA_E") or Instance.new("BillboardGui", r)
            b.Name = "BPA_E"
            b.AlwaysOnTop = true
            b.Size = UDim2.new(0, 100, 0, 50)
            b.ExtentsOffset = Vector3.new(0, 3, 0)
            b.Enabled = s
            
            local l = b:FindFirstChild("Txt") or Instance.new("TextLabel", b)
            l.Name = "Txt"
            l.BackgroundTransparency = 1
            l.Size = UDim2.new(1, 0, 1, 0)
            l.Font = Enum.Font.Code
            l.TextSize = 12
            l.TextColor3 = p.TeamColor.Color
            l.TextStrokeTransparency = 0
            l.TextStrokeColor3 = Color3.new(0, 0, 0)
            local dist = _p0.Character and _p0.Character:FindFirstChild("HumanoidRootPart") and math.floor((r.Position - _p0.Character.HumanoidRootPart.Position).Magnitude) or 0
            l.Text = p.Name .. "\n" .. dist .. " studs"

            if _S._Tr and _S._L[p] then
                local screenPos, onScreen = _c0:WorldToViewportPoint(r.Position)
                if onScreen then
                    tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                    tracer.From = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y)
                    tracer.Color = p.TeamColor.Color
                    tracer.Thickness = 1
                    tracer.Transparency = 0.8
                    tracer.Visible = true
                end
            end
        end
    end
end)

_g3.InputBegan:Connect(function(i, g)
    if _S._mK then
        local _k = (i.UserInputType == Enum.UserInputType.Keyboard) and i.KeyCode or i.UserInputType
        if _S._mK == "K1" then _S._K1 = _k _K1B.Text = "LOCK: " .. _k.Name
        elseif _S._mK == "K2" then _S._K2 = _k _K2B.Text = "SWITCH: " .. _k.Name end
        _S._mK = nil return
    end
    if not g and i.UserInputType == _S._K2 then _S._T = _gnr() end
end)

local function _dynUpd(p)
    if _S._OpM then _tgl(p, p.Team ~= _p0.Team) end
    p:GetPropertyChangedSignal("Team"):Connect(function()
        if _S._OpM then _tgl(p, p.Team ~= _p0.Team) end
        _rfsh()
    end)
end

_g1.PlayerAdded:Connect(function(p)
    _dynUpd(p)
    _rfsh()
end)

_g1.PlayerRemoving:Connect(function(p)
    _S._L[p] = nil
    if _tL[p] then _tL[p]:Remove() _tL[p] = nil end
    _rfsh()
end)

for _, p in pairs(_g1:GetPlayers()) do _dynUpd(p) end
_rfsh()

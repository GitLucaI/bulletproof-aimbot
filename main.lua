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
    _C_Es = {Mode = "Rainbow", Color = Color3.new(1,1,1)},
    _C_Tr = {Mode = "Team", Color = Color3.new(1,1,1)},
    _C_Fv = {Mode = "Static", Color = Color3.new(1,1,1)},
    _V = {
        _m = Color3.fromRGB(15, 17, 20),
        _h = Color3.fromRGB(25, 27, 32),
        _s = Color3.fromRGB(0, 255, 150),
        _u = Color3.fromRGB(255, 70, 70),
        _ac = Color3.fromRGB(35, 38, 45)
    }
}

local _G = Instance.new("ScreenGui")
_G.Name = "B_P_A_EXTREME"
_G.ResetOnSpawn = false
_G.DisplayOrder = 9999
_G.Parent = _cg

local function _rnd(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
end

local _fO = Drawing.new("Circle")
_fO.Visible = false
_fO.Thickness = 2
_fO.NumSides = 64
_fO.Radius = _S._Fr

local _tL = {}

local _M = Instance.new("Frame", _G)
_M.Size = UDim2.new(0, 380, 0, 700)
_M.Position = UDim2.new(0.5, -190, 0.5, -350)
_M.BackgroundColor3 = _S._V._m
_M.BorderSizePixel = 0
_M.Active = true
_M.Draggable = true
_M.ClipsDescendants = true
_rnd(_M, 12)

local _CP = Instance.new("Frame", _G)
_CP.Size = UDim2.new(0, 280, 0, 350)
_CP.Position = UDim2.new(0.5, 200, 0.5, -175)
_CP.BackgroundColor3 = _S._V._h
_CP.Visible = false
_CP.Active = true
_CP.Draggable = true
_rnd(_CP, 10)

local _CW = Instance.new("ImageButton", _CP)
_CW.Size = UDim2.new(0, 150, 0, 150)
_CW.Position = UDim2.new(0.5, -75, 0, 40)
_CW.Image = "rbxassetid://2849323573"
_CW.BackgroundTransparency = 1

local _R_In = Instance.new("TextBox", _CP)
_R_In.Size = UDim2.new(0, 40, 0, 30)
_R_In.Position = UDim2.new(0.1, 0, 0, 200)
_R_In.Text = "255"
_R_In.BackgroundColor3 = _S._V._ac
_R_In.TextColor3 = Color3.new(1,0,0)
_rnd(_R_In, 4)

local _G_In = _R_In:Clone()
_G_In.Parent = _CP
_G_In.Position = UDim2.new(0.4, 0, 0, 200)
_G_In.TextColor3 = Color3.new(0,1,0)

local _B_In = _R_In:Clone()
_B_In.Parent = _CP
_B_In.Position = UDim2.new(0.7, 0, 0, 200)
_B_In.TextColor3 = Color3.new(0,0,1)

local _cur_cfg = nil
local function _setMode(m) if _cur_cfg then _cur_cfg.Mode = m end end

local _btn_R = Instance.new("TextButton", _CP)
_btn_R.Size = UDim2.new(0.28, 0, 0, 30)
_btn_R.Position = UDim2.new(0.04, 0, 0, 250)
_btn_R.Text = "RAINBOW"
_btn_R.BackgroundColor3 = _S._V._ac
_btn_R.TextColor3 = Color3.new(1,1,1)
_rnd(_btn_R, 5)
_btn_R.MouseButton1Click:Connect(function() _setMode("Rainbow") end)

local _btn_S = _btn_R:Clone()
_btn_S.Parent = _CP
_btn_S.Position = UDim2.new(0.36, 0, 0, 250)
_btn_S.Text = "SELECTED"
_btn_S.MouseButton1Click:Connect(function() _setMode("Static") end)

local _btn_T = _btn_R:Clone()
_btn_T.Parent = _CP
_btn_T.Position = UDim2.new(0.68, 0, 0, 250)
_btn_T.Text = "TEAM"
_btn_T.MouseButton1Click:Connect(function() _setMode("Team") end)

local _btn_Conf = _btn_R:Clone()
_btn_Conf.Parent = _CP
_btn_Conf.Size = UDim2.new(0.44, 0, 0, 35)
_btn_Conf.Position = UDim2.new(0.04, 0, 0, 300)
_btn_Conf.Text = "CONFIRM"
_btn_Conf.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
_btn_Conf.MouseButton1Click:Connect(function() 
    if _cur_cfg then _cur_cfg.Color = Color3.fromRGB(tonumber(_R_In.Text) or 0, tonumber(_G_In.Text) or 0, tonumber(_B_In.Text) or 0) end
    _CP.Visible = false 
end)

local _btn_Canc = _btn_Conf:Clone()
_btn_Canc.Parent = _CP
_btn_Canc.Position = UDim2.new(0.52, 0, 0, 300)
_btn_Canc.Text = "CANCEL"
_btn_Canc.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
_btn_Canc.MouseButton1Click:Connect(function() _CP.Visible = false end)

local _H = Instance.new("Frame", _M)
_H.Size = UDim2.new(1, 0, 0, 50)
_H.BackgroundColor3 = _S._V._h
_rnd(_H, 12)

local _Tl = Instance.new("TextLabel", _H)
_Tl.Size = UDim2.new(1, -100, 1, 0)
_Tl.Position = UDim2.new(0, 15, 0, 0)
_Tl.BackgroundTransparency = 1
_Tl.Text = "OVERLORD V6"
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

local function _updBtn(p)
    local b = _Sf:FindFirstChild(p.Name)
    if b then b.BackgroundColor3 = _S._L[p] and _S._V._s or _S._V._u end
end

local function _updTeamBtn(t, b)
    local plrs = t:GetPlayers()
    local active = #plrs > 0
    for _,p in pairs(plrs) do if not _S._L[p] then active = false break end end
    b.BackgroundColor3 = active and _S._V._s or _S._V._u
end

local function _tgl(p, v)
    if p == _p0 then return end
    _S._L[p] = (v ~= nil and v or not _S._L[p])
    _updBtn(p)
end

local function _clrAll()
    for _,p in pairs(_g1:GetPlayers()) do _S._L[p] = false end
end

local function _rfsh()
    for _, x in pairs(_Sf:GetChildren()) do if x:IsA("TextButton") then x:Destroy() end end
    for _, t in pairs(_g2:GetTeams()) do
        local b = Instance.new("TextButton", _Sf)
        b.Size = UDim2.new(1, -10, 0, 30)
        b.Text = " [TEAM] " .. t.Name:upper()
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.Code
        _rnd(b, 5)
        _updTeamBtn(t, b)
        b.MouseButton1Click:Connect(function()
            local plrs = t:GetPlayers()
            if #plrs > 0 then
                local s = not _S._L[plrs[1]]
                for _, p in pairs(plrs) do _tgl(p, s) end
                _updTeamBtn(t, b)
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
_Ct.Size = UDim2.new(1, -20, 0, 480)
_Ct.Position = UDim2.new(0, 10, 0, 180)
_Ct.BackgroundTransparency = 1

local function _bldB(txt, pos, sz, cb, rcb)
    local b = Instance.new("TextButton", _Ct)
    b.Size = sz or UDim2.new(0.31, 0, 0, 30)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = _S._V._ac
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 10
    _rnd(b, 6)
    b.MouseButton1Click:Connect(function() cb(b) _rfsh() end)
    if rcb then b.MouseButton2Click:Connect(function() rcb(b) end) end
    return b
end

local function _openCP(cfg, showTeam)
    _cur_cfg = cfg
    _btn_T.Visible = showTeam
    _CP.Visible = true
end

_bldB("HEAD", UDim2.new(0,0,0,0), nil, function() _S._P = "Head" end)
_bldB("TORSO", UDim2.new(0.34,0,0,0), nil, function() _S._P = "UpperTorso" end)
_bldB("LEGS", UDim2.new(0.68,0,0,0), nil, function() _S._P = "LeftLowerLeg" end)
_bldB("SELECT ALL", UDim2.new(0,0,0,36), UDim2.new(0.48,0,0,30), function() _clrAll() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, true) end end)
_bldB("DESELECT ALL", UDim2.new(0.52,0,0,36), UDim2.new(0.48,0,0,30), function() _clrAll() end)

local _OpB = _bldB("OPPOSING TEAM", UDim2.new(0,0,0,72), UDim2.new(1,0,0,30), function(b) 
    _S._OpM = not _S._OpM 
    b.BackgroundColor3 = _S._OpM and _S._V._s or _S._V._u
    _clrAll()
    if _S._OpM then for _,p in pairs(_g1:GetPlayers()) do if p ~= _p0 and p.Team ~= _p0.Team then _tgl(p, true) end end end
end)
_OpB.BackgroundColor3 = _S._V._u

local _AtB = _bldB("AUTO LOCK", UDim2.new(0,0,0,108), UDim2.new(1,0,0,30), function(b) _S._A = not _S._A b.BackgroundColor3 = _S._A and _S._V._s or _S._V._u end)
_AtB.BackgroundColor3 = _S._V._u

local _EsB = _bldB("ESP / CHAMS", UDim2.new(0,0,0,144), UDim2.new(1,0,0,30), function(b) _S._E = not _S._E b.BackgroundColor3 = _S._E and _S._V._s or _S._V._u end, function() _openCP(_S._C_Es, true) end)
_EsB.BackgroundColor3 = _S._V._u

local _TrB = _bldB("TRACERS", UDim2.new(0,0,0,180), UDim2.new(1,0,0,30), function(b) _S._Tr = not _S._Tr b.BackgroundColor3 = _S._Tr and _S._V._s or _S._V._u end, function() _openCP(_S._C_Tr, true) end)
_TrB.BackgroundColor3 = _S._V._u

local _FvB = _bldB("FOV CIRCLE", UDim2.new(0,0,0,216), UDim2.new(1,0,0,30), function(b) _S._Fv = not _S._Fv b.BackgroundColor3 = _S._Fv and _S._V._s or _S._V._u end, function() _openCP(_S._C_Fv, false) end)
_FvB.BackgroundColor3 = _S._V._u

local _WcB = _bldB("WALL CHECK", UDim2.new(0,0,0,252), UDim2.new(1,0,0,30), function(b) _S._W = not _S._W b.BackgroundColor3 = _S._W and _S._V._s or _S._V._u end)
_WcB.BackgroundColor3 = _S._V._u

local _SpB = _bldB("LOCK SPEED: 100%", UDim2.new(0,0,0,288), UDim2.new(1,0,0,30), function(b) _S._Sp = (_S._Sp <= 0.2) and 1 or _S._Sp - 0.2 b.Text = "LOCK SPEED: " .. math.floor(_S._Sp * 100) .. "%" end)

local _Inf = Instance.new("TextLabel", _M)
_Inf.Size = UDim2.new(1, -20, 0, 45)
_Inf.Position = UDim2.new(0, 10, 1, -50)
_Inf.BackgroundTransparency = 1
_Inf.Text = "SYSTEM READY"
_Inf.TextColor3 = Color3.new(0.7, 0.7, 0.7)
_Inf.Font = Enum.Font.Code
_Inf.TextSize = 10

_mB.MouseButton1Click:Connect(function()
    _S._op = not _S._op
    _mB.Text = _S._op and "-" or "+"
    _ts:Create(_M, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = _S._op and UDim2.new(0, 380, 0, 700) or UDim2.new(0, 380, 0, 50)}):Play()
end)

local function _getCol(cfg, p)
    if cfg.Mode == "Rainbow" then return Color3.fromHSV(tick() % 5 / 5, 1, 1) end
    if cfg.Mode == "Team" and p then return p.TeamColor.Color end
    return cfg.Color
end

local function _gnr()
    local n, d = nil, math.huge
    for p, v in pairs(_S._L) do
        if v and p ~= _p0 and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r and _vChk(p.Character) then
                local sP, onS = _c0:WorldToViewportPoint(r.Position)
                local dist = (Vector2.new(sP.X, sP.Y) - Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2)).Magnitude
                if (not _S._Fv or dist <= _S._Fr) and dist < d then d = dist n = p end
            end
        end
    end
    return n
end

_g4.RenderStepped:Connect(function()
    if _S._A then local n = _gnr() if n then _S._T = n end end
    if _S._T and (_S._T.Character == nil or (_S._T.Character:FindFirstChild("Humanoid") and _S._T.Character.Humanoid.Health <= 0) or not _vChk(_S._T.Character)) then
        _S._T = _S._A and _gnr() or nil
    end

    local iP = _g3:IsMouseButtonPressed(_S._K1)
    if iP and _S._T then
        local p = _S._T.Character:FindFirstChild(_S._P)
        if p then _c0.CFrame = _c0.CFrame:Lerp(CFrame.lookAt(_c0.CFrame.Position, p.Position), _S._Sp) end
    end

    _fO.Visible = _S._Fv
    _fO.Position = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2)
    _fO.Color = _getCol(_S._C_Fv)

    for _, p in pairs(_g1:GetPlayers()) do
        if p == _p0 then continue end
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local r = c.HumanoidRootPart
            local h = c:FindFirstChild("BPA_H") or Instance.new("Highlight", c)
            h.Name = "BPA_H"
            h.Enabled = _S._L[p] and _S._E
            h.OutlineColor = _getCol(_S._C_Es, p)
            h.FillTransparency = 1

            if not _tL[p] then _tL[p] = Drawing.new("Line") end
            local tr = _tL[p]
            local sP, onS = _c0:WorldToViewportPoint(r.Position)
            if onS and _S._L[p] and _S._Tr then
                tr.Visible = true
                tr.To = Vector2.new(sP.X, sP.Y)
                tr.From = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y)
                tr.Color = _getCol(_S._C_Tr, p)
            else tr.Visible = false end
        end
    end
end)

_rfsh()

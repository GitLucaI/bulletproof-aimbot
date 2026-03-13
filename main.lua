local _g1 = game:GetService("Players")
local _g2 = game:GetService("Teams")
local _g3 = game:GetService("UserInputService")
local _g4 = game:GetService("RunService")
local _ts = game:GetService("TweenService")
local _cg = game:GetService("CoreGui")
local _hs = game:GetService("HttpService")
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
    _drS = false,
    _isML = false,
    _ULM = false,
    _MLP = {0.8, 0, 0.5, 0},
    _C_Es = {Mode = "Rainbow", Color = Color3.new(1,1,1)},
    _C_Tr = {Mode = "Team", Color = Color3.new(1,1,1)},
    _C_Fv = {Mode = "Static", Color = Color3.new(1,1,1)},
    _V = {
        _m = Color3.fromRGB(15, 17, 20),
        _h = Color3.fromRGB(25, 27, 32),
        _s = Color3.fromRGB(0, 255, 150),
        _u = Color3.fromRGB(255, 70, 70),
        _ac = Color3.fromRGB(35, 38, 45),
        _gr = ColorSequence.new(Color3.fromRGB(0, 255, 150), Color3.fromRGB(0, 180, 255))
    }
}


local function _addS(obj)
    local s = Instance.new("UIStroke")
    s.Thickness = 1
    s.Color = Color3.new(0,0,0)
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    s.Parent = obj
end

local function _serC(c) return {c.R, c.G, c.B} end
local function _desC(t) return Color3.new(t[1], t[2], t[3]) end

local function _save()
    local d = {
        A = _S._A, E = _S._E, Tr = _S._Tr, Fv = _S._Fv, W = _S._W,
        Fr = _S._Fr, Sp = _S._Sp, P = _S._P, MLP = _S._MLP, OpM = _S._OpM,
        CE = {M = _S._C_Es.Mode, C = _serC(_S._C_Es.Color)},
        CT = {M = _S._C_Tr.Mode, C = _serC(_S._C_Tr.Color)},
        CF = {M = _S._C_Fv.Mode, C = _serC(_S._C_Fv.Color)}
    }
    writefile("BPA_V1_Cfg.json", _hs:JSONEncode(d))
end

local function _load()
    if isfile("BPA_V1_Cfg.json") then
        local s, d = pcall(function() return _hs:JSONDecode(readfile("BPA_V1_Cfg.json")) end)
        if s then
            _S._A = d.A; _S._E = d.E; _S._Tr = d.Tr; _S._Fv = d.Fv; _S._W = d.W
            _S._Fr = d.Fr; _S._Sp = d.Sp; _S._P = d.P; _S._MLP = d.MLP; _S._OpM = d.OpM or false
            _S._C_Es.Mode = d.CE.M; _S._C_Es.Color = _desC(d.CE.C)
            _S._C_Tr.Mode = d.CT.M; _S._C_Tr.Color = _desC(d.CT.C)
            _S._C_Fv.Mode = d.CF.M; _S._C_Fv.Color = _desC(d.CF.C)
        end
    end
end

pcall(_load)

local _G = Instance.new("ScreenGui")
_G.Name = "BulletproofAimbotServiceV1"
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
_M.Size = UDim2.new(0, 380, 0, 750)
_M.Position = UDim2.new(0.5, -190, 0.5, -375)
_M.BackgroundColor3 = _S._V._m
_M.BorderSizePixel = 0
_M.Active = true
_M.ClipsDescendants = true
_rnd(_M, 12)

local _mB_L = Instance.new("TextButton", _G)
_mB_L.Size = UDim2.new(0, 75, 0, 75)
_mB_L.Position = UDim2.new(_S._MLP[1], _S._MLP[2], _S._MLP[3], _S._MLP[4])
_mB_L.BackgroundColor3 = _S._V._h
_mB_L.Text = "LOCK"
_mB_L.TextColor3 = Color3.new(1,1,1)
_mB_L.Font = Enum.Font.Code
_mB_L.TextSize = 14
_mB_L.AutoButtonColor = false
_mB_L.Visible = _g3.TouchEnabled
_rnd(_mB_L, 40)
_addS(_mB_L)

local _drM = false
local _mOff = Vector2.new(0,0)
local _drML = false
local _mlOff = Vector2.new(0,0)

_M.InputBegan:Connect(function(i)
    if not _S._drS and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
        _drM = true
        local mP = _g3:GetMouseLocation()
        _mOff = Vector2.new(mP.X - _M.AbsolutePosition.X, mP.Y - _M.AbsolutePosition.Y)
    end
end)

_mB_L.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if _S._ULM then
            _drML = true
            local mP = _g3:GetMouseLocation()
            _mlOff = Vector2.new(mP.X - _mB_L.AbsolutePosition.X, mP.Y - _mB_L.AbsolutePosition.Y)
        else
            _S._isML = true
            _mB_L.BackgroundColor3 = _S._V._s
        end
    end
end)

_g3.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        _drM = false
        if _drML then
            _drML = false
            _S._MLP = {_mB_L.Position.X.Scale, _mB_L.Position.X.Offset, _mB_L.Position.Y.Scale, _mB_L.Position.Y.Offset}
            _save()
        end
        _S._isML = false
        _mB_L.BackgroundColor3 = _S._V._h
    end
end)

local _CP = Instance.new("Frame", _G)
_CP.Size = UDim2.new(0, 300, 0, 420)
_CP.Position = UDim2.new(0.5, 200, 0.5, -210)
_CP.BackgroundColor3 = _S._V._h
_CP.Visible = false
_CP.Active = true
_CP.ZIndex = 100
_rnd(_CP, 10)

local _CTl = Instance.new("TextLabel", _CP)
_CTl.Size = UDim2.new(1, 0, 0, 40)
_CTl.BackgroundTransparency = 1
_CTl.Text = "COLOR CONFIGURATOR"
_CTl.TextColor3 = Color3.new(1, 1, 1)
_CTl.Font = Enum.Font.Code
_CTl.TextSize = 14
_CTl.ZIndex = 101
_addS(_CTl)

local _CW = Instance.new("ImageLabel", _CP)
_CW.Size = UDim2.new(0, 150, 0, 150)
_CW.Position = UDim2.new(0.5, -75, 0, 50)
_CW.Image = "rbxassetid://2849323573"
_CW.BackgroundTransparency = 1
_CW.ZIndex = 101

local _R_In = Instance.new("TextBox", _CP)
_R_In.Size = UDim2.new(0, 60, 0, 30)
_R_In.Position = UDim2.new(0.1, 0, 0, 220)
_R_In.Text = "255"
_R_In.BackgroundColor3 = _S._V._ac
_R_In.TextColor3 = Color3.new(1,0,0)
_R_In.Font = Enum.Font.Code
_R_In.ClearTextOnFocus = false
_R_In.ZIndex = 101
_rnd(_R_In, 4)
_addS(_R_In)

local _G_In = _R_In:Clone()
_G_In.Parent = _CP
_G_In.Position = UDim2.new(0.4, 0, 0, 220)
_G_In.TextColor3 = Color3.new(0,1,0)

local _B_In = _R_In:Clone()
_B_In.Parent = _CP
_B_In.Position = UDim2.new(0.7, 0, 0, 220)
_B_In.TextColor3 = Color3.new(0,0,1)

local _cur_cfg = nil

local function _mBtn(txt, pos, col, cb)
    local b = Instance.new("TextButton", _CP)
    b.Size = UDim2.new(0.28, 0, 0, 30)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = col
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 10
    b.ZIndex = 101
    _rnd(b, 5)
    _addS(b)
    b.MouseButton1Click:Connect(cb)
    return b
end

_mBtn("RAINBOW", UDim2.new(0.04, 0, 0, 270), _S._V._ac, function() if _cur_cfg then _cur_cfg.Mode = "Rainbow" _save() end end)
_mBtn("STATIC", UDim2.new(0.36, 0, 0, 270), _S._V._ac, function() if _cur_cfg then _cur_cfg.Mode = "Static" _save() end end)
local _tBtn = _mBtn("TEAM", UDim2.new(0.68, 0, 0, 270), _S._V._ac, function() if _cur_cfg then _cur_cfg.Mode = "Team" _save() end end)

local _btn_Conf = _mBtn("CONFIRM", UDim2.new(0.04, 0, 0, 330), Color3.fromRGB(0, 150, 0), function()
    if _cur_cfg then
        local r, g, b = tonumber(_R_In.Text) or 255, tonumber(_G_In.Text) or 255, tonumber(_B_In.Text) or 255
        _cur_cfg.Color = Color3.fromRGB(r, g, b)
        _save()
    end
    _CP.Visible = false
end)
_btn_Conf.Size = UDim2.new(0.44, 0, 0, 40)

local _btn_Canc = _mBtn("CANCEL", UDim2.new(0.52, 0, 0, 330), Color3.fromRGB(150, 0, 0), function()
    _CP.Visible = false
end)
_btn_Canc.Size = UDim2.new(0.44, 0, 0, 40)

local _H = Instance.new("Frame", _M)
_H.Size = UDim2.new(1, 0, 0, 50)
_H.BackgroundColor3 = _S._V._h
_rnd(_H, 12)

local _Tl = Instance.new("TextLabel", _H)
_Tl.Size = UDim2.new(1, -100, 1, 0)
_Tl.Position = UDim2.new(0, 15, 0, 0)
_Tl.BackgroundTransparency = 1
_Tl.Text = "BULLETPROOF V1"
_Tl.TextColor3 = Color3.new(1, 1, 1)
_Tl.Font = Enum.Font.Code
_Tl.TextSize = 18
_Tl.TextXAlignment = Enum.TextXAlignment.Left
_addS(_Tl)

local _mB = Instance.new("TextButton", _H)
_mB.Size = UDim2.new(0, 35, 0, 35)
_mB.Position = UDim2.new(1, -45, 0.5, -17)
_mB.BackgroundColor3 = _S._V._ac
_mB.Text = "-"
_mB.TextColor3 = Color3.new(1, 1, 1)
_rnd(_mB, 8)
_addS(_mB)

local _Cn = Instance.new("Frame", _M)
_Cn.Size = UDim2.new(1, 0, 1, -50)
_Cn.Position = UDim2.new(0, 0, 0, 50)
_Cn.BackgroundTransparency = 1

local _Sf = Instance.new("ScrollingFrame", _Cn)
_Sf.Size = UDim2.new(1, -20, 0, 140)
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
    local c, rP = _p0.Character, p:FindFirstChild(_S._P)
    if not (c and rP) then return false end
    local mP = c:FindFirstChild("Head")
    if not mP then return false end
    local rPms = RaycastParams.new()
    rPms.FilterType = Enum.RaycastFilterType.Exclude
    rPms.FilterDescendantsInstances = {c, p.Parent}
    local r = workspace:Raycast(mP.Position, (rP.Position - mP.Position).Unit * (rP.Position - mP.Position).Magnitude, rPms)
    return not r
end

local function _tgl(p, v)
    if p == _p0 then return end
    _S._L[p] = (v ~= nil and v or not _S._L[p])
    local b = _Sf:FindFirstChild(p.Name)
    if b then b.BackgroundColor3 = _S._L[p] and _S._V._s or _S._V._u end
end

local function _clrAll()
    for _,p in pairs(_g1:GetPlayers()) do _S._L[p] = false end
end

local function _updOpponents()
    for _, p in pairs(_g1:GetPlayers()) do
        if p ~= _p0 and p.Team ~= _p0.Team then _S._L[p] = true end
    end
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
        _addS(b)
        local plrs = t:GetPlayers()
        local active = #plrs > 0
        for _,p in pairs(plrs) do if not _S._L[p] then active = false break end end
        b.BackgroundColor3 = active and _S._V._s or _S._V._u
        b.MouseButton1Click:Connect(function()
            local current = t:GetPlayers()
            if #current > 0 then
                local s = not _S._L[current[1]]
                for _, p in pairs(current) do _tgl(p, s) end
                _rfsh()
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
            _addS(b)
            b.MouseButton1Click:Connect(function() _tgl(p) _rfsh() end)
        end
    end
end

local _Ct = Instance.new("Frame", _Cn)
_Ct.Size = UDim2.new(1, -20, 0, 500)
_Ct.Position = UDim2.new(0, 10, 0, 160)
_Ct.BackgroundTransparency = 1

local _BPB = {}
local function _updBP()
    for n, b in pairs(_BPB) do
        b.BackgroundColor3 = (_S._P == n) and _S._V._s or _S._V._u
    end
end

local function _bldB(txt, pos, sz, cb, cfg, hasT, startS)
    local b = Instance.new("TextButton", _Ct)
    b.Size = sz or UDim2.new(0.31, 0, 0, 30)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = startS and _S._V._s or _S._V._u
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Code
    b.TextSize = 10
    _rnd(b, 6)
    _addS(b)
    b.MouseButton1Click:Connect(function() cb(b) _rfsh() _save() end)
    if cfg then
        local eb = Instance.new("TextButton", b)
        eb.Size = UDim2.new(0, 24, 0, 24)
        eb.Position = UDim2.new(1, -28, 0.5, -12)
        eb.BackgroundColor3 = Color3.fromRGB(60, 65, 75)
        eb.Text = "E"
        eb.TextColor3 = Color3.new(1, 1, 1)
        _rnd(eb, 4)
        _addS(eb)
        eb.MouseButton1Click:Connect(function()
            _cur_cfg = cfg
            _tBtn.Visible = hasT
            _R_In.Text = math.floor(cfg.Color.R * 255)
            _G_In.Text = math.floor(cfg.Color.G * 255)
            _B_In.Text = math.floor(cfg.Color.B * 255)
            _CP.Visible = true
        end)
    end
    return b
end

local function _bldS(txt, pos, min, max, start, cb)
    local c = Instance.new("Frame", _Ct)
    c.Size = UDim2.new(1, 0, 0, 45)
    c.Position = pos
    c.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", c)
    l.Size = UDim2.new(1, 0, 0, 20); l.Text = txt .. ": " .. math.floor(start); l.TextColor3 = Color3.new(1,1,1); l.Font = Enum.Font.Code; l.TextSize = 11; l.BackgroundTransparency = 1; l.TextXAlignment = Enum.TextXAlignment.Left
    _addS(l)
    local b = Instance.new("Frame", c); b.Size = UDim2.new(1, 0, 0, 8); b.Position = UDim2.new(0, 0, 0, 25); b.BackgroundColor3 = Color3.fromRGB(30, 32, 38); _rnd(b, 4)
    local f = Instance.new("Frame", b); f.Size = UDim2.new((start - min)/(max - min), 0, 1, 0); f.BackgroundColor3 = Color3.new(1,1,1); _rnd(f, 4)
    local g = Instance.new("UIGradient", f); g.Color = _S._V._gr
    local active = false
    local function upd()
        local mX = _g3:GetMouseLocation().X
        local p = math.clamp((mX - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
        f.Size = UDim2.new(p, 0, 1, 0)
        local v = min + (p * (max - min))
        l.Text = txt .. ": " .. math.floor(v)
        cb(v)
    end
    b.InputBegan:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            active = true; _S._drS = true; upd() 
        end 
    end)
    _g3.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then if active then _save() end active = false; _S._drS = false end end)
    _g4.RenderStepped:Connect(function() if active then upd() end end)
end

_BPB["Head"] = _bldB("HEAD", UDim2.new(0,0,0,0), nil, function() _S._P = "Head" _updBP() end, nil, false, _S._P == "Head")
_BPB["UpperTorso"] = _bldB("TORSO", UDim2.new(0.34,0,0,0), nil, function() _S._P = "UpperTorso" _updBP() end, nil, false, _S._P == "UpperTorso")
_BPB["LeftLowerLeg"] = _bldB("LEGS", UDim2.new(0.68,0,0,0), nil, function() _S._P = "LeftLowerLeg" _updBP() end, nil, false, _S._P == "LeftLowerLeg")

_bldB("SELECT ALL", UDim2.new(0,0,0,36), UDim2.new(0.48,0,0,30), function() for _,p in pairs(_g1:GetPlayers()) do _tgl(p, true) end _rfsh() end)
_bldB("DESELECT ALL", UDim2.new(0.52,0,0,36), UDim2.new(0.48,0,0,30), function() _clrAll() _rfsh() end)
_bldB("OPPOSING TEAM", UDim2.new(0,0,0,72), UDim2.new(1,0,0,30), function() _updOpponents() _rfsh() end)

_bldB("AUTO LOCK", UDim2.new(0,0,0,108), UDim2.new(1,0,0,30), function(b) _S._A = not _S._A; b.BackgroundColor3 = _S._A and _S._V._s or _S._V._u end, nil, false, _S._A)
_bldB("ESP / CHAMS", UDim2.new(0,0,0,144), UDim2.new(1,0,0,30), function(b) _S._E = not _S._E; b.BackgroundColor3 = _S._E and _S._V._s or _S._V._u end, _S._C_Es, true, _S._E)
_bldB("TRACERS", UDim2.new(0,0,0,180), UDim2.new(1,0,0,30), function(b) _S._Tr = not _S._Tr; b.BackgroundColor3 = _S._Tr and _S._V._s or _S._V._u end, _S._C_Tr, true, _S._Tr)
_bldB("FOV CIRCLE", UDim2.new(0,0,0,216), UDim2.new(1,0,0,30), function(b) _S._Fv = not _S._Fv; b.BackgroundColor3 = _S._Fv and _S._V._s or _S._V._u end, _S._C_Fv, false, _S._Fv)
_bldB("WALL CHECK", UDim2.new(0,0,0,252), UDim2.new(1,0,0,30), function(b) _S._W = not _S._W; b.BackgroundColor3 = _S._W and _S._V._s or _S._V._u end, nil, false, _S._W)
_bldB("UNLOCK POSITION SETTING", UDim2.new(0,0,0,288), UDim2.new(1,0,0,30), function(b) _S._ULM = not _S._ULM; b.BackgroundColor3 = _S._ULM and _S._V._s or _S._V._u end, nil, false, _S._ULM)

_bldS("GAME FOV", UDim2.new(0,0,0,335), 30, 120, _c0.FieldOfView, function(v) _c0.FieldOfView = v end)
_bldS("LOCK SPEED", UDim2.new(0,0,0,385), 0, 100, _S._Sp*100, function(v) _S._Sp = v/100 end)
_bldS("FOV RADIUS", UDim2.new(0,0,0,435), 10, 800, _S._Fr, function(v) _S._Fr = v end)

local function _getCol(cfg, p)
    if cfg.Mode == "Rainbow" then return Color3.fromHSV(tick() % 5 / 5, 1, 1) end
    if cfg.Mode == "Team" and p then return p.TeamColor.Color end
    return cfg.Color
end

local function _gnr()
    local n, d = nil, math.huge
    for p, v in pairs(_S._L) do
        if v and p ~= _p0 and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local r = p.Character:FindFirstChild(_S._P)
            if r and _vChk(p.Character) then
                local sP, onS = _c0:WorldToViewportPoint(r.Position)
                local dist = (Vector2.new(sP.X, sP.Y) - Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2)).Magnitude
                if (not _S._Fv or dist <= _S._Fr) and dist < d then d = dist; n = p end
            end
        end
    end
    return n
end

_g4.RenderStepped:Connect(function()
    if _drM then
        local mP = _g3:GetMouseLocation()
        _M.Position = UDim2.new(0, mP.X - _mOff.X, 0, mP.Y - _mOff.Y)
    end
    if _drML then
        local mP = _g3:GetMouseLocation()
        _mB_L.Position = UDim2.new(0, mP.X - _mlOff.X, 0, mP.Y - _mlOff.Y)
    end
    if _S._A then local n = _gnr(); if n then _S._T = n end end
    if _S._T and (_S._T.Character == nil or (_S._T.Character:FindFirstChild("Humanoid") and _S._T.Character.Humanoid.Health <= 0)) then _S._T = nil end
    if (_g3:IsMouseButtonPressed(_S._K1) or _S._isML) and _S._T and _S._T.Character then
        local p = _S._T.Character:FindFirstChild(_S._P)
        if p then _c0.CFrame = _c0.CFrame:Lerp(CFrame.lookAt(_c0.CFrame.Position, p.Position), _S._Sp) end
    end
    _fO.Visible = _S._Fv; _fO.Radius = _S._Fr; _fO.Position = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y/2); _fO.Color = _getCol(_S._C_Fv)
    for _, p in pairs(_g1:GetPlayers()) do
        if p == _p0 then continue end
        local c = p.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local h = c:FindFirstChild("BPA_H") or Instance.new("Highlight", c); h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Name = "BPA_H"; h.Enabled = _S._L[p] and _S._E; h.OutlineColor = _getCol(_S._C_Es, p); h.FillTransparency = 1
            if not _tL[p] then _tL[p] = Drawing.new("Line") end
            local tr = _tL[p]; local sP, onS = _c0:WorldToViewportPoint(c.HumanoidRootPart.Position)
            if onS and _S._L[p] and _S._Tr then tr.Visible = true; tr.To = Vector2.new(sP.X, sP.Y); tr.From = Vector2.new(_c0.ViewportSize.X/2, _c0.ViewportSize.Y); tr.Color = _getCol(_S._C_Tr, p); tr.Thickness = 1.5 else tr.Visible = false end
        elseif _tL[p] then _tL[p].Visible = false end
    end
end)

_p0:GetPropertyChangedSignal("Team"):Connect(function() _rfsh() end)
_g1.PlayerAdded:Connect(_rfsh)
_g1.PlayerRemoving:Connect(function(p) if _tL[p] then _tL[p]:Remove() _tL[p] = nil end _S._L[p] = nil _rfsh() end)

_mB.MouseButton1Click:Connect(function()
    _S._op = not _S._op; _mB.Text = _S._op and "-" or "+"
    _ts:Create(_M, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = _S._op and UDim2.new(0, 380, 0, 750) or UDim2.new(0, 380, 0, 50)}):Play()
end)

_rfsh()
_updBP()

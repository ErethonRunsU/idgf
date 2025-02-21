-- fixed and edited by @fwedsw 
-- im not sure who to credit sorry 

local inputService   = game:GetService("UserInputService")
local runService     = game:GetService("RunService")
local tweenService   = game:GetService("TweenService")
local players        = game:GetService("Players")
local localPlayer    = players.LocalPlayer
local mouse          = localPlayer:GetMouse()

local menu           = game:GetObjects("rbxassetid://139055293683137")[1]
menu.bg.Position     = UDim2.new(0.5,-menu.bg.Size.X.Offset/2,0.5,-menu.bg.Size.Y.Offset/2)
menu.Parent          = game:GetService("CoreGui")
local library = {colorpicking = false;tabbuttons = {};tabs = {};options = {};flags = {};scrolling = true;playing = false;multiZindex = 200;toInvis = {};libColor = Color3.fromRGB(255, 60, 40);disabledcolor = Color3.fromRGB(233, 0, 0);blacklisted = {Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.UserInputType.MouseMovement,Enum.UserInputType.MouseButton1}}

function draggable(a)
	local b = inputService;
	local c;
	local d;
	local e;
	local f;
	local TweenService = game:GetService("TweenService")

	local function g(h)
		if not library.colorpicking then
			local i = h.Position - e;
			local targetPosition = UDim2.new(f.X.Scale, f.X.Offset + i.X, f.Y.Scale, f.Y.Offset + i.Y)
			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local tween = TweenService:Create(a, tweenInfo, {Position = targetPosition})
			tween:Play()
		end
	end

	a.InputBegan:Connect(function(h)
		if h.UserInputType == Enum.UserInputType.MouseButton1 or h.UserInputType == Enum.UserInputType.Touch then
			c = true; 
			e = h.Position;
			f = a.Position;
			h.Changed:Connect(function()
				if h.UserInputState == Enum.UserInputState.End then 
					c = false 
				end 
			end)
		end
	end)

	a.InputChanged:Connect(function(h)
		if h.UserInputType == Enum.UserInputType.MouseMovement or h.UserInputType == Enum.UserInputType.Touch then 
			d = h 
		end 
	end)

	b.InputChanged:Connect(function(h)
		if h == d and c then 
			g(h)
		end 
	end)
end

draggable(menu.bg)


local tabholder = menu.bg.bg.bg.bg.main.group
local tabviewer = menu.bg.bg.bg.bg.tabbuttons

local keyNames = {
	[Enum.KeyCode.LeftAlt] = 'LALT';
	[Enum.KeyCode.RightAlt] = 'RALT';
	[Enum.KeyCode.LeftControl] = 'LCTRL';
	[Enum.KeyCode.RightControl] = 'RCTRL';
	[Enum.KeyCode.LeftShift] = 'LSHIFT';
	[Enum.KeyCode.RightShift] = 'RSHIFT';
	[Enum.KeyCode.Underscore] = '_';
	[Enum.KeyCode.Minus] = '-';
	[Enum.KeyCode.Plus] = '+';
	[Enum.KeyCode.Period] = '.';
	[Enum.KeyCode.Slash] = '/';
	[Enum.KeyCode.BackSlash] = '\\';
	[Enum.KeyCode.Question] = '?';
	[Enum.UserInputType.MouseButton1] = 'MB1';
	[Enum.UserInputType.MouseButton2] = 'MB2';
	[Enum.UserInputType.MouseButton3] = 'MB3';
}

function library:Tween(...)
	tweenService:Create(...):Play()
end
local playing

function LoadUi(Name, Key, Color)
	menu.bg.pre.Text = Name or 'nil'
	
	menu.bg.ImageLabel1.ImageColor3 = Color
	menu.bg.ImageLabel2.ImageColor3 = Color
	menu.bg.ImageLabel3.ImageColor3 = Color
	menu.bg.ImageLabel4.ImageColor3 = Color
	menu.bg.ImageLabel5.ImageColor3 = Color
	menu.bg.ImageLabel6.ImageColor3 = Color
	menu.bg.ImageLabel7.ImageColor3 = Color
	
	menu.bg.bg.bg.bg.element.BackgroundColor3 = Color
	
	inputService.InputEnded:Connect(function(key)
		if key.KeyCode == Enum.KeyCode[Key] then
			menu.Enabled = not menu.Enabled
			library.scrolling = false
			library.colorpicking = false
			for i,v in next, library.toInvis do
				v.Visible = false
			end
		end
	end)
	
	library.libColor = Color
	
	function library:addTab(name)
		local newTab = tabholder.tab:Clone()
		local newButton = tabviewer.button:Clone()

		table.insert(library.tabs,newTab)
		newTab.Parent = tabholder
		newTab.Visible = false

		table.insert(library.tabbuttons,newButton)
		newButton.Parent = tabviewer
		newButton.Modal = true
		newButton.Visible = true
		newButton.text.Text = name
		newButton.text.TextSize = 12
		newButton.text.Position = UDim2.new(0, 0, 0, -1)
		newButton.MouseButton1Click:Connect(function()
			for i,v in next, library.tabs do
				v.Visible = v == newTab
			end
			for i,v in next, library.toInvis do
				v.Visible = false
			end
			for i,v in next, library.tabbuttons do
				local state = v == newButton
				v.element.Position = UDim2.new(0, 42, 0, 18)
				v.element.Size = UDim2.new(0, 0, 0, 1)
				if state then
					v.element.Visible = true
					v.element.BackgroundColor3 = Color
					library:Tween(v.element, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.000, Size = UDim2.new(0, 60, 0, 1)})
					v.text.TextColor3 = Color3.fromRGB(244, 244, 244)
				else
					library:Tween(v.element, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1.000, Size = UDim2.new(0, 0, 0, 0)})
					v.text.TextColor3 = Color3.fromRGB(144, 144, 144)
				end
			end
		end)

		local tab = {}
		local groupCount = 0
		local jigCount = 0
		local topStuff = 2000

		function tab:createGroup(pos,groupname)
			local groupbox = Instance.new("Frame")
			local grouper = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			local element = Instance.new("Frame")
			local title = Instance.new("TextLabel")
			local backframe = Instance.new("Frame")

			groupCount -= 1

			groupbox.Parent = newTab[pos]
			groupbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			groupbox.BorderColor3 = Color3.fromRGB(30, 30, 30)
			groupbox.BorderSizePixel = 2
			groupbox.Size = UDim2.new(0, 300, 0, 8)
			groupbox.ZIndex = groupCount

			grouper.Parent = groupbox
			grouper.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			grouper.BorderColor3 = Color3.fromRGB(0, 0, 0)
			grouper.Size = UDim2.new(1, 0, 1, 0)

			UIListLayout.Parent = grouper
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			UIPadding.Parent = grouper
			UIPadding.PaddingBottom = UDim.new(0, 4)
			UIPadding.PaddingTop = UDim.new(0, 7)

			element.Name = "element"
			element.Parent = groupbox
			element.BackgroundColor3 = library.libColor
			element.BorderSizePixel = 0
			element.Size = UDim2.new(1, 0, 0, 1)

			title.Parent = groupbox
			title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			title.BackgroundTransparency = 1.000
			title.BorderSizePixel = 0
			title.Position = UDim2.new(0, 17, 0, 0)
			title.ZIndex = 2
			title.Font = Enum.Font.Code
			title.Text = groupname or ""
			title.TextColor3 = Color3.fromRGB(255, 255, 255)
			title.TextSize = 13.000
			title.TextStrokeTransparency = 0.000
			title.TextXAlignment = Enum.TextXAlignment.Left

			backframe.Parent = groupbox
			backframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			backframe.BorderSizePixel = 0
			backframe.Position = UDim2.new(0, 10, 0, -2)
			backframe.Size = UDim2.new(0, 13 + title.TextBounds.X, 0, 3)

			local group = {}
			function group:addToggle(args)
    if not args.flag and args.text then args.flag = args.text end
    if not args.flag then return warn('') end
    groupbox.Size += UDim2.new(0, 0, 0, 20)

    local toggleframe = Instance.new("Frame")
    local tobble = Instance.new("Frame")
    local mid = Instance.new("Frame")
    local front = Instance.new("Frame")
    local text = Instance.new("TextLabel")
    local button = Instance.new("TextButton")

    jigCount -= 1
    library.multiZindex -= 1

    toggleframe.Name = "toggleframe"
    toggleframe.Parent = grouper
    toggleframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleframe.BackgroundTransparency = 1.000
    toggleframe.BorderSizePixel = 0
    toggleframe.Size = UDim2.new(1, 0, 0, 20)
    toggleframe.ZIndex = library.multiZindex

    tobble.Name = "tobble"
    tobble.Parent = toggleframe
    tobble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tobble.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tobble.BorderSizePixel = 3
    tobble.Position = UDim2.new(0.0299999993, 0, 0.272000015, 0)
    tobble.Size = UDim2.new(0, 10, 0, 10)

    mid.Name = "mid"
    mid.Parent = tobble
    mid.BackgroundColor3 = Color
    mid.BorderColor3 = Color3.fromRGB(30,30,30)
    mid.BorderSizePixel = 2
    mid.Size = UDim2.new(0, 10, 0, 10)

    front.Name = "front"
    front.Parent = mid
    front.BackgroundColor3 = Color3.fromRGB(15,15,15)
    front.BorderColor3 = Color3.fromRGB(0, 0, 0)
    front.Size = UDim2.new(0, 10, 0, 10)

    text.Name = "text"
    text.Parent = toggleframe
    text.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    text.BackgroundTransparency = 1.000
    text.Position = UDim2.new(0, 28, 0, 0)
    text.Size = UDim2.new(0, 0, 1, 2)
    text.Font = Enum.Font.Code
    text.Text = args.text or args.flag
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextSize = 13.000
    text.TextStrokeTransparency = 1.000
    text.TextXAlignment = Enum.TextXAlignment.Left

    button.Name = "button"
    button.Parent = toggleframe
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 1.000
    button.BorderSizePixel = 0
    button.Size = UDim2.new(0, 101, 1, 0)
    button.Font = Enum.Font.SourceSans
    button.Text = ""
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.TextSize = 14.000

    if args.disabled then
        button.Visible = false
        text.TextColor3 = library.disabledcolor
        text.Text = args.text
        return
    end

    local state = args.state or false
    function toggle(newState)
        state = newState
        library.flags[args.flag] = state
        front.BackgroundColor3 = state and library.libColor or Color3.fromRGB(15,15,15)
        text.TextColor3 = state and Color3.fromRGB(244, 244, 244) or Color3.fromRGB(255, 255, 255)
        if args.callback then
            args.callback(state)
        end
    end

    button.MouseButton1Click:Connect(function()
        state = not state
        if state then 
            library:Tween(front, TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = library.libColor})
        else 
            front.BackgroundColor3 = Color3.fromRGB(15,15,15)
        end
        front.Name = state and "accent" or "back"
        library.flags[args.flag] = state
        mid.BorderColor3 = Color3.fromRGB(30,30,30)
        text.TextColor3 = state and Color3.fromRGB(244, 244, 244) or Color3.fromRGB(255, 255, 255)
        if args.callback then
            args.callback(state)
        end
    end)

    button.MouseEnter:Connect(function()
        mid.BorderColor3 = library.libColor
    end)
    button.MouseLeave:Connect(function()
        mid.BorderColor3 = Color3.fromRGB(30,30,30)
    end)

    library.flags[args.flag] = state
    library.options[args.flag] = {type = "toggle", changeState = toggle, skipflag = args.skipflag, oldargs = args}
    local toggle = {}
				function toggle:addKeybind(args)
					if not args.flag then return warn('') end
					local next = false

					local keybind = Instance.new("Frame")
					local button = Instance.new("TextButton")

					keybind.Parent = toggleframe
					keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					keybind.BackgroundTransparency = 1.000
					keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
					keybind.BorderSizePixel = 0
					keybind.Position = UDim2.new(0.720000029, 4, 0.272000015, 0)
					keybind.Size = UDim2.new(0, 51, 0, 10)

					button.Parent = keybind
					button.BackgroundColor3 = Color3.fromRGB(187, 131, 255)
					button.BackgroundTransparency = 1.000
					button.BorderSizePixel = 0
					button.Position = UDim2.new(-0.270902753, 13, 0, 0)
					button.Size = UDim2.new(1.27090275, 0, 1, 0)
					button.Font = Enum.Font.Code
					button.Text = ""
					button.TextColor3 = Color3.fromRGB(255, 255, 255)
					button.TextSize = 13.000
					button.TextStrokeTransparency = 0.000
					button.TextXAlignment = Enum.TextXAlignment.Right

					function updateValue(val)
						if library.colorpicking then return end
						library.flags[args.flag] = val
						button.Text = keyNames[val] or val.Name
					end
					inputService.InputBegan:Connect(function(key)
						local key = key.KeyCode == Enum.KeyCode.Unknown and key.UserInputType or key.KeyCode
						if next then
							if not table.find(library.blacklisted,key) then
								next = false
								library.flags[args.flag] = key
								button.Text = keyNames[key] or key.Name
								button.TextColor3 = Color3.fromRGB(255, 255, 255)
							else 
								button.Text = 'nil'
								button.TextColor3 = Color3.fromRGB(255, 255, 255)
							end
						end
						if not next and key == library.flags[args.flag] and args.callback then
							args.callback()
						end
					end)

					button.MouseButton1Click:Connect(function()
						if library.colorpicking then return end
						library.flags[args.flag] = Enum.KeyCode.Unknown
						button.Text = "=_="
						button.TextColor3 = Color3.fromRGB(255, 255, 255)
						next = true
					end)

					library.flags[args.flag] = Enum.KeyCode.Unknown
					library.options[args.flag] = {type = "keybind",changeState = updateValue,skipflag = args.skipflag,oldargs = args}

					updateValue(args.key or Enum.KeyCode.Unknown)
				end
				function toggle:addColorpicker(args)
					if not args.flag and args.text then args.flag = args.text end
					if not args.flag then return warn('') end
					local colorpicker = Instance.new("Frame")
					local mid = Instance.new("Frame")
					local front = Instance.new("Frame")
					local button2 = Instance.new("TextButton")
					local colorFrame = Instance.new("Frame")
					local colorFrame_2 = Instance.new("Frame")
					local hueframe = Instance.new("Frame")
					local main = Instance.new("Frame")
					local hue = Instance.new("ImageLabel")
					local pickerframe = Instance.new("Frame")
					local main_2 = Instance.new("Frame")
					local picker = Instance.new("ImageLabel")
					local clr = Instance.new("Frame")
					local copy = Instance.new("TextButton")

					library.multiZindex -= 1
					jigCount -= 1
					topStuff -= 1 --args.second

					colorpicker.Parent = toggleframe
					colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
					colorpicker.BorderSizePixel = 3
					colorpicker.Position = args.second and UDim2.new(0.720000029, 4, 0.272000015, 0) or UDim2.new(0.860000014, 4, 0.272000015, 0)
					colorpicker.Size = UDim2.new(0, 20, 0, 10)

					mid.Name = "mid"
					mid.Parent = colorpicker
					mid.BackgroundColor3 = Color
					mid.BorderColor3 = Color3.fromRGB(30,30,30)
					mid.BorderSizePixel = 2
					mid.Size = UDim2.new(1, 0, 1, 0)

					front.Name = "front"
					front.Parent = mid
					front.BackgroundColor3 = Color3.fromRGB(240, 142, 214)
					front.BorderColor3 = Color3.fromRGB(0, 0, 0)
					front.Size = UDim2.new(1, 0, 1, 0)

					button2.Name = "button2"
					button2.Parent = front
					button2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					button2.BackgroundTransparency = 1.000
					button2.Size = UDim2.new(1, 0, 1, 0)
					button2.Text = ""
					button2.Font = Enum.Font.SourceSans
					button2.TextColor3 = Color3.fromRGB(0, 0, 0)
					button2.TextSize = 14.000

					colorFrame.Name = "colorFrame"
					colorFrame.Parent = toggleframe
					colorFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					colorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					colorFrame.BorderSizePixel = 2
					colorFrame.Position = UDim2.new(0.101092957, 0, 0.75, 0)
					colorFrame.Size = UDim2.new(0, 137, 0, 128)

					colorFrame_2.Name = "colorFrame"
					colorFrame_2.Parent = colorFrame
					colorFrame_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					colorFrame_2.BorderColor3 = Color3.fromRGB(60, 60, 60)
					colorFrame_2.Size = UDim2.new(1, 0, 1, 0)

					hueframe.Name = "hueframe"
					hueframe.Parent = colorFrame_2
					hueframe.Parent = colorFrame_2
					hueframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					hueframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
					hueframe.BorderSizePixel = 2
					hueframe.Position = UDim2.new(-0.0930000022, 18, -0.0599999987, 30)
					hueframe.Size = UDim2.new(0, 100, 0, 100)

					main.Name = "main"
					main.Parent = hueframe
					main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
					main.BorderColor3 = Color3.fromRGB(0, 0, 0)
					main.Size = UDim2.new(0, 100, 0, 100)
					main.ZIndex = 6

					picker.Name = "picker"
					picker.Parent = main
					picker.BackgroundColor3 = Color3.fromRGB(232, 0, 255)
					picker.BorderColor3 = Color3.fromRGB(0, 0, 0)
					picker.BorderSizePixel = 0
					picker.Size = UDim2.new(0, 100, 0, 100)
					picker.ZIndex = 104
					picker.Image = "rbxassetid://2615689005"

					pickerframe.Name = "pickerframe"
					pickerframe.Parent = colorFrame
					pickerframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
					pickerframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
					pickerframe.BorderSizePixel = 2
					pickerframe.Position = UDim2.new(0.711000025, 14, -0.0599999987, 30)
					pickerframe.Size = UDim2.new(0, 20, 0, 100)

					main_2.Name = "main"
					main_2.Parent = pickerframe
					main_2.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
					main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					main_2.Size = UDim2.new(0, 20, 0, 100)
					main_2.ZIndex = 6

					hue.Name = "hue"
					hue.Parent = main_2
					hue.BackgroundColor3 = Color3.fromRGB(255, 0, 178)
					hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
					hue.BorderSizePixel = 0
					hue.Size = UDim2.new(0, 20, 0, 100)
					hue.ZIndex = 104
					hue.Image = "rbxassetid://2615692420"

					clr.Name = "clr"
					clr.Parent = colorFrame
					clr.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					clr.BackgroundTransparency = 1.000
					clr.BorderColor3 = Color3.fromRGB(60, 60, 60)
					clr.BorderSizePixel = 2
					clr.Position = UDim2.new(0.0280000009, 0, 0, 2)
					clr.Size = UDim2.new(0, 129, 0, 14)
					clr.ZIndex = 5

					copy.Name = "copy"
					copy.Parent = clr
					copy.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
					copy.BackgroundTransparency = 1.000
					copy.BorderSizePixel = 0
					copy.Size = UDim2.new(0, 129, 0, 14)
					copy.ZIndex = 5
					copy.Font = Enum.Font.SourceSans
					copy.Text = args.text or args.flag
					copy.TextColor3 = Color3.fromRGB(100, 100, 100)
					copy.TextSize = 14.000
					copy.TextStrokeTransparency = 0.000

					copy.MouseButton1Click:Connect(function() -- "  "..args.text or "  "..args.flag
						colorFrame.Visible = false
					end)

					button2.MouseButton1Click:Connect(function()
						colorFrame.Visible = not colorFrame.Visible
						mid.BorderColor3 = Color3.fromRGB(30,30,30)
					end)

					button2.MouseEnter:connect(function()
						mid.BorderColor3 = library.libColor
					end)
					button2.MouseLeave:connect(function()
						mid.BorderColor3 = Color3.fromRGB(30,30,30)
					end)

					local function updateValue(value,fakevalue)
						if typeof(value) == "table" then value = fakevalue end
						library.flags[args.flag] = value
						front.BackgroundColor3 = value
						if args.callback then
							args.callback(value)
						end
					end

					local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
					local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
					local heartbeat = game:GetService("RunService").Heartbeat

					local pickerX,pickerY,hueY = 0,0,0
					local oldpercentX,oldpercentY = 0,0

					hue.MouseEnter:Connect(function()
						local input = hue.InputBegan:connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
									library.colorpicking = true
									local percent = (hueY-hue.AbsolutePosition.Y-36)/hue.AbsoluteSize.Y
									local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
									local startC = colors[math.floor(num)]
									local endC = colors[math.ceil(num)]
									local color = white:lerp(picker.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
									picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
									updateValue(color)
								end
								library.colorpicking = false
							end
						end)
						local leave
						leave = hue.MouseLeave:connect(function()
							input:disconnect()
							leave:disconnect()
						end)
					end)

					picker.MouseEnter:Connect(function()
						local input = picker.InputBegan:connect(function(key)
							if key.UserInputType == Enum.UserInputType.MouseButton1 then
								while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
									library.colorpicking = true
									local xPercent = (pickerX-picker.AbsolutePosition.X)/picker.AbsoluteSize.X
									local yPercent = (pickerY-picker.AbsolutePosition.Y-36)/picker.AbsoluteSize.Y
									local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
									updateValue(color)
									oldpercentX,oldpercentY = xPercent,yPercent
								end
								library.colorpicking = false
							end
						end)
						local leave
						leave = picker.MouseLeave:connect(function()
							input:disconnect()
							leave:disconnect()
						end)
					end)

					hue.MouseMoved:connect(function(_, y)
						hueY = y
					end)

					picker.MouseMoved:connect(function(x, y)
						pickerX,pickerY = x,y
					end)

					table.insert(library.toInvis,colorFrame)
					library.flags[args.flag] = Color3.new(1,1,1)
					library.options[args.flag] = {type = "colorpicker",changeState = updateValue,skipflag = args.skipflag,oldargs = args}

					updateValue(args.color or Color3.new(1,1,1))
				end
				return toggle
			end
			function group:addButton(args)
				if not args.callback or not args.text then return warn('') end
				groupbox.Size += UDim2.new(0, 0, 0, 22)

				local buttonframe = Instance.new("Frame")
				local bg = Instance.new("Frame")
				local main = Instance.new("Frame")
				local button = Instance.new("TextButton")
				local gradient = Instance.new("UIGradient")

				buttonframe.Name = "buttonframe"
				buttonframe.Parent = grouper
				buttonframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				buttonframe.BackgroundTransparency = 1.000
				buttonframe.BorderSizePixel = 0
				buttonframe.Size = UDim2.new(1, 0, 0, 21)

				bg.Name = "bg"
				bg.Parent = buttonframe
				bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 2
				bg.Position = UDim2.new(0.02, -1, 0, 0)
				bg.Size = UDim2.new(0, 205, 0, 15)

				main.Name = "main"
				main.Parent = bg
				main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				main.BorderColor3 = Color3.fromRGB(60, 60, 60)
				main.Size = UDim2.new(1, 0, 1, 0)

				button.Name = "button"
				button.Parent = main
				button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				button.BackgroundTransparency = 1.000
				button.BorderSizePixel = 0
				button.Size = UDim2.new(1, 0, 1, 0)
				button.Font = Enum.Font.Code
				button.Text = args.text or args.flag
				button.TextColor3 = Color3.fromRGB(255, 255, 255)
				button.TextSize = 13.000
				button.TextStrokeTransparency = 0.000

				gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
				gradient.Rotation = 90
				gradient.Name = "gradient"
				gradient.Parent = main

				button.MouseButton1Click:Connect(function()
					if not library.colorpicking then
						args.callback()
					end
				end)
				button.MouseEnter:connect(function()
					main.BorderColor3 = library.libColor
				end)
				button.MouseLeave:connect(function()
					main.BorderColor3 = Color3.fromRGB(60, 60, 60)
				end)
			end
			function group:addSlider(args, sub)
				if not args.flag or not args.max then
					warn("Missing required parameters (flag or max)")
					return
				end

				groupbox.Size = groupbox.Size + UDim2.new(0, 0, 0, 30)

				local slider = Instance.new("Frame")
				slider.Name = "slider"
				slider.Parent = grouper
				slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				slider.BackgroundTransparency = 1
				slider.BorderSizePixel = 0
				slider.Size = UDim2.new(1, 0, 0, 30)

				local bg = Instance.new("Frame")
				bg.Name = "bg"
				bg.Parent = slider
				bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 2
				bg.Position = UDim2.new(0.02, -1, 0, 16)
				bg.Size = UDim2.new(0, 278, 0, 8)

				local main = Instance.new("Frame")
				main.Name = "main"
				main.Parent = bg
				main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				main.BorderColor3 = Color3.fromRGB(50, 50, 50)
				main.Size = UDim2.new(1, 0, 1, 0)

				local fill = Instance.new("Frame")
				fill.Name = "fill"
				fill.Parent = main
				fill.BackgroundColor3 = library.libColor
				fill.BackgroundTransparency = 0.2
				fill.BorderColor3 = Color3.fromRGB(60, 60, 60)
				fill.BorderSizePixel = 0
				fill.Size = UDim2.new(0, 0, 1, 0)

				local button = Instance.new("TextButton")
				button.Name = "button"
				button.Parent = main
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.Size = UDim2.new(0, 278, 3.2, 0)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14
				button.Position = UDim2.new(0, 0, 0, -9)

				local tbutton = Instance.new("Frame")
				tbutton.Name = "button"
				tbutton.Parent = main
				tbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				tbutton.BackgroundTransparency = 1
				tbutton.Size = UDim2.new(0, 282, 3.2, 0)
				tbutton.Position = UDim2.new(0, 0, 0, -9)

				local valuetext = Instance.new("TextLabel")
				valuetext.Name = "valuetext"
				valuetext.Parent = main
				valuetext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				valuetext.BackgroundTransparency = 1
				valuetext.Position = UDim2.new(0, 125, 0, -13)
				valuetext.Size = UDim2.new(1, 0, 0, 10)
				valuetext.Font = Enum.Font.Code
				valuetext.Text = '0/0'
				valuetext.TextColor3 = Color3.fromRGB(255, 255, 255)
				valuetext.TextSize = 10
				valuetext.TextStrokeTransparency = 0

				local valuetext2 = Instance.new("TextLabel")
				valuetext2.Name = "valuetext"
				valuetext2.Parent = main
				valuetext2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				valuetext2.BackgroundTransparency = 1
				valuetext2.Position = UDim2.new(0, 125, 0, -13)
				valuetext2.Size = UDim2.new(1, 0, 0, 10)
				valuetext2.Font = Enum.Font.Code
				valuetext2.Text = '0/0'
				valuetext2.TextColor3 = Color3.fromRGB(255, 255, 255)
				valuetext2.TextSize = 8
				valuetext2.TextStrokeTransparency = 0

				local UIGradient = Instance.new("UIGradient")
				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 121, 121))}
				UIGradient.Rotation = 90
				UIGradient.Parent = main

				local text = Instance.new("TextLabel")
				text.Name = "text"
				text.Parent = slider
				text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text.BackgroundTransparency = 1
				text.Position = UDim2.new(0.03, -1, 0, 7)
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13
				text.TextStrokeTransparency = 0
				text.TextXAlignment = Enum.TextXAlignment.Left

				local entered = false
				local dragging = false
				local minValue = args.min or 0
				local maxValue = args.max or 100

				local function updateValue(value)
					if library.colorpicking then return end
					local clampedValue = math.clamp(value, minValue, maxValue)
					local percentage = (clampedValue - minValue) / (maxValue - minValue)
					local fillSize = UDim2.new(percentage, 0, 1, 0)
					fill:TweenSize(fillSize, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.065, true)
					local formattedValue = string.format("%." .. (args.decimals or 0) .. "f", clampedValue)
					valuetext.Text = formattedValue .. sub
					valuetext2.Text = formattedValue .. sub
					local offset = 0
					local offset2 = 0
					local offset3 = 0
					local threshold = UDim2.new(0.01, -145, 0, 8)
					local threshold2 = UDim2.new(0.02, -145, 0, 8)
					local threshold3 = UDim2.new(0.03, -145, 0, 8)
					local threshold4 = UDim2.new(0.04, -145, 0, 8)
					local threshold5 = UDim2.new(0.05, -145, 0, 8)
					local threshold6 = UDim2.new(0.06, -145, 0, 8)
					local threshold7 = UDim2.new(0.965, -145, 0, 8)
					if args.decimals >= 3 then 
						if fillSize.X.Scale >= threshold7.X.Scale then
							offset3 = 0.0055
						else
							offset2 = 0.02
						end
					end
					if fillSize.X.Scale <= threshold.X.Scale then 
						offset = 0.06
					elseif fillSize.X.Scale <= threshold2.X.Scale then
						offset = 0.05
					elseif fillSize.X.Scale <= threshold3.X.Scale then
						offset = 0.04
					elseif fillSize.X.Scale <= threshold4.X.Scale then
						offset = 0.03
					elseif fillSize.X.Scale <= threshold5.X.Scale then
						offset = 0.02
					elseif fillSize.X.Scale <= threshold6.X.Scale then
						offset = 0.01
					end
					library:Tween(valuetext2, TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(fillSize.X.Scale + offset + offset2 - offset3, -145, 0, 8)})
					library.flags[args.flag] = clampedValue
					if args.callback then
						args.callback(clampedValue)
					end
				end

				local currentValue = nil

				button.MouseButton1Down:Connect(function()
					if library.colorpicking then return end
					dragging = true
					while dragging do
						local newValue = minValue + ((mouse.X - button.AbsolutePosition.X) / button.AbsoluteSize.X) * (maxValue - minValue)
						if newValue ~= currentValue then
							currentValue = newValue
							updateValue(newValue)
						end
						wait()
					end
				end)

				button.MouseButton1Up:Connect(function()
					updateValue(minValue + ((mouse.X - button.AbsolutePosition.X) / button.AbsoluteSize.X) * (maxValue - minValue))
					dragging = false
				end)

				button.MouseEnter:Connect(function()
					if library.colorpicking then return end
					entered = true
					main.BorderColor3 = library.libColor
				end)

				tbutton.MouseLeave:Connect(function()
					entered = false
					dragging = false
					main.BorderColor3 = Color3.fromRGB(60, 60, 60)
				end)

				if args.value then
					updateValue(args.value)
				end

				library.flags[args.flag] = minValue
				library.options[args.flag] = {
					type = "slider",
					changeState = updateValue,
					skipflag = args.skipflag,
					oldargs = args
				}

				updateValue(args.value or minValue)
			end
			function group:addList(args)
				if not args.flag or not args.values then return warn('') end
				groupbox.Size += UDim2.new(0, 0, 0, 40)
				library.multiZindex -= 1

				local list = Instance.new("Frame")
				local bg = Instance.new("Frame")
				local main = Instance.new("ScrollingFrame")
				local button = Instance.new("TextButton")
				local dumbtriangle = Instance.new("ImageLabel")
				local valuetext = Instance.new("TextLabel")
				local gradient = Instance.new("UIGradient")
				local text = Instance.new("TextLabel")

				local frame = Instance.new("Frame")
				local holder = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local TweenService = game:GetService("TweenService")

				list.Name = "list"
				list.Parent = grouper
				list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				list.BackgroundTransparency = 1.000
				list.BorderSizePixel = 0
				list.Size = UDim2.new(1, 0, 0, 35)
				list.ZIndex = library.multiZindex

				bg.Name = "bg"
				bg.Parent = list
				bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 2
				bg.Position = UDim2.new(0.02, -1, 0, 16)
				bg.Size = UDim2.new(0, 205, 0, 15)

				main.Name = "main"
				main.Parent = bg
				main.Active = true
				main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				main.BorderColor3 = Color3.fromRGB(30, 30, 30)
				main.Size = UDim2.new(1, 0, 1, 0)
				main.CanvasSize = UDim2.new(0, 0, 0, 0)
				main.ScrollBarThickness = 1

				button.Name = "button"
				button.Parent = main
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.Size = UDim2.new(0, 215, 1, 0)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14.000

				dumbtriangle.Name = "dumbtriangle"
				dumbtriangle.Parent = main
				dumbtriangle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				dumbtriangle.BackgroundTransparency = 1.000
				dumbtriangle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				dumbtriangle.BorderSizePixel = 0
				dumbtriangle.Position = UDim2.new(1, -11, 0.5, -3)
				dumbtriangle.Size = UDim2.new(0, 7, 0, 6)
				dumbtriangle.ZIndex = 3
				dumbtriangle.Image = "rbxassetid://8532000591"

				valuetext.Name = "valuetext"
				valuetext.Parent = main
				valuetext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				valuetext.BackgroundTransparency = 1.000
				valuetext.Position = UDim2.new(0.00200000009, 2, 0, 7)
				valuetext.ZIndex = 2
				valuetext.Font = Enum.Font.Code
				valuetext.Text = ""
				valuetext.TextColor3 = Color3.fromRGB(244, 244, 244)
				valuetext.TextSize = 13.000
				valuetext.TextStrokeTransparency = 0.000
				valuetext.TextXAlignment = Enum.TextXAlignment.Left

				gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
				gradient.Rotation = 90
				gradient.Name = "gradient"
				gradient.Parent = main

				text.Name = "text"
				text.Parent = list
				text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text.BackgroundTransparency = 1.000
				text.Position = UDim2.new(0.0299999993, -1, 0, 7)
				text.ZIndex = 2
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13.000
				text.TextStrokeTransparency = 0.000
				text.TextXAlignment = Enum.TextXAlignment.Left

				frame.Name = "frame"
				frame.Parent = list
				frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				frame.BorderSizePixel = 2
				frame.Position = UDim2.new(0.0299999993, -4, 0.605000019, 15)
				frame.Size = UDim2.new(0, 203, 0, 0)
				frame.Visible = false
				frame.ZIndex = library.multiZindex

				holder.Name = "holder"
				holder.Parent = frame
				holder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				holder.BorderColor3 = Color3.fromRGB(35, 35, 35)
				holder.Size = UDim2.new(1, 0, 1, 0)

				UIListLayout.Parent = holder
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

				local function updateValue(value)
					if value == nil then valuetext.Text = "nil" return end
					if args.multiselect then
						if type(value) == "string" then
							if not table.find(library.options[args.flag].values,value) then return end
							if table.find(library.flags[args.flag],value) then
								for i,v in pairs(library.flags[args.flag]) do
									if v == value then
										table.remove(library.flags[args.flag],i)
									end
								end
							else
								table.insert(library.flags[args.flag],value)
							end
						else
							library.flags[args.flag] = value
						end
						local buttonText = ""
						for i,v in pairs(library.flags[args.flag]) do
							local jig = i ~= #library.flags[args.flag] and "," or ""
							buttonText = buttonText..v..jig
						end
						if buttonText == "" then buttonText = "..." end
						for i,v in next, holder:GetChildren() do
							if v.ClassName ~= "Frame" then continue end
							v.off.TextColor3 = Color3.new(0.65,0.65,0.65)
							for _i,_v in next, library.flags[args.flag] do
								if v.Name == _v then
									v.off.TextColor3 = Color3.new(1,1,1)
								end
							end
						end
						valuetext.Text = buttonText
						if args.callback then
							args.callback(library.flags[args.flag])
						end
					else
						if not table.find(library.options[args.flag].values,value) then value = library.options[args.flag].values[1] end
						library.flags[args.flag] = value
						for i,v in next, holder:GetChildren() do
							if v.ClassName ~= "Frame" then continue end
							v.off.TextColor3 = Color3.new(0.65,0.65,0.65)
							if v.Name == library.flags[args.flag] then
								v.off.TextColor3 = Color3.new(1,1,1)
							end
						end
						frame.Visible = false
						if library.flags[args.flag] then
							valuetext.Text = library.flags[args.flag]
							if args.callback then
								args.callback(library.flags[args.flag])
							end
						end
					end
				end
				local back
				function refresh(tbl)
					for i,v in next, holder:GetChildren() do
						if v.ClassName == "Frame" then
							v:Destroy()
						end
						frame.Size = UDim2.new(0, 205, 0, 0)
					end
					for i,v in pairs(tbl) do
						frame.Size += UDim2.new(0, 0, 0, 20)
						back = frame.Size

						local option = Instance.new("Frame")
						local button_2 = Instance.new("TextButton")
						local text_2 = Instance.new("TextLabel")

						option.Name = v
						option.Parent = holder
						option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						option.BackgroundTransparency = 1.000
						option.Size = UDim2.new(1, 0, 0, 20)

						button_2.Name = "button"
						button_2.Parent = option
						button_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
						button_2.BackgroundTransparency = 0.850
						button_2.BorderSizePixel = 0
						button_2.Size = UDim2.new(1, 0, 1, 0)
						button_2.Font = Enum.Font.SourceSans
						button_2.Text = ""
						button_2.TextColor3 = Color3.fromRGB(0, 0, 0)
						button_2.TextSize = 14.000

						text_2.Name = "off"
						text_2.Parent = option
						text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						text_2.BackgroundTransparency = 1.000
						text_2.Position = UDim2.new(0, 4, 0, 0)
						text_2.Size = UDim2.new(0, 0, 1, 0)
						text_2.Font = Enum.Font.Code
						text_2.Text = v
						text_2.TextColor3 = args.multiselect and Color3.new(0.65,0.65,0.65) or Color3.new(1,1,1)
						text_2.TextSize = 14.000
						text_2.TextStrokeTransparency = 0.000
						text_2.TextXAlignment = Enum.TextXAlignment.Left

						button_2.MouseButton1Click:Connect(function()
							updateValue(v)
						end)
					end
					library.options[args.flag].values = tbl
					updateValue(table.find(library.options[args.flag].values,library.flags[args.flag]) and library.flags[args.flag] or library.options[args.flag].values[1])
				end

				button.MouseButton1Click:Connect(function()
					frame.Visible = not frame.Visible

					if frame.Visible then
						holder.Size = UDim2.new(1, 0, 0, 0)
						frame.Size = UDim2.new(0, 205, 0, 0)

						if not library.colorpicking then
							local targetFrameSize = back
							local targetHolderSize = UDim2.new(1, 0, 1, 0)
							local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
							local tweenFrame = TweenService:Create(frame, tweenInfo, {Size = targetFrameSize})
							local tweenHolder = TweenService:Create(holder, tweenInfo, {Size = targetHolderSize})

							tweenFrame:Play()
							tweenHolder:Play()

							tweenFrame.Completed:Connect(function()
								frame.Size = back
								holder.Size = UDim2.new(1, 0, 1, 0)
							end)
						end
					else
						frame.Size = UDim2.new(0, 205, 0, 0)
						holder.Size = UDim2.new(1, 0, 0, 0)
					end
				end)
				button.MouseEnter:connect(function()
					main.BorderColor3 = library.libColor
				end)
				button.MouseLeave:connect(function()
					main.BorderColor3 = Color3.fromRGB(35, 35, 35)
				end)

				table.insert(library.toInvis,frame)
				library.flags[args.flag] = args.multiselect and {} or ""
				library.options[args.flag] = {type = "list",changeState = updateValue,values = args.values,refresh = refresh,skipflag = args.skipflag,oldargs = args}

				refresh(args.values)
				updateValue(args.value or not args.multiselect and args.values[1] or "abcdefghijklmnopqrstuwvxyz")
			end
			function group:addTextbox(args)
				if not args.flag then
					warn('')
					return
				end
				groupbox.Size += UDim2.new(0, 0, 0, 35)

				local textbox = Instance.new("Frame")
				local bg = Instance.new("Frame")
				local main = Instance.new("ScrollingFrame")
				local box = Instance.new("TextBox")
				local gradient = Instance.new("UIGradient")
				local text = Instance.new("TextLabel")

				local function updateText()
					if library.colorpicking then return end
					local textValue = box.Text
					library.flags[args.flag] = textValue
					args.value = textValue
					if args.callback then
						args.callback(textValue)
					end
					return textValue
				end

				box.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						updateText()
					end
				end)

				textbox.Name = "textbox"
				textbox.Parent = grouper
				textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				textbox.BackgroundTransparency = 1.000
				textbox.BorderSizePixel = 0
				textbox.Size = UDim2.new(1, 0, 0, 35)
				textbox.ZIndex = 10

				bg.Name = "bg"
				bg.Parent = textbox
				bg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 2
				bg.Position = UDim2.new(0.02, -1, 0, 16)
				bg.Size = UDim2.new(0, 205, 0, 15)

				main.Name = "main"
				main.Parent = bg
				main.Active = true
				main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				main.BorderColor3 = Color3.fromRGB(30, 30, 30)
				main.Size = UDim2.new(1, 0, 1, 0)
				main.CanvasSize = UDim2.new(0, 0, 0, 0)
				main.ScrollBarThickness = 0

				box.Name = "box"
				box.Parent = main
				box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				box.BackgroundTransparency = 1.000
				box.Selectable = false
				box.Size = UDim2.new(1, 0, 1, 0)
				box.Font = Enum.Font.Code
				box.Text = args.value or ""
				box.TextColor3 = Color3.fromRGB(255, 255, 255)
				box.TextSize = 13.000
				box.TextStrokeTransparency = 0.000
				box.TextXAlignment = Enum.TextXAlignment.Left

				gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
				gradient.Rotation = 90
				gradient.Name = "gradient"
				gradient.Parent = main

				text.Name = "text"
				text.Parent = textbox
				text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text.BackgroundTransparency = 1.000
				text.Position = UDim2.new(0.0299999993, -1, 0, 7)
				text.ZIndex = 2
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13.000
				text.TextStrokeTransparency = 0.000
				text.TextXAlignment = Enum.TextXAlignment.Left

				library.flags[args.flag] = args.value or ""
				library.options[args.flag] = {
					type = "textbox",
					changeState = function(text)
						box.Text = text
					end,
					skipflag = args.skipflag,
					oldargs = args
				}

				return updateText
			end
			function group:addMultiTextbox(args)
				if not args.flag then
					warn('')
					return
				end
				groupbox.Size += UDim2.new(0, 0, 0, 35)

				local textbox = Instance.new("Frame")
				local bg = Instance.new("Frame")
				local bg1 = Instance.new("Frame")
				local bg2 = Instance.new("Frame")
				local bg3 = Instance.new("Frame")
				local main = Instance.new("ScrollingFrame")
				local main2 = Instance.new("ScrollingFrame")
				local main3 = Instance.new("ScrollingFrame")
				local box = Instance.new("TextBox")
				local box2 = Instance.new("TextBox")
				local box3 = Instance.new("TextBox")
				local gradient = Instance.new("UIGradient")
				local text = Instance.new("TextLabel")
				local xtext = Instance.new("TextLabel")
				local ytext = Instance.new("TextLabel")
				local ztext = Instance.new("TextLabel")

				local function updateText()
					if library.colorpicking then return end
					local textValue = box.Text
					local textValue2 = box2.Text
					local textValue3 = box3.Text
					library.flags[args.flag] = {textValue, textValue2, textValue3}
					args.value = {textValue, textValue2, textValue3}
					if args.callback then
						args.callback({textValue, textValue2, textValue3})
					end
					return {textValue, textValue2, textValue3}
				end

				box.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						updateText()
					end
				end)

				box2.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						updateText()
					end
				end)

				box3.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						updateText()
					end
				end)

				textbox.Name = "textbox"
				textbox.Parent = grouper
				textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				textbox.BackgroundTransparency = 1.000
				textbox.BorderSizePixel = 0
				textbox.Size = UDim2.new(1, 0, 0, 35)
				textbox.ZIndex = 10

				bg.Name = "bg"
				bg.Parent = textbox
				bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 0
				bg.Transparency = 1
				bg.Position = UDim2.new(0.02, -1, 0, 16)
				bg.Size = UDim2.new(0, 205, 0, 15)

				main.Name = "main"
				main.Parent = bg
				main.Active = true
				main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				main.BorderColor3 = Color3.fromRGB(30, 30, 30)
				main.Size = UDim2.new(1, -155, 1, 0)
				main.CanvasSize = UDim2.new(0, 0, 0, 0)
				main.ScrollBarThickness = 0

				bg1.Name = "bg1"
				bg1.Parent = bg
				bg1.Active = true
				bg1.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				bg1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg1.Size = UDim2.new(1, -155, 1, 0)
				bg1.BorderSizePixel = 2
				bg1.ZIndex = -1

				bg2.Name = "bg1"
				bg2.Parent = bg
				bg2.Active = true
				bg2.Position = UDim2.new(0, 77, 0, 0)
				bg2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				bg2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg2.Size = UDim2.new(1, -155, 1, 0)
				bg2.BorderSizePixel = 2
				bg2.ZIndex = -1

				bg3.Name = "bg1"
				bg3.Parent = bg
				bg3.Active = true
				bg3.Position = UDim2.new(0, 155, 0, 0)
				bg3.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				bg3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg3.Size = UDim2.new(1, -155, 1, 0)
				bg3.BorderSizePixel = 2
				bg3.ZIndex = -1

				main2.Name = "main2"
				main2.Parent = bg
				main2.Active = true
				main2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				main2.Position = UDim2.new(0, 77, 0, 0)
				main2.BorderColor3 = Color3.fromRGB(30, 30, 30)
				main2.Size = UDim2.new(1, -155, 1, 0)
				main2.CanvasSize = UDim2.new(0, 0, 0, 0)
				main2.ScrollBarThickness = 0

				main3.Name = "main3"
				main3.Parent = bg
				main3.Active = true
				main3.Position = UDim2.new(0, 155, 0, 0)
				main3.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				main3.BorderColor3 = Color3.fromRGB(30, 30, 30)
				main3.Size = UDim2.new(1, -155, 1, 0)
				main3.CanvasSize = UDim2.new(0, 0, 0, 0)
				main3.ScrollBarThickness = 0

				box.Name = "box"
				box.Parent = main
				box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				box.BackgroundTransparency = 1
				box.Selectable = false
				box.Size = UDim2.new(1, 0, 1, 0)
				box.Font = Enum.Font.Code
				box.Text = args.value and args.value[1] or ""
				box.TextColor3 = Color3.fromRGB(255, 255, 255)
				box.TextSize = 13.000
				box.TextStrokeTransparency = 0.000
				box.TextXAlignment = Enum.TextXAlignment.Left

				xtext.Name = "xtext"
				xtext.Parent = box
				xtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				xtext.BackgroundTransparency = 1.000
				xtext.Position = UDim2.new(0, 40, 0, 7)
				xtext.ZIndex = 2
				xtext.Font = Enum.Font.Code
				xtext.Text = "X"
				xtext.TextColor3 = Color3.fromRGB(244, 244, 244)
				xtext.TextSize = 12.000
				xtext.TextStrokeTransparency = 1.000
				xtext.TextXAlignment = Enum.TextXAlignment.Left

				box2.Name = "box2"
				box2.Parent = main2
				box2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				box2.BackgroundTransparency = 1
				box2.Selectable = false
				box2.Size = UDim2.new(1, 0, 1, 0)
				box2.Font = Enum.Font.Code
				box2.Text = args.value and args.value[2] or ""
				box2.TextColor3 = Color3.fromRGB(255, 255, 255)
				box2.TextSize = 13.000
				box2.TextStrokeTransparency = 0.000
				box2.TextXAlignment = Enum.TextXAlignment.Left

				ytext.Name = "ytext"
				ytext.Parent = box2
				ytext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ytext.BackgroundTransparency = 1.000
				ytext.Position = UDim2.new(0, 40, 0, 7)
				ytext.ZIndex = 2
				ytext.Font = Enum.Font.Code
				ytext.Text = "Y"
				ytext.TextColor3 = Color3.fromRGB(244, 244, 244)
				ytext.TextSize = 12.000
				ytext.TextStrokeTransparency = 1.000
				ytext.TextXAlignment = Enum.TextXAlignment.Left

				box3.Name = "box3"
				box3.Parent = main3
				box3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				box3.BackgroundTransparency = 1
				box3.Selectable = false
				box3.Size = UDim2.new(1, 0, 1, 0)
				box3.Font = Enum.Font.Code
				box3.Text = args.value and args.value[3] or ""
				box3.TextColor3 = Color3.fromRGB(255, 255, 255)
				box3.TextSize = 13.000
				box3.TextStrokeTransparency = 0.000
				box3.TextXAlignment = Enum.TextXAlignment.Left

				ztext.Name = "ztext"
				ztext.Parent = box3
				ztext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ztext.BackgroundTransparency = 1.000
				ztext.Position = UDim2.new(0, 40, 0, 7)
				ztext.ZIndex = 2
				ztext.Font = Enum.Font.Code
				ztext.Text = "Z"
				ztext.TextColor3 = Color3.fromRGB(244, 244, 244)
				ztext.TextSize = 12.000
				ztext.TextStrokeTransparency = 1.000
				ztext.TextXAlignment = Enum.TextXAlignment.Left

				gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(105, 105, 105)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 121, 121))}
				gradient.Rotation = 90
				gradient.Name = "gradient"
				gradient.Parent = main

				text.Name = "text"
				text.Parent = textbox
				text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text.BackgroundTransparency = 1.000
				text.Position = UDim2.new(0.0299999993, -1, 0, 7)
				text.ZIndex = 2
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13.000
				text.TextStrokeTransparency = 0.000
				text.TextXAlignment = Enum.TextXAlignment.Left

				library.flags[args.flag] = args.value or ""
				library.options[args.flag] = {
					type = "textbox",
					changeState = function(text)
						box.Text = text[1]
						box2.Text = text[2]
						box3.Text = text[3]
					end,
					skipflag = args.skipflag,
					oldargs = args
				}

				return updateText
			end
			function group:addDivider(args)
				groupbox.Size += UDim2.new(0, 0, 0, 10)

				local div = Instance.new("Frame")
				local bg = Instance.new("Frame")
				local main = Instance.new("Frame")

				div.Name = "div"
				div.Parent = grouper
				div.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				div.BackgroundTransparency = 1.000
				div.BorderSizePixel = 0
				div.Position = UDim2.new(0, 0, 0.743662, 0)
				div.Size = UDim2.new(0, 202, 0, 10)

				bg.Name = "bg"
				bg.Parent = div
				bg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
				bg.BorderSizePixel = 2
				bg.Position = UDim2.new(0.02, 0, 0, 4)
				bg.Size = UDim2.new(0, 191, 0, 1)

				main.Name = "main"
				main.Parent = bg
				main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				main.BorderColor3 = Color3.fromRGB(60, 60, 60)
				main.Size = UDim2.new(0, 191, 0, 1)
			end
			function group:addKeybind(args)
				if not args.flag then
					warn("Missing required parameter: flag")
					return
				end

				groupbox.Size = groupbox.Size + UDim2.new(0, 0, 0, 20)

				local keybind = Instance.new("Frame")
				keybind.Parent = grouper
				keybind.BackgroundTransparency = 1
				keybind.Size = UDim2.new(1, 0, 0, 20)

				local text = Instance.new("TextLabel")
				text.Parent = keybind
				text.BackgroundTransparency = 1
				text.Position = UDim2.new(0.02, 0, 0, 10)
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13
				text.TextStrokeTransparency = 0
				text.TextXAlignment = Enum.TextXAlignment.Left

				local button = Instance.new("TextButton")
				button.Parent = keybind
				button.BackgroundColor3 = Color3.fromRGB(187, 131, 255)
				button.BackgroundTransparency = 1
				button.BorderSizePixel = 0
				button.Position = UDim2.new(0.16, 0, 0, 0)
				button.Size = UDim2.new(1, 0, 1, 0)
				button.Font = Enum.Font.Code
				button.Text = "=_="
				button.TextColor3 = Color3.fromRGB(250, 250, 250)
				button.TextSize = 12
				button.TextStrokeTransparency = 1
				button.TextXAlignment = Enum.TextXAlignment.Center

				local function updateValue(val)
					if library.colorpicking then return end
					library.flags[args.flag] = val
					button.Text = keyNames[val] or tostring(val)
				end

				button.MouseButton1Click:Connect(function()
					if library.colorpicking then return end
					button.Text = "=_="
					button.TextColor3 = Color3.new(1, 1, 1)
					local input = inputService.InputBegan:Wait()
					local key = input.KeyCode == Enum.KeyCode.Unknown and input.UserInputType or input.KeyCode
					if not table.find(library.blacklisted, key) then
						library.flags[args.flag] = key
						button.Text = keyNames[key] or tostring(key)
						button.TextColor3 = Color3.fromRGB(255, 255, 255)
						if args.callback then
							args.callback(key)
						end
					else
						button.Text = "nil"
						button.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end)

				library.flags[args.flag] = Enum.KeyCode.Unknown
				library.options[args.flag] = {
					type = "keybind",
					changeState = updateValue,
					skipflag = args.skipflag,
					oldargs = args
				}

				updateValue(args.key or Enum.KeyCode.Unknown)
			end
			function group:addColorpicker(args)
				if not args.flag then return warn('') end
				groupbox.Size += UDim2.new(0, 0, 0, 20)

				library.multiZindex -= 1
				jigCount -= 1
				topStuff -= 1

				local colorpicker = Instance.new("Frame")
				local back = Instance.new("Frame")
				local mid = Instance.new("Frame")
				local front = Instance.new("Frame")
				local text = Instance.new("TextLabel")
				local colorpicker_2 = Instance.new("Frame")
				local button = Instance.new("TextButton")

				local colorFrame = Instance.new("Frame")
				local colorFrame_2 = Instance.new("Frame")
				local hueframe = Instance.new("Frame")
				local main = Instance.new("Frame")
				local hue = Instance.new("ImageLabel")
				local pickerframe = Instance.new("Frame")
				local main_2 = Instance.new("Frame")
				local picker = Instance.new("ImageLabel")
				local clr = Instance.new("Frame")
				local copy = Instance.new("TextButton")

				colorpicker.Name = "colorpicker"
				colorpicker.Parent = grouper
				colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				colorpicker.BackgroundTransparency = 1.000
				colorpicker.BorderSizePixel = 0
				colorpicker.Size = UDim2.new(1, 0, 0, 20)
				colorpicker.ZIndex = topStuff

				text.Name = "text"
				text.Parent = colorpicker
				text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				text.BackgroundTransparency = 1.000
				text.Position = UDim2.new(0.02, -1, 0, 10)
				text.Font = Enum.Font.Code
				text.Text = args.text or args.flag
				text.TextColor3 = Color3.fromRGB(244, 244, 244)
				text.TextSize = 13.000
				text.TextStrokeTransparency = 0.000
				text.TextXAlignment = Enum.TextXAlignment.Left

				button.Name = "button"
				button.Parent = colorpicker
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.BorderSizePixel = 0
				button.Size = UDim2.new(1, 0, 1, 0)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14.000

				colorpicker_2.Name = "colorpicker"
				colorpicker_2.Parent = colorpicker
				colorpicker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				colorpicker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				colorpicker_2.BorderSizePixel = 3
				colorpicker_2.Position = UDim2.new(0.860000014, 4, 0.272000015, 0)
				colorpicker_2.Size = UDim2.new(0, 20, 0, 10)

				mid.Name = "mid"
				mid.Parent = colorpicker_2
				mid.BackgroundColor3 = Color
				mid.BorderColor3 = Color3.fromRGB(30,30,30)
				mid.BorderSizePixel = 2
				mid.Size = UDim2.new(1, 0, 1, 0)

				front.Name = "front"
				front.Parent = mid
				front.BackgroundColor3 = Color3.fromRGB(240, 142, 214)
				front.BorderColor3 = Color3.fromRGB(0, 0, 0)
				front.Size = UDim2.new(1, 0, 1, 0)

				button.Name = "button"
				button.Parent = colorpicker
				button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				button.BackgroundTransparency = 1
				button.Size = UDim2.new(0, 125, 0, 16)
				button.Position = UDim2.new(0,165,0,2)
				button.Font = Enum.Font.SourceSans
				button.Text = ""
				button.ZIndex = args.ontop and topStuff or jigCount
				button.TextColor3 = Color3.fromRGB(0, 0, 0)
				button.TextSize = 14.000

				colorFrame.Name = "colorFrame"
				colorFrame.Parent = colorpicker
				colorFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				colorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				colorFrame.BorderSizePixel = 2
				colorFrame.Position = UDim2.new(0.101092957, 0, 0.75, 0)
				colorFrame.Size = UDim2.new(0, 137, 0, 128)

				colorFrame_2.Name = "colorFrame"
				colorFrame_2.Parent = colorFrame
				colorFrame_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				colorFrame_2.BorderColor3 = Color3.fromRGB(60, 60, 60)
				colorFrame_2.Size = UDim2.new(1, 0, 1, 0)

				hueframe.Name = "hueframe"
				hueframe.Parent = colorFrame_2
				hueframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				hueframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
				hueframe.BorderSizePixel = 2
				hueframe.Position = UDim2.new(-0.0930000022, 18, -0.0599999987, 30)
				hueframe.Size = UDim2.new(0, 100, 0, 100)

				main.Name = "main"
				main.Parent = hueframe
				main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				main.BorderColor3 = Color3.fromRGB(0, 0, 0)
				main.Size = UDim2.new(0, 100, 0, 100)
				main.ZIndex = 6

				picker.Name = "picker"
				picker.Parent = main
				picker.BackgroundColor3 = Color3.fromRGB(232, 0, 255)
				picker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				picker.BorderSizePixel = 0
				picker.Size = UDim2.new(0, 100, 0, 100)
				picker.ZIndex = 104
				picker.Image = "rbxassetid://2615689005"

				pickerframe.Name = "pickerframe"
				pickerframe.Parent = colorFrame
				pickerframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				pickerframe.BorderColor3 = Color3.fromRGB(60, 60, 60)
				pickerframe.BorderSizePixel = 2
				pickerframe.Position = UDim2.new(0.711000025, 14, -0.0599999987, 30)
				pickerframe.Size = UDim2.new(0, 20, 0, 100)

				main_2.Name = "main"
				main_2.Parent = pickerframe
				main_2.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				main_2.Size = UDim2.new(0, 20, 0, 100)
				main_2.ZIndex = 6

				hue.Name = "hue"
				hue.Parent = main_2
				hue.BackgroundColor3 = Color3.fromRGB(255, 0, 178)
				hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				hue.BorderSizePixel = 0
				hue.Size = UDim2.new(0, 20, 0, 100)
				hue.ZIndex = 104
				hue.Image = "rbxassetid://2615692420"

				clr.Name = "clr"
				clr.Parent = colorFrame
				clr.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				clr.BackgroundTransparency = 1.000
				clr.BorderColor3 = Color3.fromRGB(60, 60, 60)
				clr.BorderSizePixel = 2
				clr.Position = UDim2.new(0.0280000009, 0, 0, 2)
				clr.Size = UDim2.new(0, 129, 0, 14)
				clr.ZIndex = 5

				copy.Name = "copy"
				copy.Parent = clr
				copy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				copy.BackgroundTransparency = 1
				copy.BorderSizePixel = 0
				copy.Size = UDim2.new(0, 129, 0, 14)
				copy.ZIndex = 5
				copy.Font = Enum.Font.Code
				copy.Text = "Picker"
				copy.TextColor3 = Color3.fromRGB(255, 255, 255)
				copy.TextSize = 12.000
				copy.TextStrokeTransparency = 1.000

				copy.MouseButton1Click:Connect(function()
					colorFrame.Visible = false
				end)

				button.MouseButton1Click:Connect(function()
					colorFrame.Visible = not colorFrame.Visible
					mid.BorderColor3 = Color3.fromRGB(30,30,30)
				end)

				button.MouseEnter:connect(function()
					mid.BorderColor3 = library.libColor
				end)
				button.MouseLeave:connect(function()
					mid.BorderColor3 = Color3.fromRGB(30,30,30)
				end)

				local function updateValue(value,fakevalue)
					if typeof(value) == "table" then value = fakevalue end 
					library.flags[args.flag] = value
					front.BackgroundColor3 = value
					copy.TextColor3 = value
					if args.callback then
						args.callback(value)
					end
				end

				local white, black = Color3.new(1,1,1), Color3.new(0,0,0)
				local colors = {Color3.new(1,0,0),Color3.new(1,1,0),Color3.new(0,1,0),Color3.new(0,1,1),Color3.new(0,0,1),Color3.new(1,0,1),Color3.new(1,0,0)}
				local heartbeat = game:GetService("RunService").Heartbeat

				local pickerX,pickerY,hueY = 0,0,0
				local oldpercentX,oldpercentY = 0,0

				hue.MouseEnter:Connect(function()
					local input = hue.InputBegan:connect(function(key)
						if key.UserInputType == Enum.UserInputType.MouseButton1 then
							while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
								library.colorpicking = true
								local percent = (hueY-hue.AbsolutePosition.Y-56)/hue.AbsoluteSize.Y
								local num = math.max(1, math.min(7,math.floor(((percent*7+0.5)*100))/100))
								local startC = colors[math.floor(num)]
								local endC = colors[math.ceil(num)]
								local color = white:lerp(picker.BackgroundColor3, oldpercentX):lerp(black, oldpercentY)
								picker.BackgroundColor3 = startC:lerp(endC, num-math.floor(num)) or Color3.new(0, 0, 0)
								updateValue(color)
							end
							library.colorpicking = false
						end
					end)
					local leave
					leave = hue.MouseLeave:connect(function()
						input:disconnect()
						leave:disconnect()
					end)
				end)

				picker.MouseEnter:Connect(function()
					local input = picker.InputBegan:connect(function(key)
						if key.UserInputType == Enum.UserInputType.MouseButton1 then
							while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
								library.colorpicking = true
								local xPercent = (pickerX-picker.AbsolutePosition.X)/picker.AbsoluteSize.X
								local yPercent = (pickerY-picker.AbsolutePosition.Y-58)/picker.AbsoluteSize.Y
								local color = white:lerp(picker.BackgroundColor3, xPercent):lerp(black, yPercent)
								updateValue(color)
								oldpercentX,oldpercentY = xPercent,yPercent
							end
							library.colorpicking = false
						end
					end)
					local leave
					leave = picker.MouseLeave:connect(function()
						input:disconnect()
						leave:disconnect()
					end)
				end)

				hue.MouseMoved:connect(function(_, y)
					hueY = y
				end)

				picker.MouseMoved:connect(function(x, y)
					pickerX,pickerY = x,y
				end)

				table.insert(library.toInvis,colorFrame)
				library.flags[args.flag] = Color3.new(1,1,1)
				library.options[args.flag] = {type = "colorpicker",changeState = updateValue,skipflag = args.skipflag,oldargs = args}

				updateValue(args.color or Color3.new(1,1,1))
			end
			return group, groupbox
		end
		return tab
	end
end
return library

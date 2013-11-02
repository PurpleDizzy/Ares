-- Soon to be setting menu when you press F1 or something


local function DermaSMenu()
	local base = vgui.Create( "DFrame" )
		base:SetPos( ScrW()/2 - 225, ScrH()/2 - 100 )
		base:SetSize( 450, 200 )
		base:SetVisible( true )
		base:SetTitle (" Ares: Settings" )
		base:SetDraggable( false )
		base:ShowCloseButton( true )
		base:MakePopup()
		
	local Text = vgui.Create("DLabel",base)
		Text:SetText "TODO: Add Settings Here"
		Text:SizeToContents()
		Text:Center()
end
usermessage.Hook("SMenu", DermaSMenu)
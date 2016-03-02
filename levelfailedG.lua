 --. Level 1 End. Lose
local loadsave = require( "loadsave" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local sfx = require( "sfx" )
local widget = require("widget")
local score = require("score")
local energyM = require("energy")

gameSettings = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
local curLvl = gameSettings.currentLevel
local energy = {}
local numberOfEnergy = gameSettings.levels[curLvl].energy
loadsave.printTable(gameSettings.levels[curLvl].energy)

local function buttonOnPress(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.click, { loops = 0, channel = 32, onComplete = function()  audio.dispose(32)  end } )
	end
end

local function buttonOnRelease(event)
	local button = event.target.id
		if button == "back" then
			--if gameSettings.musicOn == true  then audio.resume( 1 ) end
			storyboard.removeAll(); storyboard.gotoScene( "mapG", "fade", 200 )
		end
end

function scene:enterScene(event)
	if gameSettings.soundOn == true then
		audio.play( sfx.fail, { loops = 0, channel = 26, onComplete = function()  audio.dispose( 26 )  end } )
		audio.play( sfx.choices, { loops = -1, channel = 31,  onComplete = function()  audio.dispose(31)  end } )
	end
end

function scene:createScene( event )
	local group = self.view
	
	local background = display.newImage("images/bg.png"); background.height = _H; background.width = _W + _W/4; background.x = _W/2; background.y = _H/2;
	local back = widget.newButton { defaultFile = "images/back2.png", overFile ="images/back2.png", id = "back", x = _W/30, y = _H - _H/10, height =  _H/9 + 17, width = _W/9 + 18 , onRelease = buttonOnRelease , onPress = buttonOnPress}	
	local textmap = display.newText( "Map", _W/30 - 10, _H - _H/40, "riffic", 10 ); textmap:setFillColor( 1,1,1 )
	local candy = display.newImage("images/candy.png"); candy.x = _W - 20; candy.y = _H/15;candy.width = 80; candy.height = 25
	local scoreText = display.newText(gameSettings.levels[curLvl].score, 270, 10, "riffic", 18 ); scoreText.x = _W - 5; scoreText.y = _H/15; scoreText:setFillColor( 1,0,0 )
	
	
	local textEnd = display.newText( " ", _W/2 , _H/2, "riffic", 18 ); textEnd:setFillColor( 1,1,1 )
	if gameSettings.lang == "english" then
		if curLvl == 1 then
			textEnd.text = "Give no reaction to verbal bullying. \nTry to stay calm and just walk away. \n Get Help! Always have your friends around you. \nIt can be helpful to talk or \ntell to a trusted adult, family member,\n friend, teacher or school \nguidance counselor. If the bullying \ncontinues, in order to deal with this \nproperly, a little courage \nwill go a long way. "
		elseif curLvl == 2 then
			textEnd.text = "The best way to overcome physical \nbullying is to not tolerate it. Do talk to an adult \nyou trust - your parents, a \nteacher, a counselor, a friend - \nsomeone who you believe will listen\n and cares about you. If you are afraid to \ntell someone on your own, \nbring a friend with you\n to provide support. Do avoid areas\n where the bullying is likely\n to happen."
		elseif curLvl == 3 then
			textEnd.text = "Don't respond. If someone bullies you, remember that your \nreaction is usually exactly what the bully wants. Talk\n to a trusted adult. You deserve backup.It's always \ngood to involve a parent. Block the bully. If the \nharassment's coming in the form of instant messages, texts, or \nprofile comments, use preferences or privacy\n tools to block the person. If it's in chat, leave the room."
		elseif curLvl == 4 then
			textEnd.text = "Do stand up to the bully. Bullies usually \ncontinue to bully because they think you are \nafraid of them. The next time the bully makes \na comment tell them to stop.  \n When you confront a bully, do so in front of \nothers in a place you consider safe."
		elseif curLvl == 5 then
			textEnd.text = "Say no when something feels uncomfortable, very strange \nor alarming. Don’t go along with doing something\n just because an adult — including a relative or \nfamily friend — says do it. \n Your private parts are your own. Don’t let someone \nviolate your personal space."
		end	
	elseif gameSettings.lang == "tagalog" then
		if curLvl == 1 then
			textEnd.text = "Maging kalmado sa mga ganitong sitwasyon at iwasan.\n Humingi ng tulong. Magandang kausapin ang iyong \nmagulang, kaibigan, teacher o school counselor."
		elseif curLvl == 2 then
			textEnd.text = "Pag sinasaktan ka ng nangaaway sayo, kausapin mo \nagad ang nakakatanda sayo pwedeng teacher mo, school\n counselor nyo o ang magulang mo. \nIwasan mo ang mga lugar kung saan sila nangaaway. \nDahil ang mga bully ay nangaaway sa mga lugar na\n hndi masyadong dinadaanan ng teacher."
		elseif curLvl == 3 then
			textEnd.text = "Wag sumagot. Pag may nagbubully sayo, alalahanin \nna ang reaksyon mo ang gusto ng bully. Binibigyan \nmo sya ng pagkakataon na awayin ka nya. \nMakipagusap sa magulang. Wag kausapin ang bully, \npag inaaway ka, mas marapatin nang umalis sa chat o \ngamitin ang mga tools para iblock ito"
		elseif curLvl == 4 then
			textEnd.text = "Maging matapang. Huwag kang matakot at sabihin \nsa kanilang tumigil na sila. Pag takot ka, patuloy\n silang mambubully sayo. Kausapin mo sila kung \nsaang nararamdaman mong ligtas ka."
		elseif curLvl == 5 then
			textEnd.text = "Humindi pag may nararamdaman kang kakaiba. Huwag \ngawin ang mga pinapagawa sayo kung alam mong kakaiba \nito.Iyo ang katawan mo. Wag mong hahayaan\n na controlin ito ng ibang tao. Maalarma pag may ginawa \nsya sayo at sinasabi nyang huwag mo itong sabihin sa iba."
		end
	elseif gameSettings.lang == "bicol" then
		if curLvl == 1 then
			textEnd.text = "Maging kalmado sa mga arog kaning sitwasyon. \nMagagad nin tabang. Magandang makiulay sa imong \nmagurang, kaibigan, guro o school counselor."
		elseif curLvl == 2 then
			textEnd.text = "Pag ika’y tiga kulugan kang mga kaiwal mo, \nkaurunun ang nakakatanda. Pag natakot ika na magtaram, \niiba mo ang barkada mo tanganing igwa kang suporta.\n Pagiwasan mo su mga lugar kung sain ka ninda tigaiwal. \nTa ang mga bully ay nangiiwal sa mga lugar \nna warang titser na nagabantay"
		elseif curLvl == 3 then
			textEnd.text = "Dae magsimbag. Pag may nagabully saimo, \nrumdumun na ang reaksyon ang muya kang mga bully. \nTigatawan mo sindang pagkakataon na iwalon ka. \n Magayon \nna itaram ito sa magurang mo. Dae na pagkaurunun \nang bully, pag tigaiwal ka, mas maray nang magali\n sa chat o iblock ito"
		elseif curLvl == 4 then
			textEnd.text = "Maging matapang. Dae ka matakot at taraman mo \nsindang magpundo na. Pag natakot ka, mas manbubully sinda saimo.\n Kaurunun mo sinda kung sain mo \nnararamdaman na ligtas ka."
		elseif curLvl == 5 then
			textEnd.text = "Mag dae pag may nararamdaman kang kakaiba. \nDae mo pag gibuhun ang pipagibo saimo pag aram \nmong kakaiba ito. Saimo ang lawas mo. Dae mo paghayaan\n na controlin ito kang ibang tawo. Maalarma pag tigtaram\n nyang dae mo pag itaram saiba \nang tigagibo nya saimo."
		end
	end
	--transition.fadeIn(textEnd,{ time=2000})
	

	audio.play( sfx.try_again, { loops = 0, channel = 24, onComplete = function()  audio.dispose( 24 )  end } )

	local sheetOptions = { width = 576, height = 320, numFrames = 12 }
	local sheet1 = graphics.newImageSheet( "images/english/girl/level1/imgsheet4.png", sheetOptions )	
	local sequence= {  { name = "girl", start = 1,  count = 2, time = 1000, loopDirection = "forward" },
					{ name = "boy", start = 5,  count = 2, time = 1000, loopDirection = "forward" } }
	local animation = display.newSprite( sheet1, sequence); animation.x = _W - 70; animation.y = _H/2; animation.alpha = 0.5
	if gameSettings.character == "boy" then animation:setSequence("boy") end
		animation:play()
	
	
group:insert(background)
group:insert(animation)
group:insert( textmap )
group:insert( back )
group:insert( candy )
group:insert( scoreText )
group:insert(textEnd)
for i=1,numberOfEnergy do
	energy[i] = display.newImage("images/english/"..gameSettings.character.."/energy.png"); energy[i].x = _W/90 + (30*i) -_W/9; energy[i].y = _H/15; energy[i].width = 26; energy[i].height = 25
	group:insert(energy[i])
end		
end


function scene:destroyScene( event )
local group = self.view
loadsave.saveTable(gameSettings, "myTable.json", system.DocumentsDirectory)
end

function scene:exitScene( event )
	audio.stop(31)
	if  gameSettings.musicOn   then
	  		audio.resume(1)
	  		-- audio.play( sfx.bgmusic, { loops = -1, channel = 1, onComplete = function()  audio.dispose( sfx.bgmusic )  end } )
	end
end

scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "createScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene
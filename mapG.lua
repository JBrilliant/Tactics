module(..., package.seeall);

function new()
	local localGroup = display.newGroup();

	local bg = display.newImage("map.png");
	bg.height = _H; bg.width = _W + _W/4;
	bg.x = _W/2; bg.y = _H/2;
	
	local level1 = display.newImage("level.png");
	level1.height = _H/13 +5; level1.width = _W/13 +1;
	level1.x = _W/2 + _W/6 +8; level1.y = _H/2 + _H/4 +6;
	level1.scene = "scene1G";

	local back = display.newImage("back.png");
	back.height = _H/9 + 17; back.width = _W/9 + 18;
	back.x = _W/30; back.y = _H/10;
	back.scene = "menu";
	
--	level1.self = "self";
	
	-- function enterFrame( e )

	-- 	for i,v in ipairs( e.target.self ) do
	-- 		v.rotation = v.rotation + v.dr
	-- 	end
	-- end

	-- Runtime:addEventListener( "enterFrame", level1 )

		
	function changeScene(e)
		if(e.phase == "ended") then
			director:changeScene(e.target.scene);
		end
	end
	
 	localGroup:insert(bg);
	localGroup:insert(back);
	localGroup:insert(level1);
	
	level1:addEventListener("touch", changeScene);
	back:addEventListener("touch", changeScene);


	return localGroup;
end
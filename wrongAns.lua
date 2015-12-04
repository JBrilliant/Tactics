module(..., package.seeall);

function new()
	local localGroup = display.newGroup();

	
	local background = display.newImage("bgwrong.jpg");
	background.height = _H; background.width = _W + _W/4;
	background.x = _W/2; background.y = _H/2;
	
	local back = display.newImage("back.png");
	back.height = _H/9 + 17; back.width = _W/9 + 18;
	--back.x = _W/30; back.y = _H + _H/10;
	back.x = _W/30 - 20; back.y = _H/10;
	back.scene = "mapB";

	local nexts = display.newImage("next.png");
	nexts.height = _H/9 + 17; nexts.width = _W/9 + 18;
	nexts.x = _W + _W/40; nexts.y =  _H/10;
	nexts.scene = "scene2B";
	
	local wrong = display.newImage("wrong.png");
	wrong.x = _W/2 + 10 ; wrong.y = _H/3 + _H/5;
	wrong.width = _W/2 + _W/3 + _W/10; wrong.height = _H/2 +_H/3 + _H/6;

    
	--boy.scene = "mapB"
	local anim;

	anim = transition.to( wrong,{
		time = 2000,
		y= 50,
		xScale = 2,
		yScale = 2,
		transition = easing.inQuad,
		customProperty = 1000
	});


	local tmr;
	tmr = timer.performWithDelay(500, function(e)
		transition.cancel(anim);
		anim = nil;

		timer.cancel(tmr);
		tmr = nil;
	end,1); 

	
	
	function changeScene(e)
		if(e.phase == "ended") then
			director:changeScene(e.target.scene);
		end
	end
	
 	localGroup:insert(background);
	localGroup:insert(wrong);
	localGroup:insert(nexts);
	localGroup:insert(back);
	
	back:addEventListener("touch", changeScene);
	nexts:addEventListener("touch", changeScene);

	
	return localGroup;
end
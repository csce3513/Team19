package
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	
	import bit101.AStar;
	import bit101.Grid;
	import bit101.Node;
	
	import caurina.transitions.*;
	
	import com.adobe.viewsource.ViewSource;
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.net.URLRequest;
	
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFF")]


	public class pathfindingtest extends Sprite
	{
		protected var cellSize:int = 50;//size of cubes/squares
		protected var pathGrid:Grid;
		protected var path:Array;
		protected var isoView:IsoView;
		protected var isoScene:IsoScene;
		protected var dude:IsoSprite = new IsoSprite;
		protected var speed:Number = 0.4;
		protected var speed1:Number;
		protected var delay:Number;
		protected var delayfix:Number = 0;;
		protected var speedcheck:Boolean = false;
		protected var _numX:Number = 0;
		protected var _numY:Number = 0;
		protected var targetX:Number;
		protected var targetY:Number;
		protected var dudeDir:String;
		protected var leftRightTempX:Number = 0;
		protected var leftRightTempY:Number = 0;
		                
        private var loaderMario:Loader;
        private var loaderGrass:Loader;
		
		public function pathfindingtest()
		{
			ViewSource.addMenuItem(this, "srcview/index.html");
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			loaderMario = new Loader();
            loaderMario.load(new URLRequest("mario.swf"));
            loaderGrass = new Loader();
            loaderGrass.contentLoaderInfo.addEventListener(Event.INIT,makeGrid);
            loaderGrass.load(new URLRequest("grassSprites.swf"));
            	
            
		}

		protected function makeGrid(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME, render);
			pathGrid = new Grid(10, 10);//makes a 10x10 grid
			for(var i:int = 0; i < 15; i++)
			{
				pathGrid.setWalkable(Math.floor(Math.random() * 8) + 2,
								  Math.floor(Math.random() * 8)+ 2,
								  false);//randomly selects which tiles will be up or down
			}
			drawGrid();
		}
		
		protected function drawGrid():void
		{
			isoScene 		= new IsoScene();
			isoView 		= new IsoView();
			
			isoView.clipContent = false;
			
			var grassClass:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Grass") as Class;
			var grass2Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Grass2") as Class;
			var grass3Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Grass3") as Class;
			var grass4Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Grass4") as Class;
			
			var blockClass:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Block") as Class;
			var block2Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Block2") as Class;
			var block3Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Block3") as Class;
			var block4Class:Class = loaderGrass.contentLoaderInfo.applicationDomain.getDefinition("Block4") as Class;

			for(var i:int = 0; i < pathGrid.numCols; i++)
			{
				for(var j:int = 0; j < pathGrid.numRows; j++)//go through each column, and then each row
				{
					var node:Node = pathGrid.getNode(i, j);//grab the current node (or square) of the grid
					var ground:IsoSprite = new IsoSprite();

					if (node.walkable)//if it was determined that the tile is down, it makes the height 0 and adds an event listener
					{
						var grassPicker:int = Math.random()*4+1;
						if(grassPicker == 1){
							ground.sprites = [grassClass];
						} else if (grassPicker == 2){
							ground.sprites = [grass2Class];
						} else if (grassPicker == 3){
							ground.sprites = [grass3Class];
						} else if (grassPicker == 4){
							ground.sprites = [grass4Class];
						}
						
						ground.addEventListener(MouseEvent.CLICK, onGridItemClick);
					}
					else
					{
						var blockPicker:int = Math.random()*4+1;
						if(grassPicker == 1){
							ground.sprites = [blockClass];
						} else if (grassPicker == 2){
							ground.sprites = [block2Class];
						} else if (grassPicker == 3){
							ground.sprites = [block3Class];
						} else if (grassPicker == 4){
							ground.sprites = [block4Class];
						}						
					}
					ground.moveTo(i * cellSize, j * cellSize, 0);//places the box
					isoScene.addChild(ground);
				}
			}

			
			//Set properties for isoView
			isoView.setSize(stage.stageWidth, stage.stageHeight);
			isoView.showBorder = false;
			dude.isAnimated = true;
			dude.autoUpdate = true;
			
			isoView.autoUpdate = true;
			
			isoScene.addChild(dude);
			
			//Add the isoScene to the isoView
			isoView.addScene(isoScene);
			
			
			//Add the isoView to the stage
			addChild(isoView);
		}

		protected function onGridItemClick(evt:ProxyEvent):void 
		{
			var box:IsoSprite = evt.target as IsoSprite;
			
			//Get and set End Nodes (where are we going)
			var xpos:int = (box.x)/cellSize;
			var ypos:int = Math.floor(box.y / cellSize);//grabs the center of what the player just clicked
			pathGrid.setEndNode(xpos,ypos);

			//Get and set Start Node (where are we now)
			xpos = Math.floor(dude.x / cellSize);
			ypos = Math.floor(dude.y / cellSize);

			pathGrid.setStartNode(xpos, ypos);//grabs the position of the dude
			

			//Find our path
			findPath();
		}

		protected function findPath():void
		{
			var astar:AStar = new AStar();
			
			if(astar.findPath(pathGrid))//if there is a path between the two nodes...
			{
				path = astar.path;//make our path using a waypoint system
			
				for (var i:int = 1; i < path.length; i++)
				{
					//trace(path[i].x+','+path[i].y);
					targetX = path[i].x * cellSize;
					targetY = (path[i].y * cellSize);//for every spot on our waypoint, tween it through every point					
					speedcheck = checkTween(targetX, targetY);
					moveDude(targetX, targetY, i);
					//trace(targetX+','+targetY);
					
				}
				speed1=0;
				delay = 0;
				delayfix = 0;
				speedcheck=null;
			} else {
				//if path is impossible, do something here. add a text message maybe?
			}
			
		}
		
		public function moveDude(targetX:Number, targetY:Number, i:int):void{
				if(i > 1){
					speed1 = speed;
				}
				//trace(speed1);
				if(speedcheck == true){
					speed = 0.65;
					if(speed1 == 0.4){
						delay = speed1;//finds out how much delay is needed from the last instruction
						Tweener.addTween(dude, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear"} );//tween the dude
						Tweener.addTween(isoView, {x:((-targetX+targetY)/2)*2, y:(-targetY-targetX)/2, delay:delay+delayfix , time:speed, transition:"linear" } );//tween the camera
						delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
					} else {
						delay = speed;//finds out how much delay is needed from the current instruction
						Tweener.addTween(dude, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear"} );//tween the dude
						Tweener.addTween(isoView, {x:((-targetX+targetY)/2)*2, y:(-targetY-targetX)/2, delay:delay+delayfix , time:speed, transition:"linear" } );//tween the camera
						delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
					}
				} else if(speedcheck == false) {
					speed = 0.4;
					if(speed1 == 0.65){
						delay = speed1;//finds out how much delay is needed from the last instruction
						Tweener.addTween(dude, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear"} );//tween the dude
						Tweener.addTween(isoView, {x:((-targetX+targetY)/2)*2, y:(-targetY-targetX)/2, delay:delay+delayfix , time:speed, transition:"linear" } ); //tween the camera
						delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
					} else {
						delay = speed;//finds out how much delay is needed from the current instruction
						Tweener.addTween(dude, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear"} );//tween the dude
						Tweener.addTween(isoView, {x:((-targetX+targetY)/2)*2, y:(-targetY-targetX)/2, delay:delay+delayfix , time:speed, transition:"linear" } ); //tween the camera
						delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
					}
					
				}
				//trace(i+': Speed:'+speed+' Delay:'+delayfix);//This trace would find the number of tweens happening at one time and their speeds and delays
		}
		
		//CHECKS IF DUDE IS GOING LEFT OR RIGHT(HE MOVES SLIGHTLY FASTER IN BOTH THOSE DIRECTIONS)
		public function checkTween(leftrightX:Number, leftrightY:Number):Boolean{
			if (leftrightX < leftRightTempX && leftrightY > leftRightTempY) {
						leftRightTempX = leftrightX;
						leftRightTempY = leftrightY;
						//trace("left");
						return true;
			}else if (leftrightX > leftRightTempX && leftrightY < leftRightTempY) {
						leftRightTempX = leftrightX;
						leftRightTempY = leftrightY;
						//trace("right");
						return true;
			} else {
				leftRightTempX = leftrightX;
				leftRightTempY = leftrightY;
				//trace("regular");
				return false;
			}
		}
		
		public function checkDude():void{
			var marioFrontClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioFront") as Class;
			var marioBackLeftClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioBackLeft") as Class;
			var marioBottomRightClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioBottomRight") as Class;
			var marioBackClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioBack") as Class;
			var marioLeftClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioLeft") as Class;
			var marioRightClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioRight") as Class;
			var marioTopRightClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioTopRight") as Class;
			var marioBottomLeftClass:Class = loaderMario.contentLoaderInfo.applicationDomain.getDefinition("MarioBottomLeft") as Class;
			if(_numX == 0 && _numY == 0){
				_numX = dude.x;
				_numY = dude.y;
				if(dude.sprites.toString() != marioFrontClass.toString()){
					dude.sprites = [marioFrontClass];
				}
			}else {
				if (dude.x < _numX) {
					if(dude.y < _numY){
						if(dude.sprites.toString() != marioBackClass.toString()){
							dude.sprites = [marioBackClass];
							dudeDir = "Up";
						}
					} else if(dude.y > _numY){
						if(dude.sprites.toString() != marioLeftClass.toString()){
							dude.sprites = [marioLeftClass];
							dudeDir = "Left";
						}
					}else {
						if(dude.sprites.toString() != marioBackLeftClass.toString()){
				   			dude.sprites = [marioBackLeftClass];
				   			dudeDir = "UpLeft";
				  		}
				 	}
				} else if (dude.x > _numX) {
					if(dude.y < _numY){
						if(dude.sprites.toString() != marioRightClass.toString()){
							dude.sprites = [marioRightClass];
							dudeDir = "Right";
						}
					} else if(dude.y > _numY){
						if(dude.sprites.toString() != marioFrontClass.toString()){
							dude.sprites = [marioFrontClass];
							dudeDir = "Down";
						}
					}else {
						if(dude.sprites.toString() != marioBottomRightClass.toString()){
					    	dude.sprites = [marioBottomRightClass];
					    	dudeDir = "DownRight";
				 		}
				 	}
				} else {
					if(dude.y < _numY){
						if(dude.sprites.toString() != marioTopRightClass.toString()){
							dude.sprites = [marioTopRightClass];
							dudeDir = "UpRight";
						}
					} else if(dude.y > _numY){
						if(dude.sprites.toString() != marioBottomLeftClass.toString()){
							dude.sprites = [marioBottomLeftClass];
							dudeDir = "DownLeft";
						}
					}
				}
				if(dude.x == _numX && dude.y == _numY){
					dude.sprites = [marioFrontClass];//Mario faces forwards when stopped
				}
				_numX = dude.x;
				_numY = dude.y;
			} 
		}
		
		
		protected function render(event:Event = null):void 
		{
			//Render the isoScene
			isoScene.render();
			checkDude();//Checks the sprite for direction change and changes the sprite accordingly			
		}
	}
}
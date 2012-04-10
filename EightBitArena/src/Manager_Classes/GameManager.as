//========================
//GameManager.as
//========================
// - This class runs the gameplay elements, loads all game elements, and draws them all
// - Contains:
//		- Loading graphical assets
//		- Viewport loading (Unimplemented)
// 		- Control schemes (Unimplemented)
//		- Update method to render the scenes at every frame drawing event
package Manager_Classes 
{
	import champfiles.zeek;
	import as3isolib.display.scene.Map
	import champfiles.zeek;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.*;
	import flash.geom.Point;
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.Camera;
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import AllTests;
	import asunit.textui.TestRunner;
	
	

	public class GameManager extends MovieClip 
	{
		
	
		
		
		//------
		//Variables we're Keeping
		//------
		private var activeUnit:PlayerObject;
		public var unitSelected:Boolean;
		public var selectedunit:Array;
		public var movecount:Number;
		public var tempmove:Number = 0;
		
		//------
		//Testing Variables
		//------
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:Map;
		private var champ:PlayerObject; 
		private var champ2:PlayerObject;
		private var champ3:PlayerObject;
		private var box2:TerrainObject;
		private var panPt:Point;
		private var zoom:Number = 1;
		//private var stage:Stage;
		
		//keywords used for unit movement functions.
		private var left:uint = 37;
		private var up:uint = 38;
		private var right:uint = 39;
		private var down:uint = 40;
		private var enter:uint = 13;
		private var camerapanleft:uint = 65;
		private var camerapanright:uint = 68;
		private var camerapanup:uint = 87;
		private var camerapandown:uint =  83;
	
		//Variables for music
		//[Embed(source = 'Music/Laudamus_te_Deum.mp3')]
		//private var mySound:Class;
		//private var lulu:Sound;
		
		public function GameManager(stage:Stage) 
		{
			//Unit Testing Code
			//------
			//var unittests:TestRunner = new TestRunner();
			//stage.addChild(unittests);
			//unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
			//------
			
			
			selectedunit = new Array();
			unitSelected = false;
			trace(unitSelected);
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new Map();
			champ  = new PlayerObject(testMap);
			champ2 = new PlayerObject(testMap);
			champ3 = new PlayerObject(testMap);
			box2 = new TerrainObject(testMap);
			testMap.SetPlayer1Pieces(champ);
			testMap.SetPlayer1Pieces(champ2);
			testMap.SetPlayer1Pieces(champ3);
			//tmanager.reportplayer1pieces();
			
			//Unit Testing Code
			//------
			//var unittests:TestRunner = new TestRunner();
			//stage.addChild(unittests);
			//unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
			//------
			
			addChild(camera);
			gridHolder.addChild(testMap);
			camera.addScene(gridHolder);
			camera.addScene(scene);
			
			//------
			// this is only temporary. character selection function (not yet implimented) will perform this task once it is implimented
			//------
			//Adding a test box for the camera
			champ.moveTo(300, 300, 0);
			champ2.moveTo(100, 100, 0);
			champ3.moveTo(200, 200, 0);
			scene.addChild(champ);
			scene.addChild(champ2);
			scene.addChild(champ3);
			
			//Adding collider
			box2.setSize(50, 50, 50);
			box2.moveTo(500, 150, 0);
			var currentTile:Point = new Point();
			currentTile.x = box2.x;
			currentTile.y = box2.y;
			testMap.tObjCoords(currentTile);
			scene.addChild(box2);
			
			
			champ.addEventListener(MouseEvent.CLICK, boxClick);
			champ2.addEventListener(MouseEvent.CLICK, boxClick);
			champ3.addEventListener(MouseEvent.CLICK, boxClick);
			//camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			
			
		}
		

		private function keyDownListener(e:KeyboardEvent):void  //movement function for active unit
			{			
				if (activeUnit != null)
				{
					
				
			//keycodes
				if (e.keyCode == left)
				{
					
					activeUnit.moveTo(champ.x - 50, champ.y, 0);
					scene.render();
					movecount --;
					trace(movecount);
					moveCheck();
				}
				else if (e.keyCode == right)
				{
					
					activeUnit.moveTo(champ.x + 50, champ.y, 0);
					scene.render();
					movecount --;
					moveCheck();
				}
				else if (e.keyCode == up)
				{
					
					activeUnit.moveTo(champ.x, champ.y - 50, 0);
					scene.render();
					movecount --;
					moveCheck();
				}
				else  if (e.keyCode == down)
				{
					
					activeUnit.moveTo(champ.x, champ.y + 50, 0);
					scene.render();
					movecount --;
					moveCheck();
				}
				else if (e.keyCode == enter)
				{
					activeUnit = null;
					selectedunit.pop();
					unitSelected = false;
					testMap.clearMoves(activeUnit);
					movecount = 0;
					
				}
				else if (e.keyCode == camerapanup)
				{
					
				}
				else if (e.keyCode == camerapandown)
				{
					
				}
				else if (e.keyCode == camerapanright)
				{
					
				}
				else if (e.keyCode == camerapanleft)
				{
					
				}
				}
			
			}
			
		//Camera Control Functions	
		private function viewMouseDown(e:Event):void
		{
			//A point is created wherever you click inside the View. This point will be stored and referenced in the viewPan method.
			panPt = new Point(stage.mouseX, stage.mouseY);
			activeUnit = null;
			camera.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseUp);
		}
		private function viewPan(e:Event):void
		{
			camera.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
		}
		private function viewMouseUp(e:Event):void
		{
			camera.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
		private function viewZoom(e:MouseEvent):void
		{
			if(e.delta > 0)
			{
				zoom +=  0.10;
			}
			if(e.delta < 0)
			{
				zoom -=  0.10;
			}
			camera.currentZoom = zoom;
		}
		private function boxClick(e:Event):void
		{
			
			camera.centerOnIso(e.target as PlayerObject);
			selectedunit.push(e.target);  // store the thing we clicked on in an array so we can reference it
			trace(selectedunit);
			champ = e.target as PlayerObject;
			
			unitSelected = true;
			
			
			activeUnit = selectedunit[0]; // set activeunit = to the thing we clicked on
			selectedunit.pop();
			delete selectedunit[0];
			movecount = activeUnit.getMovement();
			
			
			
			
		}
		
		public function moveCheck():void
		{
			if (movecount == 0)
			{
					activeUnit = null;
					selectedunit.pop();
					unitSelected = false;
					testMap.clearMoves(activeUnit);
			}
			
		}
		
		//Update function: have this function render both scenes on every frame update and remove the render calls in the constructor
		public function Update(): void 
		{
			
			gridHolder.render();
			scene.render();	
			if (unitSelected)
			{
				testMap.showMoves(activeUnit);
			}	
			
			
		}
		
	}

}
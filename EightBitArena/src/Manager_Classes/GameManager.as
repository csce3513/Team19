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
	import adobe.utils.CustomActions;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.primitive.Tile;
	import as3isolib.display.scene.Map;
	import as3isolib.display.scene.TheWoods;
	import champfiles.zeek;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.Point;
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.Camera;
	
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.events.Event;
	import AllTests;
	import asunit.textui.TestRunner;
	import gameMenu
	import flash.events.MouseEvent;
	import as3isolib.events.IsoEvent;
	import HUD;
	
	public class GameManager extends MovieClip 
	{
		//------
		//Variables we're not deleting
		//------
		public var activeUnit:PlayerObject;  // we just use this as a temporary copy for the units we click
		public var tempUnit:PlayerObject; // we just use this as temporary copy for units we mouse-over
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:TheWoods;
		private var champ:zeek; 
		private var panPt:Point;
		private var zoom:Number = 1;
		private var movePT:Point;
		public var menu:gameMenu;
		public var hud:HUD;
		public var teststring:String;
	
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
			teststring = "* ";   // since i can't seem to get the activetarget to report back from the mouse-over listener, used this just so stuff would compile
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new TheWoods(this);
			menu = new gameMenu(this, testMap);
			hud = new HUD(this, testMap);
			champ  = new zeek(testMap, 1, 300, 300);
			//Unit Testing Code
			//------
			//var unittests:TestRunner = new TestRunner();  // don't delete this shit i need it
			//stage.addChild(unittests);
			//unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
			//------
			addChild(camera);
			gridHolder.addChild(testMap);
			camera.addScene(gridHolder);
			camera.addScene(scene);
		
			//putting the champions on the map
			scene.addChild(champ); // 
		
			// add mouse listeners for playerobjects
			champ.addEventListener(MouseEvent.CLICK, champClick);
			champ.addEventListener(MouseEvent.MOUSE_OVER, displayHUD);  // mouse over event listener to display HUD
			champ.addEventListener(MouseEvent.MOUSE_OUT, removeHUD);	// mouse out event to remove HUD
			// end listeners for player objects
			
			// add listeners for stage object
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			//add listeners for camera (hold shift down to use the camera)
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewPan);
			stage.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
			
		//Camera Control Functions	
		private function viewMouseDown(event:MouseEvent):void
		{
			if (event.shiftKey)
			{
			panPt = new Point(stage.mouseX, stage.mouseY);
			camera.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseUp);
			}
		}
		private function viewPan(e:MouseEvent):void
		{
			if (e.shiftKey)
			{
			camera.panBy(panPt.x - stage.mouseX, panPt.y - stage.mouseY);
			panPt.x = stage.mouseX;
			panPt.y = stage.mouseY;
			}
		}
		private function viewMouseUp(e:MouseEvent):void
		{
			if (e.shiftKey)
			{
			camera.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
			}
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
		// end camera control functions
		
		// event listeners for player objects begins here ---------------------------------------------------------------
		private function champClick(a:Event):void   
		{
			if (activeUnit == null)
			{
			addChild(menu);
			camera.centerOnIso(a.target as PlayerObject);
			testMap.clearMoves();	//reset moves incase you change your mind on the champ u wanna click on
			activeUnit = a.target as PlayerObject;
			}
			else if (activeUnit == a.target as PlayerObject)
			{
				testMap.clearMoves();
				activeUnit = null;
				removeChild(menu);
			}
		}
		
		public function sendUnitTo(point:Point):void
		{
			activeUnit.moveTo(point.x, point.y, 0);
			activeUnit = null;
			testMap.clearMoves();
			removeChild(menu);
		}
		
		private function displayHUD(event:Event):void   // can't get the tempunit name to report back to HUD as it should :- /
		{
			tempUnit = event.target as PlayerObject;
			teststring = tempUnit.GetName();
			
			if (tempUnit != null)
			{
			addChild(hud);
			
			}
		}

  
		private function removeHUD(event:Event):void  // removes the HUD when u un-mouse-over a player object
		{
			removeChild(hud);
		}
		//-----------------------------------------------------------------------------------------------------------------
		//Update function: have this function render both scenes on every frame update and remove the render calls in the constructor
		public function Update(): void 
		{
			scene.render();	
			gridHolder.render();
		}
	}
}

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
	import as3isolib.display.scene.Map
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

	public class GameManager extends MovieClip 
	{
		//------
		//Variables we're not deleting
		//------
		private var activeUnit:PlayerObject;  // we just use this as a temporary copy for the units we click
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
		private var movePT:Point;
		
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
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new Map(this);
			box2 = new TerrainObject(testMap, 500, 150);
			champ  = new PlayerObject(testMap, 1, 300, 300);
			champ2 = new PlayerObject(testMap, 1, 100,100);
			champ3 = new PlayerObject(testMap, 1, 200, 200);
		
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
			scene.addChild(champ2); // i think these may need to just go in a for  loop to create a team
			scene.addChild(champ3); // 
			
			//Adding collider
			scene.addChild(box2);
			// add mouse listeners for playerobjects
			champ.addEventListener(MouseEvent.CLICK, champClick);
			champ2.addEventListener(MouseEvent.CLICK, champClick);
			champ3.addEventListener(MouseEvent.CLICK, champClick);
			// end listeners for player objects
			
			// add listeners for stage object
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			//add listeners for camera (hold control down to use the camera)
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, viewPan);
			stage.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
		}
			
		//Camera Control Functions	
		private function viewMouseDown(event:MouseEvent):void
		{
			if (event.shiftKey)
			{
			//A point is created wherever you click inside the View. This point will be stored and referenced in the viewPan method.
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
		
		/*===================Start here, Brett================
		 * Classes that are used here: GameManager.as, Map.as, Pathefinger.as, Path.as
		 * 
		 * Comments that pertain to the logic are preceded by --->
		 * =================================================*/
		
		private function champClick(a:Event):void   
		{
			//If active unit is currently null, then that means it's first time clicking on this unit
			if (activeUnit == null)
			{
				trace("Setting new active unit.");
				// centers the camera on the thing you click on
				camera.centerOnIso(a.target as PlayerObject);
				testMap.clearMoves();	//-------------> This, actually MIGHT be where the problem lies
				//-----> Since the functions all work on the first try, we have to look at what's changed between the first run and the second run
				//-----> This resets the availableTiles and the paths arrays to 0
				
				activeUnit = a.target as PlayerObject;
				testMap.showMoves(activeUnit); // --------> Here's where it begins. Everytime a new unit is activated, we calculate all tiles, and all paths
			}
			else if (activeUnit ==  a.target as PlayerObject)
			{
				trace("Clearing active unit");
				testMap.clearMoves();
				activeUnit = null;
			}	
		}
		
		public function sendUnitTo(point:Point):void
		{
			activeUnit.moveTo(point.x, point.y, 0);
			activeUnit = null;
			testMap.clearMoves();
		}
		
		//Update function: have this function render both scenes on every frame update and remove the render calls in the constructor
		public function Update(): void 
		{
			scene.render();	
			gridHolder.render();
		}
	}
}

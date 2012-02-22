//==================================================
//8-Bit Arena
//==================================================
//A Mobile application project by:
//	Brett Gregory
//	Annabelle Young
//	Christopher Atwood
//	Michael Montgomery
//
//A Project for Software Engineering (CSCE 3513)
//==================================================


//========================
//EightBitArena.as
//========================
// - The main class of the application
// - Contains:
//		- GameStateManager (Unimplemented)
//		- Viewport loading (Unimplemented)
// 		- Control schemes (Unimplemented)
//		- Other features not yet added 

package  
{
	import as3isolib.display.scene.Map;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.Camera;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import Manager_Classes.TileManager;
 
	public class EightBitArena extends MovieClip 
	{
		private var tileManager:TileManager;
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:Map;
		private var box:GameObject; 
		private var box2:GameObject;
		private var panPt:Point;
		private var zoom:Number = 1;
		
		//keywords used for unit movement functions.
		private var left:uint = 37;
		private var up:uint = 38;
		private var right:uint = 39;
		private var down:uint = 40;
		
		//Constructor
		public function EightBitArena() 
		{
			tileManager = new TileManager();
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			gridHolder = new IsoScene();
			scene  = new IsoScene();
			testMap = new Map();
			box  = new GameObject(tileManager);
			box2 = new GameObject(tileManager);
			
			addChild(camera);
			camera.addScene(gridHolder);
			camera.addScene(scene);
			gridHolder.addChild(testMap);
			
			//add gameobjects to the tile manager array holders.
			//------
			// this is only temporary. character selection function (not yet implimented) will perform this task once it is implimented
			//------
			tileManager.SetPlayer1Pieces(box);
			tileManager.SetPlayer2Pieces(box);
			
			//Adding a test box for the camera
			box.setSize(50, 50, 50);
			box.moveTo(300,150, 0);
			scene.addChild(box);
			
			//Adding collider
			box2.moveTo(500, 150, 0);
			var currentTile:Point = new Point();
			currentTile.x = box2.x;
			currentTile.y = box2.y;
			box2.setSize(50, 50, 50);
			tileManager.tObjCoords(currentTile);
			scene.addChild(box2);
			
			gridHolder.render();
			scene.render();
			
			box.addEventListener(MouseEvent.CLICK, boxClick);
			camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
		}
		private function keyDownListener(e:KeyboardEvent):void
			{
				//keycodes
				if (e.keyCode == left)
				{
					box.moveTo(box.x - 50, box.y, 0);
					scene.render();
				}
				else if (e.keyCode == right)
				{
					box.moveTo(box.x + 50, box.y, 0);
					scene.render();
				}
				else if (e.keyCode == up)
				{
					box.moveTo(box.x, box.y - 50, 0);
					scene.render();
				}
				else  if (e.keyCode == down)
				{
					box.moveTo(box.x, box.y + 50, 0);
					scene.render();
				}
			}
			
		//Camera Control Functions	
		private function viewMouseDown(e:Event):void
		{
			//A point is created wherever you click inside the View. This point will be stored and referenced in the viewPan method.
			panPt = new Point(stage.mouseX, stage.mouseY);
			
			camera.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
			camera.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
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
			camera.centerOnIso(e.target as GameObject);
			
		}
	}
}
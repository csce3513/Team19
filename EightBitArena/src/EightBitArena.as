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
		private var panPt:Point;
		private var zoom:Number = 1;
		
		//Constructor
		public function EightBitArena() 
		{
			tileManager = new TileManager();
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			gridHolder = new IsoScene();
			scene  = new IsoScene();
			testMap = new Map();
			box  = new GameObject(tileManager);
			
			addChild(camera);
			camera.addScene(gridHolder);
			camera.addScene(scene);
			gridHolder.addChild(testMap);
			
			//Adding a test box for the camera
			box.setSize(50, 50, 50);
			box.moveTo(50, 50, 0);
			scene.addChild(box);
			
			gridHolder.render();
			scene.render();
			
			box.addEventListener(MouseEvent.CLICK, boxClick);
			camera.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownListener);
		}
	
		
		
			public function keyDownListener(e:KeyboardEvent):void {
				//keycodes
			var left:uint = 37;
			var up:uint = 38;
			var right:uint = 39;
			var down:uint = 40;
			
			if (e.keyCode == left)
			{
			box.moveTo(100,150,0);
			}
			/*
			if (e.keyCode==up){
			ship.y-=10;
			ship.rotation = 180;
			}
			if (e.keyCode==right){
			ship.x+=10;
			ship.rotation = 270;
			}
			if (e.keyCode==down){
			ship.y+=10;
			ship.rotation = 0;
			}
			
			}
			*/
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
			box.moveTo(100,150,0);
			//camera.centerOnIso(e.target as GameObject);
		}
	}
}
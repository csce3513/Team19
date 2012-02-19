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
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.Camera;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
 
	public class EightBitArena extends MovieClip 
	{
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:Map;
		private var box:IsoBox; 
		private var panPt:Point;
		private var zoom:Number = 1;
		
		//Constructor
		public function EightBitArena() 
		{
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			gridHolder = new IsoScene();
			scene  = new IsoScene();
			testMap = new Map();
			box  = new IsoBox();
			
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
			camera.centerOnIso(e.target as IsoBox);
		}
	}
}
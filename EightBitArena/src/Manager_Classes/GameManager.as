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
	import as3isolib.display.scene.Map
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.geom.Point;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.Camera;
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	

	public class GameManager extends MovieClip 
	{
		private var camera:Camera; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:Map;
		private var box:GameObject; 
		private var box2:TerrainObject;
		private var panPt:Point;
		private var zoom:Number = 1;
		//private var stage:Stage;
		
		//keywords used for unit movement functions.
		private var left:uint = 37;
		private var up:uint = 38;
		private var right:uint = 39;
		private var down:uint = 40;
		
		//variable used for hero sprite
		//[Embed(source='Images/34SDb.png')]
		//private var Champion:Class;
		//private var hero:Bitmap = new Champion();
		
		//Variables for music
		//[Embed(source = 'Music/Laudamus_te_Deum.mp3')]
		//private var mySound:Class;
		//private var lulu:Sound;
		
		public function GameManager(stage:Stage) 
		{
			camera = new Camera(stage.stageWidth,stage.stageHeight);
			scene  = new IsoScene();
			gridHolder = new IsoScene();
			testMap = new Map();
			box  = new GameObject(testMap);
			box2 = new TerrainObject(testMap);
			
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
			box.setSize(50, 50, 50);
			box.moveTo(300,150, 0);
			scene.addChild(box);
			
			//Adding collider
			box2.moveTo(500, 150, 0);
			var currentTile:Point = new Point();
			currentTile.x = box2.x;
			currentTile.y = box2.y;
			box2.setSize(50, 50, 50);
			testMap.tObjCoords(currentTile);
			scene.addChild(box2);
			
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
		
		//Update function: have this function render both scenes on every frame update and remove the render calls in the constructor
		public function Update(): void 
		{
			gridHolder.render();
			scene.render();	
		}
		
	}

}
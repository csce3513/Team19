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
	import flash.events.Event;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
 
	public class EightBitArena extends MovieClip 
	{
		private var view:IsoView; 
		private var gridHolder:IsoScene; 
		private var scene:IsoScene;
		private var testMap:Map;
		//private var box:IsoBox; 
		
		public function EightBitArena() 
		{
			view = new IsoView();
			gridHolder = new IsoScene();
			scene  = new IsoScene();
			testMap = new Map();
			//box  = new IsoBox();
			
			view.setSize((stage.stageWidth), stage.stageHeight);
			view.clipContent = true;
			addChild(view);
			view.addScene(gridHolder);
			view.addScene(scene);
			gridHolder.addChild(testMap);
			//box.setSize(50, 50, 50);
			//box.moveTo(50, 50, 0);
			//scene.addChild(box);
			gridHolder.render();
			scene.render();
		}
	}
}
package champfiles 
{
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.scene.Map;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import Manager_Classes.GameManager;
	import flash.events.Event;
	import flash.events.*;
	import as3isolib.display.Camera;
	import as3isolib.display.primitive.Tile
	import flash.display.Stage;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import flash.display.Sprite;

	public class bunneh extends PlayerObject
	{
		
		[Embed(source='/Images/Bunny.png')]
		private var Champion:Class;
		private var bun:Bitmap = new Champion();
		public function bunneh(testMap:Map,playerNum:Number, x:Number, y:Number) 
		{	
			super(testMap,playerNum,x,y);
			setSize(50, 50, 50);
			sprites = [bun];
			map = testMap;
			center(bun);
			this.playerNum = playerNum;
			moveTo(x, y, 0);
			this.SetName("Bunny");
			this.setHealth(75);
			this.setCurrentHealth(75);
			this.setDamage(30);
			this.setMovement(8);
			this.setRange(6);
		}
	}

}
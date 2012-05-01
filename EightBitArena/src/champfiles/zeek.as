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

	public class zeek extends PlayerObject
	{
		
		[Embed(source='/Images/34SDb.png')]
		private var Champion:Class;
		private var zee:Bitmap = new Champion();
		public function zeek(testMap:Map,playerNum:Number, x:Number, y:Number) 
		{	
			super(testMap,playerNum,x,y);
			setSize(50, 50, 50);
			sprites = [zee];
			map = testMap;
			center(zee);
			this.playerNum = playerNum;
			moveTo(x, y, 0);
			this.SetName("Zeek");
			this.setHealth(100);
			this.setCurrentHealth(100);
			this.setDamage(30);
			this.setMovement(6);
			this.setRange(1);
			specialType = "move";
			specialRange = 25;
			specialCD = 5;
			specialCDMax = 5;
		}
		
		
	}

}


package  champfiles
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

	public class zora extends PlayerObject
	{
		//Image found at http://www.zfgc.com/forum/index.php?topic=29800.msg331651#msg331651 by user Desgardes
		[Embed(source='/Images/Zora.png')]
		private var Champion:Class;
		private var fish:Bitmap = new Champion();
		public function zora(testMap:Map,playerNum:Number, x:Number, y:Number) 
		{	
			super(testMap,playerNum,x,y);
			setSize(50, 50, 50);
			sprites = [fish];
			map = testMap;
			center(fish);
			this.playerNum = playerNum;
			moveTo(x, y, 0);
			this.SetName("Zora");
			this.setHealth(150);
			this.setCurrentHealth(150);
			this.setDamage(25);
			this.setMovement(5);
			this.setRange(2);
		}
	}


}
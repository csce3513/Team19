package  
{
	import as3isolib.display.primitive.GameObject;
    import as3isolib.display.scene.IsoScene;
	import as3isolib.display.IsoSprite;
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	
	public class TerrainObject extends GameObject
	{
		//variables used for sprites
		[Embed(source='Images/fluttershy.gif')]
		private var pegasus:Class;
		private var pony:Bitmap = new pegasus ();
	
		public function TerrainObject(testMap:Map, x:Number, y:Number ) 
		{
			super();
			sprites = [pony];
			map = testMap;
			center(pony);
			setSize(50, 50, 50);
			moveTo(x, y, 0);
		}
		public override function moveTo(x:Number, y:Number, z:Number):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
			currentTile.x = this.x;
			currentTile.y = this.y;
			map.tObjCoords(currentTile);
			
		}
	}
}
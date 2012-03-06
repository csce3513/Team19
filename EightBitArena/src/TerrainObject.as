package  
{
	import as3isolib.display.primitive.GameObject;
    import as3isolib.display.scene.IsoScene;
	import as3isolib.display.IsoSprite;
	import flash.geom.Point;
	import Manager_Classes.TileManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	
	public class TerrainObject extends GameObject
	{
		//variables used for sprites
		[Embed(source='Images/fluttershy.gif')]
		private var pegasus:Class;
		private var pony:Bitmap = new pegasus ();
	
		public function TerrainObject(tile_Manager:TileManager) 
		{
			super(tile_Manager);
			
			tile_Manager.tObjCoords(super.currentTile);
			sprites = [pony];
		}

		
	}

}
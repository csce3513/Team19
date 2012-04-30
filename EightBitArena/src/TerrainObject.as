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
		[Embed(source = 'Images/tree1.png')]private var tree1:Class;
		[Embed(source = 'Images/tree2.png')]private var tree2:Class;
		[Embed(source = 'Images/water.png')]private var water:Class;
		private var img:Bitmap;
		
		public function TerrainObject(testMap:Map, x:Number, y:Number, imgName:String) 
		{
			super();
			map = testMap;
			setSize(50, 50, 50);
			moveTo(x, y, 0);
			
			switch(imgName)
			{
				case "tree1":
					img = new tree1();
					break;
				case "tree2":
					img = new tree2();
					break;
				case "water":
					img = new water();
					break;
			}
			sprites = [img];
			center(img);
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
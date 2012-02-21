//========================
//GameObject.as
//========================
// - The Parent class for all objects that will be rendered on the playing field
// - Contains:
//		- Collision Detection
// 		- Sprite information

package as3isolib.display.primitive 
{
	import flash.geom.Point;
	import Manager_Classes.TileManager;
	
	public class GameObject  extends IsoBox
	{
		private var currentTile:Point;
		private var tileManager:TileManager;
		
		public function GameObject(tile_Manager:TileManager) 
		{
			currentTile = new Point();
			currentTile.x = this.x;
			currentTile.y = this.y;
			
			tileManager = tile_Manager;
		}
		
		public override function moveTo(x:Number, y:Number, z:Number ):void
		{
			var desiredTile:Point = new Point();
			desiredTile.x = x;
			desiredTile.y = y;
			if (!tileManager.checkCollision(desiredTile))
			{
				this.x = x;
				this.y = y;
				this.z = z;
				currentTile.x = this.x;
				currentTile.y = this.y;
			}
		}
	}
}
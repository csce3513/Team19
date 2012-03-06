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
	import as3isolib.display.IsoSprite;
	
	public class GameObject  extends IsoSprite
	{
		protected var currentTile:Point;
		private var tileManager:TileManager;
		private var activeunit:Boolean;             // each game object has a boolean parameter for being the active unit
		
		public function GameObject(tile_Manager:TileManager) 
		{
			currentTile = new Point();
			currentTile.x = this.x;
			currentTile.y = this.y;
			activeunit = false;					// set to false by default.
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
		
		public function SetActiveUnit():void
		{
			activeunit = true;
		}
		public function RemoveActiveUnit():void 
		{
			activeunit = false;
		}
	}
}
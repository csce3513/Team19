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
		
		public function GameObject(tileManager:TileManager) 
		{
			currentTile = new Point();
			currentTile.x = this.x;
			currentTile.y = this.y;
			
			tileManager.tObjCoords(currentTile);
		}
	}
}
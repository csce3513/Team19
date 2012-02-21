//========================
//TileManager.as
//========================
// - Class to manage collision detections
// - Contains:
//		- Array that stores the coordinates for player1 champions (Unimplemented)
//		- Array that stores the coordinates for player2 champions (Unimplemented)
// 		- Array that  stores the coordinates for terrain objects (Unimplemented)
//		- Getters to maintain updates on coordinates

package Manager_Classes
{
	import flash.geom.Point;
	
	public class TileManager 
	{
		private var player1Obj:Array;
		private var player2Obj:Array;
		public var terrainObj:Array;
		public var terrainOb:Point;
		public function TileManager() 
		{
			terrainObj = new Array();
		}
		
		//public function  set p1ObjCoords():void
		//{
		
		//}
		//public function  set p2ObjCoords():void
		//{
			
		//}
		public function  tObjCoords(pnt:Point):void
		{
			terrainObj.push(pnt);
			//terrainOb = pnt;
		}
		
		public function checkCollision(desiredTile:Point):Boolean
		{
			if (terrainObj.length > 0)
			{
				for (var i:Number = 0; i < terrainObj.length; i++)
				{
					if ((desiredTile.x == terrainObj[i].x) && (desiredTile.y == terrainObj[i].y))
						return true;
				}
			}
			return false;
		}
	}

}
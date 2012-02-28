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
	import as3isolib.display.primitive.GameObject;
	import flash.geom.Point;
	
	
	
	public class TileManager 
	{
		//arrays to hold game pieces for quick reference
		private var maxsize:Number = 5 ;
		
		private var player1Obj:Array;
		private var player2Obj:Array;
		public var terrainObj:Array;
		
		public var terrainOb:Point;
		
		// ---------------------------------CONSTRUCTOR
		public function TileManager() 
		{
			
			
			terrainObj = new Array();
			player1Obj = new Array();
			player2Obj = new Array();
		}
		//----------------------------------------------
		
		
		//----------------------------------------------------------------------------
		//Setters for putting pieces in the arrays for each player
		//     these need to be run in the main file in for loops with 5 run-throughs.
		//-----------------------------------------------------------------------------
		public function SetPlayer1Pieces(gameobject:GameObject):void
		{
			player1Obj.push(gameobject);
		}
		
		public function SetPlayer2Pieces(gameobject:GameObject):void
		{
			player2Obj.push(gameobject);
		}
		//------------------------------------------------- end setting functions
		
		//-------------------------------------------------------
		// getters for getting the game pieces out of the arrays
		// these should also be run in 5 run-though for loops
		//-------------------------------------------------------
		public function GetPlayer1Pieces():GameObject
		{
			return player1Obj.pop();
			
		}
		
		public function GetPlayer2Pieces():GameObject
		{
			
			return player2Obj.pop();
			
			
		}
		//--------------------------------------------------- end getter functions
		
		//----------------------------------
		// x/y position scanner functions.
		// this is used to scan all of the pieces
		// to help the mouse listener find a unit in the
		// unit selection process.
		//----------------------------------
		public function scanPlayer1Pieces(desiredTile:Point):void
		{
			var i:int;
			for (i = 0; i < (player1Obj.length); i++)
			{
				if (   (player1Obj[i].x == desiredTile.x) && (player1Obj[i].y == desiredTile.y)   )  
				{
					//if the mouse:x and mouse:y point brought into the function match
					//any x/y points of player 1's pieces, set that piece to the active unit.
					player1Obj[i].setActiveUnit();
				}
			}
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
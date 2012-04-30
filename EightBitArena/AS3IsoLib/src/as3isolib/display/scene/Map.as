//========================
//Map.as
//========================
// - The Parent class for the individual maps/gameboards 
// - Contains:
//		- Grid size
//		- Viewport bounds (Unimplemented)
// 		- Team formation bounds (Unimplemented)
//		- Configuration for each gameplay map (Unimplemented)
//		- Collision Detection
//		- Tile creation and Management

package as3isolib.display.scene
{
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.graphics.BitmapFill;
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import as3isolib.display.primitive.Tile;
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	import flash.events.*;
	import Manager_Classes.GameManager;
	import as3isolib.graphics.BitmapFill;
	
	
	public class Map extends IsoGrid
	{
		//arrays to hold game pieces for quick reference
		protected var maxsize:Number = 5 ;  // max number of playerobjects for each player
		protected var player1Obj:Array; // stores player1's pieces
		protected var player2Obj:Array; // stores player2's pieces
		public var terrainObj:Array;  // stores terrain objects
		public var tilesArray:Array;  // stores all the tile objects
		protected var gameManager:GameManager;
		public var tileChoice:Tile;   // tile chosen from mouse event click
		protected var baseColor:SolidColorFill;
	
		//------
		//Containers for all possible moves for each champion
		//------
		public var activeTiles:Array; // stores all the currently active tiles.   we need to know which ones are active for movement
		public var possibleMoves:Array;
		
		// ---------------------------------CONSTRUCTOR
		public function Map(gameManager:GameManager) 
		{
			//solidColors = [0xD15415, 0xFF6600, 0xFFCC00, 0x66FF00, 0xFF6699, 0x6699FF, 0x99FF00, 0xFF0066];
			cellSize = 50;
			showOrigin = false;
			terrainObj = new Array();
			player1Obj = new Array();
			player2Obj = new Array();
			tilesArray = new Array();
			possibleMoves = new Array();
			
			this.gameManager = gameManager;
		}
		//----------------------------------------------
		
	//setters for the playerobject arrays
		public function SetPlayer1Pieces(playerobject:PlayerObject):void
		{
			//player1Obj.push(playerobject);
		}
		
		public function SetPlayer2Pieces(playerobject:PlayerObject):void
		{
			//player2Obj.push(playerobject);
		}
		public function setTerrainPieces(playerobject:PlayerObject):void
		{
			//terrainObj.push(playerobject);
		}
		//------------------------------------------------- end setting functions
		
	//getters for the playerobject arrays
		public function GetPlayer1Pieces():PlayerObject
		{
			return player1Obj.pop();
		}
		
		public function GetPlayer2Pieces():PlayerObject
		{
			return player2Obj.pop();	
		}
		public function reportplayer1pieces():void    // used for testing. just reports back objects in the array
		{
			trace(player1Obj);
		}
		public function reportplayer2pieces():void
		{
			trace(player2Obj);
		}
		//--------------------------------------------------- end getter functions
		
		//-----------------------------
		// i didnt delete these just yet bc i figured it might be useful with aoe moves and heals
		public function scanPlayer1Pieces(desiredTile:Point):Boolean
		{
			var i:int;
			for (i = 0; i < (player1Obj.length); i++)
			{
				if (   (player1Obj[i].x == desiredTile.x) && (player1Obj[i].y == desiredTile.y)   )  
				{
					return true;
				}
				else
				return false;
			}
			return false;
		}
		public function scanPlayer2Pieces(desiredTile:Point):Boolean
		{
			var i:int;
			for (i = 0; i < player2Obj.length; i++)
			{
				if(  (player2Obj[i].x == desiredTile.x) && (player2Obj[i].y == desiredTile.y)   )  
				{
					return true
				}
				else
				return false;
			}
			return false;
		}
		//----------------------------
		
		//Collision Detection Functions
		public function checkCollision(desiredTile:Point):Boolean
		{
			if (terrainObj.length > 0)
			{
				for (var i:Number = 0; i < terrainObj.length; i++)
				{
					if ((desiredTile.x == terrainObj[i].x) && (desiredTile.y == terrainObj[i].y))
					{
						return true;
					}
				}
			}
			if (player1Obj.length > 0)
			{
				for (var k:Number = 0; k < player1Obj.length; k++)
				{
					if ((desiredTile.x == player1Obj[k].x) && (desiredTile.y == player1Obj[k].y))
					{
						return true;
					}
				}
			}
			if (player2Obj.length > 0)
			{
				for (var p:Number = 0; p < player2Obj.length; k++)
				{
					if ((desiredTile.x == player2Obj[p].x) && (desiredTile.y == player2Obj[p].y))
					{
						return true;
					}
				}
				
			}
			if ((desiredTile.x > 700) || (desiredTile.x < 0))  // make sure you can't move champs out of the grid
				return true;
			if ((desiredTile.y > 700) || (desiredTile.y < 0))  // make sure you can't move champs out of the grid
				return true;
			
			return false;
		}
		
		public function  tObjCoords(pnt:Point):void
		{
			terrainObj.push(pnt);
		}
		
		public function  p1ObjCoords(currPnt:Point, newPnt:Point):void
		{
			if (player1Obj.length > 0)
			{
				for (var i:Number = 0; i < player1Obj.length; i++)
				{
					if ((player1Obj[i].x == currPnt.x) && (player1Obj[i].y == currPnt.y))
						player1Obj.splice(i, 1);
				}
			}
			player1Obj.push(newPnt);
		}
		
		public function  p2ObjCoords(currPnt:Point, newPnt:Point):void
		{
			for (var i:Number = 0; i < player2Obj.length; i++)
			{
				if ((player2Obj[i].x == currPnt.x) && (player2Obj[i].y == currPnt.y))
					player2Obj.splice(i, 1);
			}
			
			player2Obj.push(newPnt);
		}
		
		//------
		//Movement Functions
		//------
		public function calculateMoves(activeUnit:PlayerObject):void
		{
			var movement:Number = activeUnit.getMovement();
			var currentTile:Point = new Point(activeUnit.x, activeUnit.y);
			var increment:Number = 50;
			var count:Number = 1;
			for (var j:Number = 0; j < movement; j++)
			{
				increment *= count;
				for (var i:Number = 0; i < tilesArray.length; i++)
				{
					if ((tilesArray[i].x == currentTile.x - increment) && (tilesArray[i].y == currentTile.y))
						possibleMoves.push(tilesArray[i]);
					else if ((tilesArray[i].x == currentTile.x + increment)&& (tilesArray[i].y == currentTile.y))
						possibleMoves.push(tilesArray[i]);
					else if ((tilesArray[i].y == currentTile.y + increment)&& (tilesArray[i].x == currentTile.x))
						possibleMoves.push(tilesArray[i]);
					else if ((tilesArray[i].y == currentTile.y - increment)&& (tilesArray[i].x == currentTile.x))
						possibleMoves.push(tilesArray[i]);
				}
				count++;
				increment = 50;
			}
			
			if (movement > 1)
			{
				increment *= movement;
				increment -= 50;
				var incrementX:Number = increment;
				var incrementY:Number = 50;
				var countY:Number = 50;
				while (incrementX > 0)
				{
					while (incrementY <=  countY)
					{
							for (var k:Number = 0; k < tilesArray.length; k++)
							{
								if ((tilesArray[k].x == currentTile.x - incrementX) && (tilesArray[k].y == currentTile.y - incrementY)) 
									possibleMoves.push(tilesArray[k]);
								else if ((tilesArray[k].x == currentTile.x + incrementX)&& (tilesArray[k].y == currentTile.y + incrementY))
									possibleMoves.push(tilesArray[k]);
								else if ((tilesArray[k].y == currentTile.y + incrementX)&& (tilesArray[k].x == currentTile.x - incrementY))
									possibleMoves.push(tilesArray[k]);
								else if ((tilesArray[k].y == currentTile.y - incrementX)&& (tilesArray[k].x == currentTile.x + incrementY))
									possibleMoves.push(tilesArray[k]);	
							}
						incrementY += 50;
					}
					incrementX -= 50;
					countY += 50;
					incrementY = 50;
				}
			}
			//Now we remove occupied tiles from the list
			for (var a:Number = 0; a < possibleMoves.length; a++)
			{
				for (var b:Number = 0; b < terrainObj.length; b++)
				{
					if ((possibleMoves[a].x == terrainObj[b].x) && (possibleMoves[a].y == terrainObj[b].y))
						possibleMoves.splice(a, 1);
				}
				for (var c:Number = 0; c < player1Obj.length; c++)
				{
					if ((possibleMoves[a].x == player1Obj[c].x) && (possibleMoves[a].y == player1Obj[c].y))
						possibleMoves.splice(a, 1);
				}
				for (var d:Number = 0; d < player2Obj.length; d++)
				{
					if ((possibleMoves[a].x == player2Obj[d].x) && (possibleMoves[a].y == player2Obj[d].y))
						possibleMoves.splice(a, 1);
				}
			}
		}
		
		public function showMoves(activeUnit:PlayerObject):void
		{
			if (possibleMoves.length == 0)
				calculateMoves(activeUnit);
				
			for (var i:Number = 0; i < possibleMoves.length; i++)
			{
				possibleMoves[i].setTileActive();
			}
		}
		
		public function clearMoves():void
		{
			for (var i:Number = 0; i < possibleMoves.length; i++)
			{
				possibleMoves[i].setTileInactive();
			}
			
			for (var l:Number = 0; l <= possibleMoves.length; l++)
			{
				delete possibleMoves[0]; 
				
			}
			possibleMoves.length = 0;
		}
		
		//The tile the player wants to move to is sent to this function
		public function tileToMoveTo(point:Point):void
		{
			gameManager.sendUnitTo(point);
			clearMoves();
		}
	}

}
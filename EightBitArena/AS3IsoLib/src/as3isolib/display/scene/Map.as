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
	import as3isolib.display.primitive.Tile
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	import flash.events.*;
	import Manager_Classes.GameManager;
	import Manager_Classes.Pathfinder;
	import Manager_Classes.Path;
	
	
	public class Map extends IsoGrid
	{
		//arrays to hold game pieces for quick reference
		private var maxsize:Number = 5 ;  // max number of playerobjects for each player
		private var player1Obj:Array; // stores player1's pieces
		private var player2Obj:Array; // stores player2's pieces
		public var terrainObj:Array;  // stores terrain objects
		public var tilesArray:Array;  // stores all the tile objects
		private var gameManager:GameManager;
		public var tileChoice:Tile;   // tile chosen from mouse event click
		private var baseColor:SolidColorFill;
		public var startingTile:Point;   // tile chosen from mouse event click
		private var pathFinder:Pathfinder;
	
		//------
		//Containers for all possible moves for each champion
		//------
		public var activeTiles:Array; // stores all the currently active tiles.   we need to know which ones are active for movement
		public var possibleMoves:Array;//Stores the tiles that a unit can move into
		public var paths:Array;
		
		// ---------------------------------CONSTRUCTOR
		public function Map(gameManager:GameManager) 
		{
			//solidColors = [0xD15415, 0xFF6600, 0xFFCC00, 0x66FF00, 0xFF6699, 0x6699FF, 0x99FF00, 0xFF0066];
			setGridSize(15, 15, 0);
			cellSize = 50;
			showOrigin = false;
			terrainObj = new Array();
			player1Obj = new Array();
			player2Obj = new Array();
			tilesArray = new Array();
			possibleMoves = new Array();
			paths = new Array();
			this.gameManager = gameManager;
			
			var increment:Number = 50;
			var row:Number = 0;
			var column:Number = 0;
			var count:Number = 0;
			
			for (var i:Number = 0; i < gridSize[1]; i++)  // creates all the stupid tiles and does stuff
			{
			
				for (var j:Number = 0; j < gridSize[0]; j++)
				{
					tilesArray.push(new Tile(row, column, this));
					addChild(tilesArray[count]);
					row += increment;
					count++;	
				}
				row = 0;
				column += increment;
			}
			pathFinder = new Pathfinder();
		}
		//----------------------------------------------
		
	//getters for the playerobject arrays
		public function GetPlayer1Pieces():Array
		{
			return player1Obj;
		}
		
		public function GetTerrainPieces():Array
		{
			return terrainObj;
		}
		
		public function GetPlayer2Pieces():Array
		{
			return player2Obj;	
		}
		public function getPath(pnt:Point):Array
		{
			for (var i:Number = 0; i < possibleMoves.length; i++)
			{
				var temp:Array = new Array;
				if ((possibleMoves[i].x == pnt.x) && (possibleMoves[i].y == pnt.y))
				{
					temp = paths[i].getPath();
					return temp;
				}
			}
			return null;
		}
		//--------------------------------------------------- end getter functions
		
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
		
		public function calculateMoves(activeUnit:PlayerObject):void
		{
			var movement:Number = activeUnit.getMovement();
			var currentTile:Point = new Point(activeUnit.x, activeUnit.y);
			startingTile = currentTile; 
			var increment:Number = 50;
			var count:Number = 1;
			
			//<----------- Important note, possibleMoves array stores TILES, not Points
			//<----------- All of the following logic is okay, I've already tested turning possibleMoves into storing Points instead of Tiles, and it still was broken
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
			
			//<---------------- Here's the entry point for the pathfinder, where the broken code is
			possibleMoves = pathFinder.findPossibleMoves(possibleMoves, currentTile, movement);
			paths = pathFinder.getPaths();
		}
		
		public function showMoves(activeUnit:PlayerObject):void
		{
			if (possibleMoves.length == 0) //<-------- If the length is 0, then we need to recalculate all moves and all paths
				calculateMoves(activeUnit);
				
			for (var i:Number = 0; i < possibleMoves.length; i++)
				possibleMoves[i].setTileActive(); //<---------------- If it's already calculated, then we just need to highlight the tiles
		}
		
		public function clearMoves():void
		{
			startingTile = null;
			for (var i:Number = 0; i < possibleMoves.length; i++)
				possibleMoves[i].setTileInactive();
			
			possibleMoves.length = 0;
			pathFinder.resetPathfinder();
		}
		
	//The tile the player wants to move to is sent to this function
		public function tileToMoveTo(point:Point):void
		{
			gameManager.sendUnitTo(point);
			clearMoves();
		}
	}
}
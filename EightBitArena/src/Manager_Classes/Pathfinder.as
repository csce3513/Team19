//========================
//Pathfinder.as
//========================
// - This class is used by Map.as to find a path for a unit to take from a starting tile to an ending tile
// - Contains:
//		- Finding fastest path
//		- Finding a path of tiles around an obstruction

package Manager_Classes 
{
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import Manager_Classes.Path;
	
	public class Pathfinder 
	{
		//private var map:Map;
		private var paths:Array;
		private var availableTiles:Array;
		private var currentTile:Point;
		
		public function Pathfinder() 
		{
			//this.map = map;
			availableTiles = new Array();
			paths = new Array();
		}
		
		public function findPossibleMoves(possibleMoves:Array,currentTile:Point, moves:Number):Array
		{
			this.currentTile = currentTile;//<---- It's important to set the current tile so we can keep track of where the path is currently, this doesn't actually move anything
			findPaths(possibleMoves, currentTile, moves);//<---- Now we call findPaths to find all paths to all tiles available
			return availableTiles;//<--- We return available tiles, because this trims out all tiles that won't be accessible within the moves number's range
		}
		
		private function findPaths(possibleMoves:Array, beginPnt:Point, moves:Number):void 
		{
			for (var i:Number = 0; i < possibleMoves.length; i++) //<---------- We have to execute findPathToTile for every tile that's within the movement radius
			{
				currentTile = beginPnt;//<-------- Before finding a path to the next tile in the array, we have to reset current tile to the starting position of the unit
				var endPnt:Point = new Point(possibleMoves[i].x, possibleMoves[i].y);//<---------- This point is the destination tile, and it cycles through every tile in the array
				var temp:Path = findPathToTile(possibleMoves, endPnt, moves);//<---------- Paths are a new data type I made in order to make up for not having 2 dimensional arrays
				//<------ Paths are basically arrays of points. So what we now have is an array consisting of arrays of points that represent tile paths
				//<------ So what findPathToTile returns is an array holding a set of points that it would take to reach endPnt
				if (temp != null)//<---------- If the algorithm can't reach endPnt tile within moves number of moves, then we return null, and that tile doesn't get used
				{
					availableTiles.push(possibleMoves[i]);//<---- If the endPnt WAS reached within the appropriate number of moves, we add that tile to available tiles
					paths.push(temp);//<----- Then we add the path to the array of paths
					//<--------- The important note here is that the index of the tile SHOULD ALWAYS BE THE SAME as the index of the path that leads to it. That's vital.
				}
			}
		}
		
		//This is the function that contains the pathfinding algorithm 
		private function findPathToTile(possibleMoves:Array, endPnt:Point, moves:Number):Path
		{	
			var path:Path = new Path(); //<--- This will be the path that we return if the tile is reached within moves
			
			//Array to store the currently movable tiles
			var moveableTiles:Array = new Array(); //<---- We iterate until we reach the endPnt , or we run out of moves
			//<--- And each movement will only have AT MOST 4 tiles that we can move to, up (y -50), right (x + 50), down (y+ 50), left (x -50)
			//<--- And we need to find those tiles every time we iterate, cause we've moved. So this array stores up to 4 moveable tiles
			var loop:Boolean = true;
			
			while (loop)
			{
				if (moves <= 0) //<---- Here's where we return if we run out of moves
					return null;
				moveableTiles.length = 0; //<--- We need to reset this array everytime so we can refresh with the new moveable tiles
				for (var i:Number = 0; i < possibleMoves.length; i++)//<--- here's where we find the moveable tiles. It's important to note that moveableTiles is an array of POINTS, not Tiles
				//<--- Also note that we're cross checking possibleMoves so that we make sure we're adding tiles that exist and aren't currently occupied
				{
					if ((possibleMoves[i].x == currentTile.x + 50) && (possibleMoves[i].y == currentTile.y))
						moveableTiles.push(new Point(possibleMoves[i].x, possibleMoves[i].y));
					else if ((possibleMoves[i].x == currentTile.x - 50) && (possibleMoves[i].y == currentTile.y))
						moveableTiles.push(new Point(possibleMoves[i].x, possibleMoves[i].y));
					else if ((possibleMoves[i].x == currentTile.x) && (possibleMoves[i].y == currentTile.y + 50))
						moveableTiles.push(new Point(possibleMoves[i].x, possibleMoves[i].y));
					else if ((possibleMoves[i].x == currentTile.x) && (possibleMoves[i].y == currentTile.y - 50))
						moveableTiles.push(new Point(possibleMoves[i].x, possibleMoves[i].y));
				}
				
				//<--------- This is where the algorithm begins
				var differenceX:Number = endPnt.x - currentTile.x; //<------ We calculate how many pixels seperate where we currently are from where the destination tile is
				var differenceY:Number = endPnt.y - currentTile.y;
				var tilesToMoveX:Number = differenceX / 50;//<--- We divide the difference by 50 so that we now know how many times up we have to horizontally to get there
				var tilesToMoveY:Number = differenceY / 50;//<--- And how many times vertically
				
				//<----- Now we have to decide which, of the available tiles, will get us to the destination faster. It's a ranking/sorting algorithm now, basically
				var max:Number = 0; 
				var index:Number = 0; //<---- Along with the maximum product, we also need to store what index of moveabletiles is the one we want to move to
				
				for (var j:Number = 0; j < moveableTiles.length; j++)//<--- So for every moveable tile, we decide which has the highest score
				{
					var productX:Number; //<---- We do this by multiplying the x and y of that tyle by the number of tiles to move in that direciotn
					var productY:Number;
					
					//<--- What this does is it ranks the highest number. So... for instance, if we need to move -150 pixels up, and 50 pixels to the right... That would be...
					//<--- -3 tiles up, and 1 tile right
					//<--- If we have all 4 tiles in the moveable array, then in the order this is how the score would work itself out...
					//<--- Up - (-3 * -50) = 150
					//<-- Right - (1 * 50) = 50
					//<-- Down - (0 * 50) = 0
					//<-- Left - (0 * -50) = 0
					//<--- So we store Up as the highest rated tile
					productX = (moveableTiles[j].x - currentTile.x) * tilesToMoveX;
					productY = (moveableTiles[j].y - currentTile.y) * tilesToMoveY;
					if (productX > productY)
					{
						if (max == 0)
							{max = productX; index = j; }
						else
						{
							if (productX > max)
							{max = productX; index = j; }	
						}
					}
					else
					{
						if (max == 0)
							{max = productY; index = j; }
						else
						{
							if (productY > max)
							{max = productY; index = j; }	
						}
					}
				}
				
				//<--- Then we add that tile to the path's inner array
				path.add(moveableTiles[index]);
				//<--- Subtract moves
				moves--;
				//<--- Then advance current tile
				currentTile = moveableTiles[index];
				//<--- If we current tile now = destination, we can exit the loop
				if ((currentTile.x == endPnt.x) && (currentTile.y == endPnt.y))
					loop = false;
			}
			//<--- Then return the path
			return path;
		}
		
		//<--- Since we can onlyreturn 1 thing at a time we have to return one and have a getter for the other
		public function getPaths():Array
		{
			return paths;
		}
		
		//<----**** I THINK THIS IS WHERE THE ERROR IS****
		public function resetPathfinder():void 
		{
			//<-- For some reason after reseting availableTiles to 0, it ould reset the passed in possiblemoves array to 0
			//<--- So when I moved these to a seperate function, that's when this error began
			availableTiles = [];
			paths = [];
		}
	}
}
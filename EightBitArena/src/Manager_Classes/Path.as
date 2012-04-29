//========================
//Path.as
//========================
// - This class is used by Pathfinder.as a storage unit for arrays of points that represent a path for a player object
// - Contains:
//		- an array of points that represent a walkable path of tiles


package Manager_Classes 
{
	import flash.geom.Point;
	
	public class Path 
	{
		private var _path:Array;
		
		public function Path() 
		{
			_path = new Array();
		}
		
		public function add(pnt:Point) :void
		{
			_path.push(pnt);
		}
		public function getPath():Array
		{
			return _path;
		}
		
		public function getLength():Number
		{
			return _path.length;
		}
	}
}
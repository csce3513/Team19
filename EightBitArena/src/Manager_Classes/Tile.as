	//====================================================================
	// TILE.AS
	//====================================================================
	// Manager class that will communicate tile dimensions
	// in terms that are easy to understand. each tile will be 50x50 pixels.
	// the gameboard is limited to 15 tiles by 15 tiles, so 750 pixelsx750
	// this class creates functionality to impliment each tile as an object.
	// -------------------------------------------------------------------

package Manager_Classes 
{
	import flash.geom.Point;
	import as3isolib.display.scene.Map;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.primitive.IsoRectangle;
	
	public class Tile extends IsoRectangle {
		
		
		private var coord:Point;
		private var occupied:Boolean;
		private var occupant:GameObject;
		private var name:String;
		
		/*//---------tile names start here
		private var a1:Point;
		private var a2:Point;
		private var a3:Point;
		private var a4:Point;
		private var a5:Point;
		private var a6:Point;
		private var a7:Point;
		private var a8:Point;
		private var a9:Point;
		private var a10:Point;
		private var a11:Point;
		private var a12:Point;
		private var a13:Point;
		private var a14:Point;
		private var a15:Point;*/
		
		public function Tile(x:Number, y:Number, name:String)
		{
			coord = new Point(x,y);
			occupied = false;
			this.name = name;
		}
		
		public function setoccupied(gameobject:GameObject)
		{
			occupied = true;
			occupant = gameobject;
		}
		
		public function removeoccupied()
		{
			occupied = false;
			occupant = null;
		}
		
		public function checkoccupied():Boolean 
		{
			if (occupied = true)
			{
			return occupant.GetName();
			}
			else
			return false;
		}
		
	}

}
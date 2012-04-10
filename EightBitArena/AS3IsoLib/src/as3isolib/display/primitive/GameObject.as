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
	import as3isolib.display.IsoSprite;
	import as3isolib.display.scene.Map;
	import flash.display.Bitmap;
	
	public class GameObject  extends IsoSprite
	{
		protected var currentTile:Point;
		protected var map:Map;
		protected var activeunit:Boolean = false;            // each game object has a boolean parameter for being the active unit
		protected var objectname:String;
		
		public function GameObject() 
		{
			currentTile = new Point();
			currentTile.x = this.x;
			currentTile.y = this.y;
			activeunit = false;					// set to false by default.
		}
		
		public function reportName():String 
		{
			return objectname;
		}
		
		protected function center(image:Bitmap):void {
			image.x = ((this.width/2) - (image.width/2)) - (this.length/2);
			image.y = ((this.length / 2) + (this.width / 2)) - image.height - 25;
			sprites = [image];
		}
		public override function moveTo(x:Number, y:Number, z:Number ):void
		{
			var desiredTile:Point = new Point();
			desiredTile.x = x;
			desiredTile.y = y;
			if (!map.checkCollision(desiredTile))
			{
				this.x = x;
				this.y = y;
				this.z = z;
				currentTile.x = this.x;
				currentTile.y = this.y;
			}
		}
		public function SetActiveUnit():void  // active unit condition is used for selecting/performing actions
		{
			activeunit = true;
		}
		public function RemoveActiveUnit():void 
		{
			activeunit = false;
		}
		
	}
}

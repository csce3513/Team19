package  {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import as3isolib.display.primitive.Tile
	

	public class TileTest extends TestCase 
	{
		public var tileZ:Tile;
		public var tileB:Tile;
		//---------
		//strings used to test getter/setter for names
		public var testname:String = 'Brett';
		public var testname1:String = 'poop';
		public var teststring:String;
		public var teststring1:String;
		//-------------------------------------------
		
		//arrays to store tiles-----------------
		public var xarray:Array = new Array();
		public var yarray:Array = new Array();
		public var maparray:Array = new Array();
		//----------------------------------
		
		//variables used in array indexing
		public var pixelrow:int = 0;
		public var pixelcolumn:int = 0;
		public var poop:int = 0;
		
		//----------------------------------
		
		public function TileTest(testMethod:String) {
			super(testMethod);
		}
		// TESTS THE GETNAME FUNCTION
		/*public function tileNameTest():void
		{
			tileZ = new Tile(5, 5, testname);
			tileB = new Tile(5, 5, testname1);
			teststring = tileZ.getTileName();
			teststring1 = tileB.getTileName();
			assertNotSame(teststring, teststring1);
		}
		*/
		// tests creating a large array of tile objects.
		public function createTileTest():void
		{
			
			for (var i:int = 0; i < 5; i++)
			{
				xarray[i] = new Tile(pixelrow, pixelcolumn, String(poop));
				pixelrow += 50;
				//trace(poop);
				poop++;
				
				
				for (var k:int = 0; k < 5; k++)
				{
					yarray[k] = new Tile(pixelrow, pixelcolumn, String(poop));
					pixelcolumn += 50;
					//trace(poop);
					poop++;
				}
				pixelcolumn = 0;
				
				
			}
			teststring = yarray[1].getTileName();
			trace(teststring);
			//for (var l:int = 0; l < 15; l++)
			//{
				
			//}
			
			/*teststring = xarray[14].getTileName();
			trace(teststring);
			teststring1 = yarray[14].getTileName();
			trace(teststring1);
			//maparray.push(xarray, yarray);
			//trace(maparray[0]);
			/*
			for (var l:int = 0; l < 15; l++)
			{
			for (var e:int = 0; e < 15; e++)
			{
				trace maparray[
			
			}*/
			assertNotNull(xarray[0], xarray[1]);
		}
	}
}
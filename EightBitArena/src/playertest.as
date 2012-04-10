package  {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import as3isolib.display.primitive.Tile
	import as3isolib.display.primitive.PlayerObject;
	import as3isolib.display.scene.Map;
	import Manager_Classes.GameManager;
	import as3isolib.display.primitive.Tile;
	import EightBitArena;
	

	public class playertest extends TestCase 
	{
		
		private var testchamp:PlayerObject;
		private var testchamp2:PlayerObject;
		private var testchamp3:PlayerObject;
		private var testmap:Map;
		
		
		
		public function playertest(testMethod:String)
		{
			super(testMethod);
		}
		
		public function createtest():void
		{
			testchamp = new PlayerObject(testmap);
			testchamp2 = new PlayerObject(testmap);
			assertNotNull(testchamp);
			assertNotNull(testchamp2);
		}
		public function testnames():void
		{
			var testname:String = 'poop';
			var testname2:String = 'poopy';
			testchamp = new PlayerObject(testmap);
			testchamp2 = new PlayerObject(testmap);
			testchamp.SetName(testname);
			testchamp2.SetName(testname2);
			assertNotSame(testchamp2.GetName, testchamp.GetName);
			
		}
		
		public function maptest():void
		{
			testchamp = new PlayerObject(testmap);
			testchamp2 = new PlayerObject(testmap);
			testchamp3 = new PlayerObject(testmap);
			testchamp2 = testchamp;
			testmap.SetPlayer1Pieces(testchamp);
			testchamp3 = testmap.GetPlayer1Pieces();
			assertSame(testchamp2, testchamp3);
		}
		public function movecalctest():void 
		{
			testmap = new Map();
			testchamp = new PlayerObject(testmap);
			testchamp.setMovement(1);
			testmap.showMoves(testchamp);
			assertTrue(testmap.tilesArray.length == 4);
		}
		
		public function movesdeletetest():void
		{
			testmap = new Map();
			testchamp = new PlayerObject(testmap);
			testchamp.setMovement(1);
			testmap.showMoves(testchamp);
			//assertTrue(testmap.tilesArray.length == 4);
			testmap.clearMoves(testchamp);
			//assertTrue(testmap.possibleMoves.length == 0);
			assertTrue(testmap.possibleMoves[1] == null);
		}
		
	}
}
package  {
	
	import as3isolib.display.primitive.GameObject;
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import Manager_Classes.TileManager;
	

	public class gameobjecttest extends TestCase {
		
		private var box1:GameObject;
		private var box3:GameObject;
		private var tileManager:TileManager;
		
		
		
		public function gameobjecttest(testMethod:String): void
		{
			super(testMethod);
			
		}
		
		public function objectexists():void
		{
			tileManager = new TileManager();
			box1 = new GameObject(tileManager);
			assertSame(box1, box1);
		}
		
		public function testgameX():void
		{
			tileManager = new TileManager();
			box1 = new GameObject(tileManager);
			box1.moveTo(100, 100, 0);
			box3 = new GameObject(tileManager);
			box3.moveTo(100, 100, 0);
			assertSame(box1.x, box3.x);	
		}
		
		public function testactive():void
		{
			tileManager = new TileManager();
			box1 = new GameObject(tileManager);
			box1.SetActiveUnit();
			box1.RemoveActiveUnit();
			//assertTrue(box1.ReturnCondition());
			assertFalse(box1.ReturnCondition());
		}
	}
}

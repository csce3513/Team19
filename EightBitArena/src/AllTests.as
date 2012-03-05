package {
	import asunit.framework.TestSuite;
	import UnitTest;
	import UnitTestTest;
	import Manager_Classes.Tile;

	public class AllTests extends TestSuite {

		public function AllTests() {
			super();
            //addTest(new TileTest("tileNameTest"));
            addTest(new TileTest("createTileTest"));
		}
	}
}

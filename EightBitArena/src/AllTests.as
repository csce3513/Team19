package {
	import asunit.framework.TestSuite;
	import UnitTest;
	import UnitTestTest;
	

	public class AllTests extends TestSuite {

		public function AllTests() {
			super();
            //addTest(new TileTest("tileNameTest"));
            //addTest(new TileTest("createTileTest"));
			addTest(new playertest("createtest"));
			addTest(new playertest("testnames"));
			addTest(new playertest("maptest"));
			addTest(new playertest("movecalctest"));
			addTest(new playertest("movesdeletetest"));
		}
	}
}

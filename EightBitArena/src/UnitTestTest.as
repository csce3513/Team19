package  {
	import asunit.framework.TestCase;

	public class UnitTestTest extends TestCase {
		private var instance:UnitTest;

		public function UnitTestTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			instance = new UnitTest();
		}

		protected override function tearDown():void {
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("UnitTest instantiated", instance is UnitTest);
		}

		public function test():void {
			assertTrue("failing test", false);
		}
	}
}

package {
	import asunit.framework.TestSuite;
	import UnitTest;
	import UnitTestTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			super();
            addTest(new UnitTest("TestIntegerMath"));
            addTest(new UnitTest("TestFloatMath"));
		}
	}
}

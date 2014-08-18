package;

import massive.munit.Assert;

class BigIntTest{
	public function new(){

	}
	
	@BeforeClass
	public function beforeClass():Void{

	}
	
	@AfterClass
	public function afterClass():Void{
	}
	
	@Before
	public function setup():Void{

	}
	
	@After
	public function tearDown():Void{

	}

	@Test
	public function zeroToString():Void {
		Assert.areEqual("0", BigInt.fromInt(0).toString());
	}

	@Test
	public function positiveIntToString():Void {
		Assert.areEqual("2000", BigInt.fromInt(2000).toString());
	}

	@Test
	public function negativeIntToString():Void {
		Assert.areEqual("-2000", BigInt.fromInt(-2000).toString());
	}

	@Test
	public function maxIntToString():Void {
		Assert.areEqual("2147483647", BigInt.fromInt(2147483647).toString());
	}
	@Test
	public function minIntToString():Void {
		Assert.areEqual("-2147483648", BigInt.fromInt(-2147483648).toString());
	}
}
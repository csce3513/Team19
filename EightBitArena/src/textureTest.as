package  
{
	import as3isolib.graphics.BitmapFill;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.*;
	import as3isolib.display.IsoSprite;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.geom.Point;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.Map;
	import as3isolib.display.primitive.GameObject;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.primitive.IsoBox;
	import flash.events.*;
	import as3isolib.graphics.SolidColorFill;
	import as3isolib.graphics.Stroke;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import asunit.framework.Test;
	import asunit.framework.TestCase;
	
	public class textureTest extends TestCase 
	{

		public function textureTest(testMethod:String) {
			super(testMethod);
		}
		
		public function textureloadTest():void
		{
		var myImgLoader:Loader = new Loader();
		myImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoadComplete);
		Loader.load(new URLRequest('grass.png'));
	
		//myImgLoader.load(myImgURL);
		
		
		
		function imgLoadComplete(e:Event):void
		{
		var myImg:Bitmap = new Bitmap(e.target.content.bitmapData);
		myRect.fills = [new BitmapFill(myImg, IsoOrientation.XY)];
		}
		
		}
		
	}

}
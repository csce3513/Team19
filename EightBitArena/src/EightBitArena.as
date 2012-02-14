package 
{
        import as3isolib.display.primitive.IsoBox;
        import as3isolib.display.scene.IsoScene;
        
        import flash.display.Sprite;
        
        public class EightBitArena extends Sprite
        {
                public function EightBitArena ()
                {
                        var box:IsoBox = new IsoBox();
                        box.setSize(25, 25, 25);
                        box.moveTo(200, 0, 0);
                        
                        var scene:IsoScene = new IsoScene();
                        scene.hostContainer = this;
                        scene.addChild(box);
                        scene.render();
                }
        }
}
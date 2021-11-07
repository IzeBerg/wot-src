package net.wg.gui.bootcamp.containers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.interfaces.IAnimatedContainerRenderer;
   import net.wg.gui.bootcamp.interfaces.IAnimatedRenderer;
   
   public class AnimatedSpriteContainer extends MovieClip implements IAnimatedContainerRenderer
   {
       
      
      public var content:IAnimatedRenderer;
      
      public function AnimatedSpriteContainer()
      {
         super();
      }
      
      public function addContent(param1:DisplayObject) : void
      {
         this.content.addChild(param1);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function removeContent(param1:DisplayObject) : void
      {
         this.content.removeChild(param1);
      }
      
      protected function onDispose() : void
      {
         this.content.dispose();
         this.content = null;
      }
      
      public function get contentWidth() : int
      {
         return this.content.contentWidth;
      }
      
      public function get contentHeight() : int
      {
         return this.content.contentHeight;
      }
      
      public function get text() : String
      {
         return this.content.text;
      }
      
      public function set text(param1:String) : void
      {
         this.content.text = param1;
      }
      
      public function set htmlText(param1:String) : void
      {
         this.content.htmlText = param1;
      }
   }
}

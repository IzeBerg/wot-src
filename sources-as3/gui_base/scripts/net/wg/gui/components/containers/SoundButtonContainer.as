package net.wg.gui.components.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.interfaces.ISoundButtonEx;
   
   public class SoundButtonContainer extends MovieClip
   {
       
      
      public var content:ISoundButtonEx;
      
      public function SoundButtonContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.content.dispose();
         this.content = null;
      }
      
      public function get button() : ISoundButtonEx
      {
         return this.content;
      }
      
      public function get contentWidth() : int
      {
         return this.content.width;
      }
      
      public function get contentHeight() : int
      {
         return this.content.height;
      }
      
      public function get text() : String
      {
         return this.content.label;
      }
      
      public function set text(param1:String) : void
      {
         this.content.label = param1;
      }
   }
}

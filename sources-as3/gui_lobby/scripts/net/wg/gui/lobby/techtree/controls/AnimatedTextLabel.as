package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedTextLabel extends Sprite implements IDisposable
   {
       
      
      public var labelTF:TextField = null;
      
      public function AnimatedTextLabel()
      {
         super();
      }
      
      protected function onDispose() : void
      {
         this.labelTF = null;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function get text() : String
      {
         return this.labelTF.text;
      }
      
      public function set text(param1:String) : void
      {
         this.labelTF.text = param1;
      }
   }
}

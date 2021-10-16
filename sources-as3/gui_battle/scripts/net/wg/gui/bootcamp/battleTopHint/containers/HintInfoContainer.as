package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintInfoContainer extends Sprite implements IDisposable
   {
       
      
      public var txt:TextField = null;
      
      public function HintInfoContainer()
      {
         super();
         this.txt.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public final function dispose() : void
      {
         this.txt = null;
      }
      
      public function setHintText(param1:String) : void
      {
         this.txt.text = param1;
      }
   }
}

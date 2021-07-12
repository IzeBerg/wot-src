package net.wg.gui.components.advanced.tutorial
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintText extends Sprite implements IDisposable
   {
       
      
      public var hintTF:TextField = null;
      
      public function TutorialHintText()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.hintTF = null;
      }
   }
}

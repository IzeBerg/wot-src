package net.wg.gui.components.damageIndicator
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ItemWithRotation extends MovieClip implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      public function ItemWithRotation()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.textField = null;
      }
   }
}

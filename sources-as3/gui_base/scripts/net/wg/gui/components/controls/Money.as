package net.wg.gui.components.controls
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class Money extends UIComponentEx
   {
       
      
      public var price:TextField = null;
      
      public function Money()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.price = null;
         super.onDispose();
      }
   }
}

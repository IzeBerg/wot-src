package net.wg.gui.components.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ContextMenuItemSeparate extends UIComponentEx
   {
       
      
      public var id:String = "";
      
      public var index:Number = 0;
      
      public function ContextMenuItemSeparate()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}

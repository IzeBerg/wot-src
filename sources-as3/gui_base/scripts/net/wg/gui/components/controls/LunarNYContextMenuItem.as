package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   
   public class LunarNYContextMenuItem extends ContextMenuItem
   {
       
      
      public var nyBg:Sprite;
      
      public function LunarNYContextMenuItem()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.nyBg = null;
         super.onDispose();
      }
   }
}

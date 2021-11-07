package net.wg.gui.components.questProgress.components.headerProgress.iconDashed
{
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.questProgress.components.headerProgress.dashed.HeaderProgressDash;
   
   public class HeaderProgressIconDash extends HeaderProgressDash
   {
      
      private static const ICO_X_SHIFT:int = 6;
       
      
      public var ico:FrameStateCmpnt = null;
      
      public function HeaderProgressIconDash()
      {
         super();
      }
      
      override protected function updateItem(param1:int, param2:String, param3:Boolean) : void
      {
         super.updateItem(param1,param2,param3);
         this.ico.frameLabel = param2;
         this.ico.visible = !param3;
         this.ico.x = param1 + this.getIcoXShift();
      }
      
      override protected function onDispose() : void
      {
         this.ico.dispose();
         this.ico = null;
         super.onDispose();
      }
      
      protected function getIcoXShift() : int
      {
         return ICO_X_SHIFT;
      }
   }
}

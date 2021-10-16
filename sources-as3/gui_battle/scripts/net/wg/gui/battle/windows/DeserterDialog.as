package net.wg.gui.battle.windows
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IDeserterDialogMeta;
   import net.wg.infrastructure.base.meta.impl.DeserterDialogMeta;
   
   public class DeserterDialog extends DeserterDialogMeta implements IDeserterDialogMeta
   {
      
      private static const BOTTOM_PADDING:int = 40;
       
      
      public var icon:UILoaderAlt = null;
      
      public function DeserterDialog()
      {
         super();
      }
      
      public function as_setData(param1:String, param2:int) : void
      {
         this.icon.source = param1;
         textField.y = param2;
         invalidateLayout();
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         var _loc1_:Number = textField.y + textField.height + BOTTOM_PADDING ^ 0;
         return Math.max(_loc1_,super.getBackgroundActualHeight());
      }
      
      override protected function onDispose() : void
      {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         super.onDispose();
      }
   }
}

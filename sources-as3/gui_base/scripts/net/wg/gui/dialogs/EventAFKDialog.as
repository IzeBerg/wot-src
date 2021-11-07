package net.wg.gui.dialogs
{
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IEventAFKDialogMeta;
   import net.wg.infrastructure.base.meta.impl.EventAFKDialogMeta;
   
   public class EventAFKDialog extends EventAFKDialogMeta implements IEventAFKDialogMeta
   {
      
      private static const BOTTOM_PADDING:int = 40;
       
      
      public var icon:UILoaderAlt = null;
      
      public function EventAFKDialog()
      {
         super();
      }
      
      public function as_setData(param1:String) : void
      {
         this.icon.source = param1;
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

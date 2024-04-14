package net.wg.gui.lobby.dialogs
{
   import flash.events.Event;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.meta.IIconDialogMeta;
   import net.wg.infrastructure.base.meta.impl.IconDialogMeta;
   
   public class IconDialog extends IconDialogMeta implements IIconDialogMeta
   {
       
      
      public var icon:UILoaderAlt;
      
      public function IconDialog()
      {
         super();
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         var _loc1_:Number = Boolean(this.icon) ? Number(this.icon.y + this.icon.height) : Number(0);
         return Math.max(_loc1_,super.getBackgroundActualHeight());
      }
      
      override protected function onDispose() : void
      {
         if(this.icon)
         {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.loadingCompleteHandler);
            this.icon.dispose();
            if(this.icon.parent)
            {
               this.icon.parent.removeChild(this.icon);
            }
            this.icon = null;
         }
         super.onDispose();
      }
      
      public function as_setIcon(param1:String) : void
      {
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.loadingCompleteHandler,false,0,true);
         this.icon.source = param1;
      }
      
      private function loadingCompleteHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}

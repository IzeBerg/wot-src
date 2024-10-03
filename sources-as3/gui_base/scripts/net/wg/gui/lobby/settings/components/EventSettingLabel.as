package net.wg.gui.lobby.settings.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.core.UIComponent;
   
   public class EventSettingLabel extends UIComponent
   {
       
      
      public var warningLoader:UILoaderAlt;
      
      public var descriptionTf:TextField;
      
      public function EventSettingLabel()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
         this.warningLoader.addEventListener(UILoaderEvent.COMPLETE,this.onWarningLoaderCompleteHandler);
         this.warningLoader.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTBIGICON;
         this.descriptionTf.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTf.text = SETTINGS.EVENTSETTINGDISABLED;
      }
      
      private function onWarningLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.descriptionTf.x = this.warningLoader.width;
         this.descriptionTf.y = this.warningLoader.height - this.descriptionTf.height >> 1;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
         this.warningLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onWarningLoaderCompleteHandler);
         this.warningLoader.dispose();
         this.warningLoader = null;
         this.descriptionTf = null;
         super.onDispose();
      }
      
      private function onHitMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.SETTTINGSDISABLEDNOTIFICATION);
      }
   }
}

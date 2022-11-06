package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class WaitingAlert extends UIComponentEx
   {
       
      
      public var alertIcon:MovieClip;
      
      public var icon:UILoaderAlt;
      
      private var _tooltip:String;
      
      public function WaitingAlert()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.dispose();
         this.alertIcon = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this._tooltip = param1;
         this.icon.source = param2;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._tooltip);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}

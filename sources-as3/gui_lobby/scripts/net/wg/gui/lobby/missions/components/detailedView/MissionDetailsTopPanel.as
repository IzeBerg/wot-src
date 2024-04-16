package net.wg.gui.lobby.missions.components.detailedView
{
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.event.MissionDetailsTopPanelEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionDetailsTopPanel extends UIComponentEx
   {
      
      private static const VIEW_WIDTH:int = 753;
      
      private static const CLOSE_BTN_ALPHA_FADED:Number = 0.5;
      
      private static const CLOSE_BTN_ALPHA_DEFAULT:Number = 1;
       
      
      public var btnClose:ISoundButtonEx;
      
      private var _viewWidth:int;
      
      public function MissionDetailsTopPanel()
      {
         super();
         this._viewWidth = VIEW_WIDTH;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnClose.label = VEH_COMPARE.HEADER_CLOSEBTN_LABEL;
         this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.dispose();
         this.btnClose = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.btnClose.x = (width + this._viewWidth >> 1) - this.btnClose.width;
         }
      }
      
      public function onVehicleSelectorStateChange(param1:Boolean) : void
      {
         this.btnClose.alpha = !!param1 ? Number(CLOSE_BTN_ALPHA_FADED) : Number(CLOSE_BTN_ALPHA_DEFAULT);
      }
      
      public function setViewWidth(param1:int) : void
      {
         this._viewWidth = param1;
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new MissionDetailsTopPanelEvent(MissionDetailsTopPanelEvent.CLOSE_CLICK));
      }
   }
}

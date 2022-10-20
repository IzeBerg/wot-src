package net.wg.gui.battle.views.FDPostmortemPanel
{
   import flash.text.TextField;
   import flashx.textLayout.formats.VerticalAlign;
   import net.wg.gui.battle.views.postmortemPanel.BasePostmortemPanel;
   import net.wg.infrastructure.base.meta.IFDPostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.FDPostmortemPanelMeta;
   
   public class FDPostmortemPanel extends FDPostmortemPanelMeta implements IFDPostmortemPanelMeta
   {
      
      private static const TITLE_DEFAULT_Y:int = -122;
       
      
      public var timer:FDPostmortemTimer = null;
      
      public var hintTitleTF:TextField = null;
      
      public var hintDescTF:TextField = null;
      
      public function FDPostmortemPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.timer.dispose();
         this.timer = null;
         this.hintTitleTF = null;
         this.hintDescTF = null;
         super.onDispose();
      }
      
      override protected function updatePlayerInfoPosition() : void
      {
         playerInfoTF.y = -BasePostmortemPanel.PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
         deadReasonTF.y = vehiclePanel.y - GAP_VEHICLE_PANEL_DEAD_REASON - deadReasonTF.height | 0;
         if(_userName != null)
         {
            _userName.y = deadReasonTF.y + deadReasonTF.textHeight + GAP_USER_NAME_DEAD_REASON | 0;
            _userName.x = -_userName.textWidth >> 1;
            _userName.verticalAlign = VerticalAlign.MIDDLE;
            _userName.textColor = WHITE_TEXT_COLOR;
         }
         if(deadReasonBG)
         {
            deadReasonBG.y = deadReasonTF.y - (deadReasonBG.height - deadReasonTF.height >> 1);
         }
      }
      
      override protected function showSpectatorPanel(param1:Boolean) : void
      {
         bg.visible = false;
         observerModeTitleTF.visible = observerModeDescTF.visible = exitToHangarTitleTF.visible = exitToHangarDescTF.visible = false;
      }
      
      public function as_setHintDescr(param1:String) : void
      {
         this.hintDescTF.text = param1;
      }
      
      public function as_setHintTitle(param1:String) : void
      {
         this.hintTitleTF.text = param1;
         this.hintTitleTF.y = TITLE_DEFAULT_Y;
      }
      
      public function as_setTimer(param1:int) : void
      {
         this.timer.visible = param1 > 0;
         if(this.timer.visible)
         {
            this.timer.setLockedState(false);
            this.timer.updateRadialTimer(param1,0);
         }
         else
         {
            this.timer.stopTimer();
         }
      }
   }
}

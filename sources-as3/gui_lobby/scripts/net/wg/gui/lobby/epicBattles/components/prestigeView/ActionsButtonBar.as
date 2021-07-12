package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.epicBattles.events.EpicBattlePrestigeViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ActionsButtonBar extends UIComponentEx
   {
       
      
      public var infoWarningTextTF:TextField = null;
      
      public var alertIcon:UILoaderAlt = null;
      
      public var resetButtonBTN:SoundButtonEx = null;
      
      public var cancelButtonBTN:SoundButtonEx = null;
      
      public function ActionsButtonBar()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.cancelButtonBTN.removeEventListener(MouseEvent.CLICK,this.onCancelButtonClickHandler);
         this.resetButtonBTN.removeEventListener(MouseEvent.CLICK,this.onResetButtonClickHandler);
         this.infoWarningTextTF = null;
         this.resetButtonBTN.dispose();
         this.resetButtonBTN = null;
         this.cancelButtonBTN.dispose();
         this.cancelButtonBTN = null;
         this.alertIcon.dispose();
         this.alertIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoWarningTextTF.text = EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_WARNING;
         this.cancelButtonBTN.label = EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_CANCELBUTTONTEXT;
         this.resetButtonBTN.label = EPIC_BATTLE.EPICBATTLESPRESTIGEVIEW_RESETBUTTONTEXT;
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ICON_ALERT_32X32;
         this.cancelButtonBTN.addEventListener(MouseEvent.CLICK,this.onCancelButtonClickHandler);
         this.resetButtonBTN.addEventListener(MouseEvent.CLICK,this.onResetButtonClickHandler);
      }
      
      private function onResetButtonClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new EpicBattlePrestigeViewClickEvent(EpicBattlePrestigeViewClickEvent.RESET_BUTTON_CLICKED));
      }
      
      private function onCancelButtonClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new EpicBattlePrestigeViewClickEvent(EpicBattlePrestigeViewClickEvent.CANCEL_BUTTON_CLICKED));
      }
   }
}

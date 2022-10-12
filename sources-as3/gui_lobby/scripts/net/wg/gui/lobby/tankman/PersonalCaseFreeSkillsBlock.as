package net.wg.gui.lobby.tankman
{
   import flash.events.MouseEvent;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalCaseFreeSkillsBlock extends PersonalCaseSkillsBlockBase
   {
      
      private static const ICON_OFFSET:int = -1;
       
      
      public var infoButton:IButtonIconLoader;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function PersonalCaseFreeSkillsBlock()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.infoButton.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoButtonRollOutHandler);
         this.infoButton.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoButtonRollOverHandler);
         this.infoButton.removeEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
         this.infoButton.dispose();
         this.infoButton = null;
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         descrSkillButton.text = App.utils.locale.makeString(DIALOGS.ADDFREESKILLWINDOW_LABEL);
         this.infoButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_INFO;
         this.infoButton.iconOffsetLeft = ICON_OFFSET;
         this.infoButton.addEventListener(MouseEvent.ROLL_OUT,this.onInfoButtonRollOutHandler);
         this.infoButton.addEventListener(MouseEvent.ROLL_OVER,this.onInfoButtonRollOverHandler);
         this.infoButton.addEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
      }
      
      private function onInfoButtonRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onInfoButtonRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(TOOLTIPS.BUYFREESKILL_INFOBUTTON);
      }
      
      private function onInfoButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new PersonalCaseEvent(PersonalCaseEvent.INFO_BTN_CLICK,true));
      }
   }
}

package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoCombatReservesVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattleInfoViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class CombatReservesElement extends UIComponentEx
   {
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var progressTF:TextField = null;
      
      public var availableSkillPointsElement:AvailableSkillPointsElement = null;
      
      public var combatConsumablesButton:SoundButtonEx = null;
      
      public function CombatReservesElement()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.combatConsumablesButton.addEventListener(ButtonEvent.CLICK,this.onCombatConsumablesButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.combatConsumablesButton.removeEventListener(ButtonEvent.CLICK,this.onCombatConsumablesButtonClickHandler);
         this.combatConsumablesButton.dispose();
         this.combatConsumablesButton = null;
         this.availableSkillPointsElement.dispose();
         this.availableSkillPointsElement = null;
         this.titleTF = null;
         this.descriptionTF = null;
         this.progressTF = null;
         super.onDispose();
      }
      
      public function setData(param1:EpicBattlesInfoCombatReservesVO) : void
      {
         this.progressTF.htmlText = param1.progressHtmlText;
         this.titleTF.htmlText = param1.titleHtmlText;
         this.descriptionTF.htmlText = param1.descriptionHtmlText;
         this.combatConsumablesButton.label = param1.buttonText;
         this.availableSkillPointsElement.setData(param1);
      }
      
      private function onCombatConsumablesButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new EpicBattleInfoViewClickEvent(EpicBattleInfoViewClickEvent.COMBAT_CONSUMABLES_CLICK));
      }
   }
}

package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoMetaProgressVO;
   import net.wg.gui.lobby.epicBattles.events.EpicBattleInfoViewClickEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PrestigeAllowedPanel extends UIComponentEx
   {
       
      
      public var descriptionTF:TextField = null;
      
      public var prestigeButton:SoundButtonEx = null;
      
      private var _metaProgressData:EpicBattlesInfoMetaProgressVO = null;
      
      public function PrestigeAllowedPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.prestigeButton.addEventListener(ButtonEvent.CLICK,this.onPrestigeButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.prestigeButton.removeEventListener(ButtonEvent.CLICK,this.onPrestigeButtonClickHandler);
         this.prestigeButton.dispose();
         this.prestigeButton = null;
         this.descriptionTF = null;
         if(this._metaProgressData)
         {
            this._metaProgressData.dispose();
            this._metaProgressData = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._metaProgressData != null && InvalidationType.DATA)
         {
            this.prestigeButton.label = this._metaProgressData.buttonText;
            this.prestigeButton.visible = this._metaProgressData.canPrestige;
            this.descriptionTF.htmlText = this._metaProgressData.descriptionHtmlText;
         }
      }
      
      public function setData(param1:EpicBattlesInfoMetaProgressVO) : void
      {
         this._metaProgressData = param1;
         invalidateData();
      }
      
      private function onPrestigeButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new EpicBattleInfoViewClickEvent(EpicBattleInfoViewClickEvent.PRESTIGE_BUTTON_CLICK));
      }
   }
}

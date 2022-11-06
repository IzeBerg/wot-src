package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.battleResults.data.PremiumInfoVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class AdvertisingState extends DetailsState
   {
      
      private static const DESCRIPTION_OFFSET:int = 9;
       
      
      public var description:TextField = null;
      
      public var detailsBtn:SoundButtonEx = null;
      
      private var _data:PremiumInfoVO = null;
      
      public function AdvertisingState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.description.autoSize = TextFieldAutoSize.LEFT;
         this.detailsBtn.label = BATTLE_RESULTS.COMMON_DETAILS_GETPREMBTN;
         this.detailsBtn.addEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
         backgroundIcon.addEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               backgroundIcon.source = this._data.backgroundIcon;
               this.description.htmlText = this._data.premiumBonusStr;
               this.detailsBtn.visible = this._data.visibleDetailsBtn;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               App.utils.commons.updateTextFieldSize(this.description);
               this.description.y = backgroundIcon.height - this.description.height - this.detailsBtn.height - DESCRIPTION_OFFSET >> 1 | 0;
               this.detailsBtn.y = this.description.y + this.description.height + DESCRIPTION_OFFSET | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         backgroundIcon.removeEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         this._data = null;
         this.detailsBtn.removeEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
         this.detailsBtn.dispose();
         this.detailsBtn = null;
         this.description = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumInfoVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onDetailsBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_DETAILS_PREMIUM));
      }
      
      private function onBackgroundIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}

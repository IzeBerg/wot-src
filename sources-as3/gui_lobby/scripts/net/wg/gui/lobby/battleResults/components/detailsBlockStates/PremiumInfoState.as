package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.battleResults.data.PremiumInfoVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PremiumInfoState extends DetailsState
   {
      
      private static const VALUES_OFFSET:int = 200;
      
      private static const DETAILS_BTN_OFFSET:int = 15;
       
      
      public var description:TextField = null;
      
      public var creditsValue:TextField = null;
      
      public var xpValue:TextField = null;
      
      public var detailsBtn:SoundButtonEx = null;
      
      private var _data:PremiumInfoVO = null;
      
      public function PremiumInfoState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.description.autoSize = TextFieldAutoSize.LEFT;
         this.creditsValue.autoSize = TextFieldAutoSize.LEFT;
         this.xpValue.autoSize = TextFieldAutoSize.LEFT;
         this.detailsBtn.label = BATTLE_RESULTS.COMMON_DETAILS_GETPREMBTN;
         this.description.htmlText = BATTLE_RESULTS.COMMON_PREMIUMBONUS;
         this.detailsBtn.addEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.creditsValue.htmlText = this._data.creditsPremiumBonusStr;
               this.xpValue.htmlText = this._data.xpPremiumBonusStr;
               backgroundIcon.source = this._data.backgroundIcon;
               this.detailsBtn.visible = this._data.visibleDetailsBtn;
               this.detailsBtn.enabled = !this._data.inBattleQueue;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               App.utils.commons.updateTextFieldSize(this.creditsValue);
               App.utils.commons.updateTextFieldSize(this.xpValue);
               _loc1_ = Math.max(this.creditsValue.width,this.xpValue.width);
               this.creditsValue.x = _loc1_ - this.creditsValue.width + VALUES_OFFSET | 0;
               this.xpValue.x = _loc1_ - this.xpValue.width + VALUES_OFFSET | 0;
               this.detailsBtn.x = _loc1_ + VALUES_OFFSET + DETAILS_BTN_OFFSET | 0;
               this.description.x = this.detailsBtn.x;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.detailsBtn.removeEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
         this.detailsBtn.dispose();
         this.detailsBtn = null;
         this.description = null;
         this.creditsValue = null;
         this.xpValue = null;
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
   }
}

package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.TextEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class WotPlusEarningsState extends DetailsState
   {
      
      private static const TRANSPARENCY_VALUE:Number = 0.4;
       
      
      public var description:TextField = null;
      
      public var bonusLeft:TextField = null;
      
      public var xpValue:TextField = null;
      
      private var _data:PremiumBonusVO = null;
      
      private var _hasWotPremium:Boolean = false;
      
      public function WotPlusEarningsState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.xpValue.alpha = TRANSPARENCY_VALUE;
         backgroundIcon.source = RES_ICONS.MAPS_ICONS_PREMACC_BATTLERESULT_PLUS_BONUS_X3;
         this.bonusLeft.addEventListener(TextEvent.LINK,this.onDetailsLinkClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.description.htmlText = this._data.description;
               this.bonusLeft.htmlText = this._data.bonusLeft + this._data.additionalBonusLeft + this._data.detailsLink;
               this.xpValue.htmlText = this._data.xpValue;
               this._hasWotPremium = this._data.hasWotPremium;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.description = null;
         this.bonusLeft = null;
         this.xpValue = null;
         this.bonusLeft.removeEventListener(TextEvent.LINK,this.onDetailsLinkClickHandler);
         this.bonusLeft = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onDetailsLinkClickHandler(param1:TextEvent) : void
      {
         if(this._hasWotPremium)
         {
            dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_DETAILS_WOT_PLUS));
         }
         else
         {
            dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_DETAILS_PREMIUM));
         }
      }
   }
}

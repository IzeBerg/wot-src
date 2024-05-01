package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class WotPlusEarningsState extends DetailsState
   {
      
      private static const TRANSPARENCY_VALUE:Number = 0.4;
      
      private static const BONUS_IMAGE_LEFT_OFFSET:int = 200;
       
      
      public var description:TextField = null;
      
      public var bonusLeft:TextField = null;
      
      public var detailsLink:TextField = null;
      
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
         this.detailsLink.addEventListener(MouseEvent.CLICK,this.onDetailsLinkClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.description.htmlText = this._data.description;
               this.bonusLeft.htmlText = this._data.bonusLeft + " " + this._data.additionalBonusLeft;
               this.bonusLeft.width = this.bonusLeft.textWidth;
               _loc1_ = new TextFormat();
               _loc1_.underline = true;
               this.detailsLink.htmlText = this._data.detailsLink;
               this.detailsLink.setTextFormat(_loc1_);
               this.detailsLink.width = this.detailsLink.textWidth;
               this.detailsLink.x = this.bonusLeft.width + BONUS_IMAGE_LEFT_OFFSET;
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
         this.detailsLink.removeEventListener(MouseEvent.CLICK,this.onDetailsLinkClickHandler);
         this.detailsLink = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onDetailsLinkClickHandler(param1:MouseEvent) : void
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

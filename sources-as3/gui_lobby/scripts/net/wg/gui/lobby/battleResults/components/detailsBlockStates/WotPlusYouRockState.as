package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.text.TextField;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class WotPlusYouRockState extends DetailsState
   {
       
      
      public var description:TextField = null;
      
      public var bonusLeft:TextField = null;
      
      public var youRockText:TextField = null;
      
      private var _data:PremiumBonusVO = null;
      
      public function WotPlusYouRockState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         backgroundIcon.source = RES_ICONS.MAPS_ICONS_PREMACC_BATTLERESULT_PLUS_BONUS_YOU_ROCK;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.description.htmlText = this._data.description;
               this.youRockText.htmlText = this._data.premiumAndPlusExhausted;
               this.bonusLeft.htmlText = this._data.bonusLeft + this._data.wotPlusBonusLeft;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.description = null;
         this.bonusLeft = null;
         this.youRockText = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}

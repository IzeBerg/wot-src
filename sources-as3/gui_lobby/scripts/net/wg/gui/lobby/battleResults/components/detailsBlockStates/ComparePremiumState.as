package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
   import net.wg.gui.lobby.battleResults.data.PremiumEarningsVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class ComparePremiumState extends DetailsState
   {
      
      private static const FULL_ALPHA_VALUE:Number = 1;
      
      private static const TRANSPARENCY_VALUE:Number = 0.4;
       
      
      public var noPremTitleLbl:TextField = null;
      
      public var premTitleLbl:TextField = null;
      
      public var creditsLbl:TextField = null;
      
      public var premCreditsLbl:TextField = null;
      
      public var xpTitleLbl:TextField = null;
      
      public var xpLbl:TextField = null;
      
      public var premXpLbl:TextField = null;
      
      public var creditsTitle:TextField = null;
      
      private var _currentSelectedVehIdx:int = 0;
      
      private var _data:PersonalDataVO = null;
      
      public function ComparePremiumState()
      {
         super();
         TextFieldEx.setVerticalAlign(this.noPremTitleLbl,TextFieldEx.VALIGN_BOTTOM);
         TextFieldEx.setVerticalAlign(this.premTitleLbl,TextFieldEx.VALIGN_BOTTOM);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.noPremTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_NOPREMTITLE;
         this.premTitleLbl.text = BATTLE_RESULTS.COMMON_DETAILS_PREMTITLE;
         this.creditsTitle.text = BATTLE_RESULTS.COMMON_DETAILS_CREDITSTITLE;
         this.xpTitleLbl.autoSize = TextFieldAutoSize.LEFT;
         this.xpTitleLbl.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.xpTitleLbl.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:PremiumEarningsVO = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = this._data.isPremium || this._data.isPremiumPlus;
               _loc2_ = !!_loc1_ ? Number(TRANSPARENCY_VALUE) : Number(FULL_ALPHA_VALUE);
               _loc3_ = !!_loc1_ ? Number(FULL_ALPHA_VALUE) : Number(TRANSPARENCY_VALUE);
               this.noPremTitleLbl.alpha = _loc2_;
               this.premTitleLbl.alpha = _loc2_;
               this.creditsLbl.alpha = _loc2_;
               this.xpLbl.alpha = _loc2_;
               this.premTitleLbl.alpha = _loc3_;
               this.premCreditsLbl.alpha = _loc3_;
               this.premXpLbl.alpha = _loc3_;
               _loc4_ = this._data.premiumEarnings;
               this.xpTitleLbl.htmlText = _loc4_.xpTitleStrings[this._currentSelectedVehIdx];
               this.xpLbl.htmlText = _loc4_.xpNoPremValues[this._currentSelectedVehIdx];
               this.premXpLbl.htmlText = _loc4_.xpPremValues[this._currentSelectedVehIdx];
               this.creditsLbl.htmlText = _loc4_.creditsNoPremValues[this._currentSelectedVehIdx];
               this.premCreditsLbl.htmlText = _loc4_.creditsPremValues[this._currentSelectedVehIdx];
               backgroundIcon.source = _loc4_.backgroundIcon;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.xpTitleLbl.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.xpTitleLbl.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._data = null;
         this.noPremTitleLbl = null;
         this.premTitleLbl = null;
         this.creditsLbl = null;
         this.premCreditsLbl = null;
         this.xpTitleLbl = null;
         this.xpLbl = null;
         this.premXpLbl = null;
         this.creditsTitle = null;
         super.onDispose();
      }
      
      public function setData(param1:PersonalDataVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function set currentSelectedVehIdx(param1:int) : void
      {
         this._currentSelectedVehIdx = param1;
         invalidateData();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this._data.premiumEarnings.xpTitleTooltips[this._currentSelectedVehIdx];
         if(StringUtils.isNotEmpty(_loc2_))
         {
            App.toolTipMgr.show(_loc2_);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}

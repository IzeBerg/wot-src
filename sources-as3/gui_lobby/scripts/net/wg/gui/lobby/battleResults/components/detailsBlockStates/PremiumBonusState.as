package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PremiumBonusState extends DetailsState
   {
      
      private static const APPLY_BONUS_BTN_OFFSET_X:int = 6;
      
      private static const XP_VALUE_OFFSET:int = 5;
      
      private static const STATUS_BONUS_LABEL_OFFSET:int = 9;
      
      private static const BONUS_LEFT_OFFSET:int = -2;
      
      private static const APPLY_BONUS_BTN_OFFSET_Y:int = 4;
      
      private static const INFO_ICON_OFFSET:int = 3;
      
      private static const STATUS_LABEL_ICON_OFFSET:int = 4;
      
      private static const STATUS_LABEL_NO_ICON_OFFSET:int = 1;
       
      
      public var description:TextField = null;
      
      public var bonusLeft:TextField = null;
      
      public var xpValue:TextField = null;
      
      public var statusBonusLabel:TextField = null;
      
      public var infoIcon:Image = null;
      
      public var applyBonusBtn:SoundButtonEx = null;
      
      private var _data:PremiumBonusVO = null;
      
      private var _commons:ICommons = null;
      
      public function PremiumBonusState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._commons = App.utils.commons;
         this.applyBonusBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBonusBtnClickHandler);
         this.applyBonusBtn.label = BATTLE_RESULTS.COMMON_PREMIUMBONUS_APPLYBONUSBTN;
         backgroundIcon.addEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         this.infoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INFO_YELLOW;
         this.infoIcon.addEventListener(Event.CHANGE,this.onInfoIconChangeHandler);
         this.infoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Rectangle = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.description.htmlText = this._data.description;
               this.bonusLeft.htmlText = this._data.bonusLeft;
               backgroundIcon.source = this._data.bonusIcon;
               this.statusBonusLabel.visible = StringUtils.isNotEmpty(this._data.statusBonusLabel);
               if(this.statusBonusLabel.visible)
               {
                  this.statusBonusLabel.htmlText = this._data.statusBonusLabel;
               }
               _loc1_ = StringUtils.isNotEmpty(this._data.xpValue);
               this.applyBonusBtn.visible = _loc1_;
               this.xpValue.visible = _loc1_;
               if(_loc1_)
               {
                  this.xpValue.htmlText = this._data.xpValue;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this._commons.updateTextFieldSize(this.description,false,false);
               this._commons.updateTextFieldSize(this.bonusLeft,true,false);
               this._commons.updateTextFieldSize(this.xpValue,true,false);
               this._commons.updateTextFieldSize(this.statusBonusLabel,true,false);
               if(this.xpValue.visible)
               {
                  this.applyBonusBtn.x = this.xpValue.x + this.xpValue.width + APPLY_BONUS_BTN_OFFSET_X | 0;
               }
               _loc2_ = StringUtils.isNotEmpty(this._data.statusBonusTooltip);
               this.infoIcon.visible = _loc2_;
               this.statusBonusLabel.x = this.description.x - (!!_loc2_ ? STATUS_LABEL_NO_ICON_OFFSET : STATUS_LABEL_ICON_OFFSET);
               this.statusBonusLabel.width = backgroundIcon.width - this.statusBonusLabel.x - (!!_loc2_ ? this.infoIcon.width : 0);
               if(_loc2_)
               {
                  _loc3_ = this.statusBonusLabel.length;
                  _loc4_ = this.statusBonusLabel.getCharBoundaries(_loc3_ - 1);
                  if(_loc4_ != null)
                  {
                     this.infoIcon.x = this.statusBonusLabel.x + _loc4_.x + _loc4_.width | 0;
                     this.infoIcon.y = this.statusBonusLabel.y + _loc4_.y - INFO_ICON_OFFSET | 0;
                  }
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         backgroundIcon.removeEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         this._data = null;
         this.applyBonusBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBonusBtnClickHandler);
         this.applyBonusBtn.dispose();
         this.applyBonusBtn = null;
         this.infoIcon.removeEventListener(Event.CHANGE,this.onInfoIconChangeHandler);
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.infoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.description = null;
         this.bonusLeft = null;
         this.xpValue = null;
         this.statusBonusLabel = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._data.statusBonusTooltip);
      }
      
      private function onInfoIconRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onInfoIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onBackgroundIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onApplyBonusBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.APPLIED_PREMIUM_BONUS));
      }
   }
}

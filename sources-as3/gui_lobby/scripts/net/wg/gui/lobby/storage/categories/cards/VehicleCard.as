package net.wg.gui.lobby.storage.categories.cards
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class VehicleCard extends BaseCard
   {
      
      private static const TRADE_PRICE_V_OFFSET:int = 2;
      
      private static const TITLE_ERROR_ALPHA:Number = 0.5;
      
      private static const IMAGE_HOVER_ALPHA:Number = 0.3;
      
      private static const TITLE_GOOD_ALPHA:int = 1;
       
      
      public var infoImg:Image = null;
      
      public var txtInfo:TextField = null;
      
      public var tradeOffCornerHighlight:Sprite;
      
      public var tradeIcon:Sprite;
      
      public var tradeTitleTF:TextField = null;
      
      public var tradePrice:IconText;
      
      public var disabled:BitmapFill;
      
      public function VehicleCard()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.infoImg.removeEventListener(Event.CHANGE,this.onInfoImgCompleteHandler);
         this.infoImg.dispose();
         this.infoImg = null;
         this.txtInfo = null;
         this.tradeOffCornerHighlight = null;
         this.tradeTitleTF = null;
         this.tradeIcon = null;
         this.tradePrice.dispose();
         this.tradePrice = null;
         this.disabled.dispose();
         this.disabled = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.txtInfo.autoSize = TextFieldAutoSize.LEFT;
         this.txtInfo.mouseWheelEnabled = this.txtInfo.mouseEnabled = false;
         this.txtInfo.wordWrap = false;
         this.tradeOffCornerHighlight.mouseEnabled = this.tradeOffCornerHighlight.mouseChildren = false;
         this.tradeIcon.mouseEnabled = this.tradeIcon.mouseChildren = false;
         this.tradeTitleTF.mouseWheelEnabled = this.tradeTitleTF.mouseEnabled = false;
         this.tradeTitleTF.autoSize = TextFieldAutoSize.LEFT;
         this.tradeTitleTF.wordWrap = false;
         this.tradeTitleTF.text = STORAGE.CARD_VEHICLE_TRADEOFFPRICELABEL;
         this.infoImg.mouseEnabled = this.infoImg.mouseChildren = false;
         this.infoImg.addEventListener(Event.CHANGE,this.onInfoImgCompleteHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehicleCardVO = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(_data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = VehicleCardVO(_data);
            if(_loc1_.infoImgSrc)
            {
               this.infoImg.source = _loc1_.infoImgSrc;
               this.infoImg.visible = true;
               titleTF.alpha = price.alpha = TITLE_ERROR_ALPHA;
            }
            else
            {
               this.infoImg.visible = false;
               titleTF.alpha = price.alpha = TITLE_GOOD_ALPHA;
            }
            _loc2_ = _loc1_.tradeOffPrice != null;
            this.tradeOffCornerHighlight.visible = this.tradeIcon.visible = this.tradeTitleTF.visible = this.tradePrice.visible = _loc2_;
            this.txtInfo.visible = this.disabled.visible = this.cantSell;
            this.txtInfo.alpha = 1;
            if(this.txtInfo.visible)
            {
               this.txtInfo.htmlText = _loc1_.infoText;
            }
         }
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.infoImg.visible)
            {
               _loc3_ = !!this.infoImg.visible ? int(this.infoImg.width + this.txtInfo.width) : int(this.txtInfo.width);
               this.infoImg.x = width - _loc3_ >> 1;
               this.infoImg.y = height - this.infoImg.height >> 1;
               this.txtInfo.x = this.infoImg.x + this.infoImg.width;
            }
            else
            {
               this.txtInfo.x = width - this.txtInfo.width >> 1;
            }
            if(this.tradeIcon.visible)
            {
               this.tradeTitleTF.x = this.tradeIcon.x + (this.tradeIcon.width >> 1) >> 0;
               this.tradeTitleTF.y = this.tradeIcon.y - (this.tradeTitleTF.height >> 1) >> 0;
               this.tradePrice.x = this.tradeTitleTF.x + this.tradeTitleTF.width >> 0;
               this.tradePrice.y = this.tradeTitleTF.y + (this.tradeTitleTF.height - this.tradePrice.height >> 1) >> 0;
               this.tradePrice.y += TRADE_PRICE_V_OFFSET;
            }
            this.txtInfo.y = height - this.txtInfo.height >> 1;
            this.disabled.widthFill = _overlay.width;
            this.disabled.heightFill = _overlay.height;
         }
      }
      
      override protected function setData(param1:BaseCardVO) : void
      {
         var _loc3_:PriceVO = null;
         super.setData(param1);
         var _loc2_:VehicleCardVO = param1 as VehicleCardVO;
         if(_loc2_ != null && _loc2_.tradeOffPrice != null)
         {
            _loc3_ = _loc2_.tradeOffPrice.price.getPriceVO();
            this.tradePrice.text = App.utils.locale.integer(_loc3_.value);
            this.tradePrice.icon = _loc3_.name;
            this.tradePrice.visible = true;
            this.tradePrice.invalidatePosition();
         }
      }
      
      override protected function onImageComplete() : void
      {
         super.onImageComplete();
         invalidateSize();
      }
      
      override protected function animateImage() : void
      {
         if(!this.txtInfo.visible)
         {
            super.animateImage();
         }
         else
         {
            image.alpha = IMAGE_HOVER_ALPHA;
         }
      }
      
      override protected function onTooltipHitAreaRollOver(param1:MouseEvent) : void
      {
         if(this.cantSell)
         {
            return;
         }
         super.onTooltipHitAreaRollOver(param1);
      }
      
      override protected function onTooltipHitAreaRollOut(param1:MouseEvent) : void
      {
         if(this.cantSell)
         {
            return;
         }
         super.onTooltipHitAreaRollOut(param1);
      }
      
      override protected function onRollOver() : void
      {
         if(this.cantSell)
         {
            return;
         }
         super.onRollOver();
      }
      
      override protected function onRollOut() : void
      {
         if(this.cantSell)
         {
            return;
         }
         super.onRollOut();
      }
      
      override protected function getRollOverTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOverTweens();
         if(this.txtInfo.visible)
         {
            _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.txtInfo,{"alpha":0},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         return _loc1_;
      }
      
      override protected function getRollOutTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOutTweens();
         if(this.txtInfo.visible)
         {
            _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.txtInfo,{"alpha":1},{"fastTransform":false}));
         }
         return _loc1_;
      }
      
      public function get cantSell() : Boolean
      {
         var _loc1_:VehicleCardVO = _data as VehicleCardVO;
         return _loc1_ && StringUtils.isNotEmpty(_loc1_.infoText);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         var _loc2_:ICommons = App.utils.commons;
         if(_loc2_.isRightButton(param1))
         {
            if(_data.contextMenuId)
            {
               dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,_data));
            }
         }
         else if(!this.cantSell && _data.enabled)
         {
            dispatchEvent(new CardEvent(CardEvent.SELL,_data));
         }
      }
      
      private function onInfoImgCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}

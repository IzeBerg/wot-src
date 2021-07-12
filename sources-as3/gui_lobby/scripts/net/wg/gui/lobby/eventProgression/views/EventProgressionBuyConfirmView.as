package net.wg.gui.lobby.eventProgression.views
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.eventProgression.data.EventProgressionBuyConfirmVO;
   import net.wg.infrastructure.base.meta.IEventProgressionBuyConfirmViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventProgressionBuyConfirmViewMeta;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventProgressionBuyConfirmView extends EventProgressionBuyConfirmViewMeta implements IEventProgressionBuyConfirmViewMeta
   {
      
      private static const BREAKING_POINT_RESOLUTION:int = 900;
      
      private static const ICON_BOTTOM:int = 30;
      
      private static const BTN_GAP:int = 12;
      
      private static const TEXT_GAP:int = 12;
      
      private static const DELIVER_TOP:int = 24;
      
      private static const BTN_TOP:int = 24;
       
      
      public var bg:Sprite;
      
      public var buyBtn:UniversalBtn;
      
      public var backBtn:UniversalBtn;
      
      public var title:TextField;
      
      public var content:TextField;
      
      public var icon:Sprite;
      
      public var glow:Sprite;
      
      public var divider:Sprite;
      
      private var _data:EventProgressionBuyConfirmVO;
      
      private var _commons:ICommons;
      
      public function EventProgressionBuyConfirmView()
      {
         this._commons = App.utils.commons;
         super();
         fadeEnable = true;
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
         super.setViewSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         var _loc2_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.buyBtn),InteractiveObject(this.backBtn)];
         App.utils.commons.initTabIndex(_loc2_);
         setFocus(_loc2_[0]);
         _loc2_.splice(0,_loc2_.length);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.buyBtn.label = this._data.buyBtnLabel;
            this.backBtn.label = this._data.backBtnLabel;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.width = width;
            this.bg.height = height;
            if(this._data)
            {
               this.title.htmlText = height < BREAKING_POINT_RESOLUTION ? this._data.title : this._data.titleBig;
               this.content.htmlText = height < BREAKING_POINT_RESOLUTION ? this._data.content : this._data.contentBig;
               this._commons.updateTextFieldSize(this.title,false,true);
               this._commons.updateTextFieldSize(this.content,false,true);
               _loc1_ = 0;
               _loc2_ = 0;
               if(this._data.showIcon)
               {
                  this.icon.visible = this.glow.visible = true;
                  _loc1_ = this.icon.height;
                  _loc2_ = this.glow.height;
               }
               else
               {
                  this.icon.visible = this.glow.visible = false;
                  _loc1_ = _loc2_ = 0;
               }
               _loc3_ = height - _loc1_ - ICON_BOTTOM - this.title.textHeight - TEXT_GAP - this.content.textHeight - DELIVER_TOP - BTN_TOP - this.buyBtn.height >> 1;
               if(this._data.showIcon)
               {
                  this.icon.y = _loc3_;
                  this.glow.y = _loc3_ - (_loc2_ - _loc1_ >> 1);
                  this.icon.x = width - this.icon.width >> 1;
                  this.glow.x = width - this.glow.width >> 1;
               }
               this.title.y = _loc3_ + _loc1_ + ICON_BOTTOM | 0;
               this.content.y = this.title.y + this.title.textHeight + TEXT_GAP | 0;
               this.divider.y = this.content.y + this.content.textHeight + DELIVER_TOP | 0;
               this.buyBtn.y = this.backBtn.y = this.divider.y + BTN_TOP | 0;
               this.title.x = width - this.title.width >> 1;
               this.content.x = width - this.content.width >> 1;
               this.divider.x = width - this.divider.width >> 1;
               this.buyBtn.x = width - this.buyBtn.width - this.backBtn.width - BTN_GAP >> 1;
               this.backBtn.x = this.buyBtn.x + this.buyBtn.width + BTN_GAP | 0;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.mouseEnabled = this.bg.mouseChildren = false;
         closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         App.utils.universalBtnStyles.setStyle(this.buyBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
         App.utils.universalBtnStyles.setStyle(this.backBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
         this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.bg = null;
         this.title = null;
         this.content = null;
         this.icon = null;
         this.divider = null;
         this.glow = null;
         this.buyBtn.dispose();
         this.buyBtn = null;
         this.backBtn.dispose();
         this.backBtn = null;
         this._data = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      override protected function setData(param1:EventProgressionBuyConfirmVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         onBackS();
      }
      
      private function onBuyBtnClickHandler(param1:ButtonEvent) : void
      {
         onBuyS();
      }
   }
}

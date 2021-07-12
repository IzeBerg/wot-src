package net.wg.gui.lobby.rankedBattles19.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Fonts;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattlesPageHeader extends UIComponentEx
   {
      
      private static const SEPARATOR_H_GAP:int = 15;
      
      private static const LEFT_SIDE_TF_WIDTH_FACTOR:int = 2;
      
      private static const DESCR_GAPS:Object = {};
      
      private static const SEPARATOR_V_GAPS:Object = {};
      
      private static const SEPARATOR_HEIGHTS:Object = {};
      
      private static const TITLE_FORMATS:Object = {};
      
      private static const DESCR_FORMATS:Object = {};
      
      {
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 91;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 70;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 70;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 52;
         SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 8;
         SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 8;
         SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 5;
         SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 5;
         SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 20;
         SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 20;
         SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 18;
         SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 18;
         TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = new TextFormat(Fonts.TITLE_FONT,73,15921911);
         TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_BIG] = new TextFormat(Fonts.TITLE_FONT,56,15921911);
         TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = new TextFormat(Fonts.TITLE_FONT,56,15921911);
         TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = new TextFormat(Fonts.TITLE_FONT,45,15921911);
         DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = new TextFormat(Fonts.FIELD_FONT,24,15921911);
         DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_BIG] = new TextFormat(Fonts.FIELD_FONT,24,15921911);
         DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = new TextFormat(Fonts.FIELD_FONT,18,15921911);
         DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = new TextFormat(Fonts.FIELD_FONT,18,15921911);
      }
      
      public var titleTf:TextField = null;
      
      public var rightSideTf:TextField = null;
      
      public var leftSideTf:TextField = null;
      
      public var separator:Sprite = null;
      
      private var _data:RankedBattlesPageHeaderVO = null;
      
      private var _commons:ICommons = null;
      
      private var _size:String = "small";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _headerHeight:int = -1;
      
      public function RankedBattlesPageHeader()
      {
         super();
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTf.text = this._data.title;
               this.leftSideTf.text = this._data.leftSideText;
               this.rightSideTf.visible = this.separator.visible = !this._data.useOneSideDescription;
               if(this.rightSideTf.visible)
               {
                  this.rightSideTf.text = this._data.rightSideText;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updateLayout();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.titleTf = null;
         this.rightSideTf = null;
         this.leftSideTf = null;
         this.separator = null;
         this._commons = null;
         this._tooltipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:RankedBattlesPageHeaderVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setSizeId(param1:String) : void
      {
         if(this._size != param1)
         {
            this._size = param1;
            invalidateSize();
         }
      }
      
      private function updateLayout() : void
      {
         var _loc4_:int = 0;
         var _loc1_:TextFormat = DESCR_FORMATS[this._size];
         var _loc2_:Boolean = this._data.useOneSideDescription;
         this.titleTf.setTextFormat(TITLE_FORMATS[this._size]);
         this._commons.updateTextFieldSize(this.titleTf);
         this.titleTf.x = width - this.titleTf.width >> 1;
         this.leftSideTf.multiline = this.leftSideTf.wordWrap = _loc2_;
         _loc1_.align = !!_loc2_ ? TextFormatAlign.CENTER : TextFormatAlign.LEFT;
         this.leftSideTf.setTextFormat(_loc1_);
         if(_loc2_)
         {
            this.leftSideTf.width = LEFT_SIDE_TF_WIDTH_FACTOR * this.titleTf.width;
            this._commons.updateTextFieldSize(this.leftSideTf,false,true);
         }
         else
         {
            this._commons.updateTextFieldSize(this.leftSideTf);
         }
         var _loc3_:int = this.titleTf.y + DESCR_GAPS[this._size];
         this.leftSideTf.y = _loc3_;
         if(_loc2_)
         {
            this.leftSideTf.x = width - this.leftSideTf.width >> 1;
         }
         else
         {
            _loc4_ = this.leftSideTf.width + (SEPARATOR_H_GAP << 1);
            this.rightSideTf.y = _loc3_;
            this.rightSideTf.setTextFormat(_loc1_);
            this._commons.updateTextFieldSize(this.rightSideTf);
            _loc4_ += this.rightSideTf.width;
            this.rightSideTf.x = width - _loc4_ >> 1;
            this.separator.x = this.rightSideTf.x + this.rightSideTf.width + SEPARATOR_H_GAP | 0;
            this.separator.y = _loc3_ + SEPARATOR_V_GAPS[this._size];
            this.separator.height = SEPARATOR_HEIGHTS[this._size];
            this.leftSideTf.x = this.separator.x + SEPARATOR_H_GAP;
         }
         this._headerHeight = this.leftSideTf.y + this.leftSideTf.height;
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get height() : Number
      {
         return this._headerHeight;
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._data && this._data.tooltip)
         {
            this._tooltipMgr.showSpecial(this._data.tooltip,null,null);
         }
      }
   }
}

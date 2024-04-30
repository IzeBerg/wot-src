package net.wg.gui.lobby.rankedBattles19.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattlesPageHeader extends UIComponentEx
   {
      
      private static const DESCR_GAPS:Object = {};
      
      private static const TITLE_FORMATS:Object = {};
      
      private static const DESCR_FORMATS:Object = {};
      
      {
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 91;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 70;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 70;
         DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 52;
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
      
      public var extraDescrTf:TextField = null;
      
      private var _data:RankedBattlesPageHeaderVO = null;
      
      private var _hasExtraDescr:Boolean = false;
      
      private var _hasCalendarTooltip:Boolean = false;
      
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
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTf.text = this._data.title;
               this._hasExtraDescr = StringUtils.isNotEmpty(this._data.extraDescr);
               this.extraDescrTf.visible = this._hasExtraDescr;
               if(this._hasExtraDescr)
               {
                  this.extraDescrTf.text = this._data.extraDescr;
               }
               this._hasCalendarTooltip = StringUtils.isNotEmpty(this._data.tooltip) && this._data.tooltip == TOOLTIPS_CONSTANTS.RANKED_CALENDAR_DAY_INFO;
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
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.titleTf = null;
         this.extraDescrTf = null;
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
         this.titleTf.setTextFormat(TITLE_FORMATS[this._size]);
         this._commons.updateTextFieldSize(this.titleTf);
         this.titleTf.x = width - this.titleTf.width >> 1;
         var _loc1_:TextFormat = DESCR_FORMATS[this._size];
         if(this._hasExtraDescr)
         {
            this.extraDescrTf.setTextFormat(_loc1_);
            this._commons.updateTextFieldSize(this.extraDescrTf);
         }
         var _loc2_:int = this.titleTf.y + DESCR_GAPS[this._size];
         if(this._hasExtraDescr)
         {
            this.extraDescrTf.y = _loc2_;
            this.extraDescrTf.x = width - this.extraDescrTf.width >> 1;
            this._headerHeight = _loc2_ + this.extraDescrTf.height;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get height() : Number
      {
         return this._headerHeight;
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data && StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._tooltipMgr.showSpecial(this._data.tooltip,null,null);
         }
      }
   }
}

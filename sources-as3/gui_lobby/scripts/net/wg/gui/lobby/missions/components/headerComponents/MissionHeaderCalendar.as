package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionHeaderCalendar extends UIComponentEx
   {
      
      private static const INV_ICON_VISIBLE:String = "inv_icon_visible";
      
      private static const CALENDAR_TEXT_X:int = 24;
      
      private static const DOTS:String = "...";
      
      private static const MAX_LINE_NUMBER:uint = 2;
       
      
      public var calendarIcon:UILoaderAlt;
      
      public var calendarText:TextField;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _fullText:String = "";
      
      private var _isIconVisible:Boolean = false;
      
      public function MissionHeaderCalendar()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_ICON_VISIBLE))
         {
            if(this._isIconVisible && StringUtils.isEmpty(this.calendarIcon.source))
            {
               this.calendarIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_CALENDAR;
            }
            this.calendarIcon.visible = this._isIconVisible;
            this.calendarText.x = !!this._isIconVisible ? Number(CALENDAR_TEXT_X) : Number(0);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            App.utils.commons.updateTextFieldSize(this.calendarText);
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeTextListeners();
         this.calendarIcon.dispose();
         this.calendarIcon = null;
         this.calendarText = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         var _loc2_:Boolean = false;
         this.removeTextListeners();
         this._fullText = App.utils.commons.cutHtmlText(param1);
         if(this.calendarText.multiline)
         {
            _loc2_ = App.utils.commons.truncateHtmlTextMultiline(this.calendarText,param1,MAX_LINE_NUMBER,DOTS);
            if(_loc2_)
            {
               this.calendarText.addEventListener(MouseEvent.ROLL_OVER,this.onTextRollOverHandler);
               this.calendarText.addEventListener(MouseEvent.ROLL_OUT,this.onTextRollOutHandler);
            }
         }
         else
         {
            this.calendarText.htmlText = param1;
         }
         invalidateSize();
      }
      
      private function removeTextListeners() : void
      {
         this.calendarText.removeEventListener(MouseEvent.ROLL_OVER,this.onTextRollOverHandler);
         this.calendarText.removeEventListener(MouseEvent.ROLL_OUT,this.onTextRollOutHandler);
      }
      
      private function onTextRollOverHandler(param1:MouseEvent) : void
      {
         if(this._fullText != Values.EMPTY_STR)
         {
            this._tooltipMgr.show(this._fullText);
         }
      }
      
      private function onTextRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      override public function get width() : Number
      {
         return this.calendarText.textWidth + (!!this._isIconVisible ? CALENDAR_TEXT_X : 0);
      }
      
      override public function get height() : Number
      {
         return this.calendarText.textHeight;
      }
      
      public function get multiline() : Boolean
      {
         return this.calendarText.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         this.calendarText.multiline = param1;
         this.calendarText.wordWrap = param1;
      }
      
      public function set isIconVisible(param1:Boolean) : void
      {
         this._isIconVisible = param1;
         invalidate(INV_ICON_VISIBLE);
      }
   }
}

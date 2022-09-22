package net.wg.gui.lobby.sessionStats.settings
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsControlsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SessionStatsSettingsControls extends UIComponentEx
   {
      
      public static var APPLY_CLICK:String = "apply_click";
      
      public static var BACKWARD_CLICK:String = "backward_click";
       
      
      public var applyBtn:ISoundButtonEx = null;
      
      public var backwardBtn:ISoundButtonEx = null;
      
      public var lipBg:MovieClip = null;
      
      public var warning:TextField = null;
      
      public var warningIcon:Image = null;
      
      private var _data:SessionStatsSettingsControlsVO = null;
      
      private var _buttons:Array = null;
      
      public function SessionStatsSettingsControls()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.warning.autoSize = TextFieldAutoSize.LEFT;
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.backwardBtn.addEventListener(ButtonEvent.CLICK,this.onBackwardBtnClickHandler);
         this.warningIcon.addEventListener(Event.CHANGE,this.onWarningIconChanged);
         this._buttons = [this.applyBtn,this.backwardBtn];
      }
      
      override protected function onDispose() : void
      {
         this._buttons.splice(0,this._buttons.length);
         this._buttons = null;
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
         this.applyBtn.dispose();
         this.applyBtn = null;
         this.backwardBtn.removeEventListener(ButtonEvent.CLICK,this.onBackwardBtnClickHandler);
         this.backwardBtn.dispose();
         this.backwardBtn = null;
         this.warningIcon.removeEventListener(Event.CHANGE,this.onWarningIconChanged);
         this.warningIcon.dispose();
         this.warningIcon = null;
         this.lipBg = null;
         this.warning = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ISoundButtonEx = null;
         var _loc2_:ButtonPropertiesVO = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.warning.htmlText = this._data.warning.text;
            this.warningIcon.source = this._data.warning.icon;
            _loc3_ = this._buttons.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_ = this._buttons[_loc4_];
               _loc2_ = this._data.states[_loc4_];
               _loc1_.tooltip = _loc2_.btnTooltip;
               _loc1_.label = _loc2_.btnLabel;
               _loc1_.enabled = _loc2_.btnEnabled;
               _loc4_++;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.warningIcon.source != Values.EMPTY_STR)
            {
               _loc5_ = this.width - (this.warningIcon.width + this.warning.width) >> 1;
               this.warningIcon.x = _loc5_;
               this.warning.x = this.warningIcon.width + _loc5_;
            }
         }
      }
      
      private function onWarningIconChanged(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onApplyBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(APPLY_CLICK,true));
      }
      
      private function onBackwardBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(BACKWARD_CLICK,true));
      }
      
      public function setData(param1:SessionStatsSettingsControlsVO) : void
      {
         if(this._data != null)
         {
            this._data.dispose();
         }
         this._data = param1;
         invalidateData();
      }
   }
}

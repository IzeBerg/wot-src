package net.wg.gui.lobby.hangar.wtEvent
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class WTEventEntryPointTextInfo extends MovieClip implements IDisposable
   {
      
      private static const ICON_X_RIGHT_OFFSET:uint = 7;
      
      private static const ICON_X_LEFT_OFFSET:uint = 11;
      
      private static const ICON_Y_SMALL:uint = 72;
      
      private static const ICON_Y_BIG:uint = 104;
      
      private static const TIME_TF_Y_SMALL:uint = 79;
      
      private static const TIME_TF_Y_BIG:uint = 111;
      
      private static const SMALL_TIME_Y_OFFSET:int = -2;
      
      private static const SMALL_TIMER_Y_OFFSET:int = -3;
      
      private static const BIG_TIME_Y_OFFSET:int = -6;
      
      private static const BIG_TIMER_Y_OFFSET:int = -7;
      
      private static const FRAME_SIZE_BIG:String = "big";
      
      private static const FRAME_SIZE_SMALL:String = "small";
      
      private static const FRAME_SIZE_PREF_WIDE:String = "_wide";
       
      
      public var titleTf:TextField = null;
      
      public var timeTf:TextField = null;
      
      public var timeIcon:Sprite = null;
      
      public var hitMc:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      private var _isSmall:Boolean = false;
      
      private var _isWide:Boolean = false;
      
      private var _endDate:String = "";
      
      public function WTEventEntryPointTextInfo()
      {
         super();
         this.hitArea = this.hitMc;
         buttonMode = true;
         this.updateTitle();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.titleTf = null;
         this.timeTf = null;
         this.timeIcon = null;
         this.hitMc = null;
      }
      
      public function updateEndTime(param1:String) : void
      {
         if(this._endDate != param1)
         {
            this._endDate = param1;
            this.updateEndTextAndLayout();
         }
      }
      
      public function updateSize(param1:Boolean, param2:Boolean, param3:Number, param4:Number, param5:Boolean = false) : void
      {
         var _loc6_:String = null;
         if(param5 || this._isSmall != param1 || this._isWide != param2)
         {
            this._isSmall = param1;
            this._isWide = param2;
            _loc6_ = !!this._isSmall ? FRAME_SIZE_SMALL : FRAME_SIZE_BIG;
            _loc6_ += !!this._isWide ? FRAME_SIZE_PREF_WIDE : Values.EMPTY_STR;
            gotoAndStop(_loc6_);
            this.updateTitle();
            this.updateEndTextAndLayout();
         }
         this.hitMc.width = param3;
         this.hitMc.height = param4;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function updateTitle() : void
      {
         this.titleTf.text = this._isSmall && !this._isWide ? "#wt_event:WTEventsEntryWidgetView/title/small" : "#wt_event:WTEventsEntryWidgetView/title";
      }
      
      private function updateEndTextAndLayout() : void
      {
         this.timeTf.text = this._endDate;
         this.timeTf.y = !!this._isSmall ? Number(TIME_TF_Y_SMALL) : Number(TIME_TF_Y_BIG);
         this.timeIcon.y = !!this._isSmall ? Number(ICON_Y_SMALL) : Number(ICON_Y_BIG);
         if(!this._isWide)
         {
            this.timeTf.y += !!this._isSmall ? SMALL_TIME_Y_OFFSET : BIG_TIME_Y_OFFSET;
            this.timeIcon.y += !!this._isSmall ? SMALL_TIMER_Y_OFFSET : BIG_TIMER_Y_OFFSET;
         }
         App.utils.commons.updateTextFieldSize(this.timeTf,true,false);
         this.timeIcon.x = this.titleTf.x + (this.titleTf.width - this.timeIcon.width - this.timeTf.width + ICON_X_RIGHT_OFFSET - ICON_X_LEFT_OFFSET >> 1);
         this.timeTf.x = this.timeIcon.x + this.timeIcon.width - ICON_X_RIGHT_OFFSET;
      }
   }
}

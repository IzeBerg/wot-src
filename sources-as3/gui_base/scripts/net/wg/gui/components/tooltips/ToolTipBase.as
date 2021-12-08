package net.wg.gui.components.tooltips
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IToolTip;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipBase extends UIComponentEx implements IToolTip
   {
      
      public static var COMPONENT_PROFILE_VEHICLE:String = "profileVehicle";
       
      
      public var background:Sprite = null;
      
      public var content:MovieClip = null;
      
      public var contentWidth:Number = 0;
      
      protected var _data:Object = null;
      
      protected var _type:String = "";
      
      protected var _component:String = "";
      
      protected var separators:Vector.<Separator> = null;
      
      protected var contentMargin:Padding;
      
      protected var bgShadowMargin:Padding;
      
      protected var hasIcon:Boolean = false;
      
      protected var leftPartMaxW:Number = 0;
      
      protected var res:Object = null;
      
      protected var topPosition:Number = 0;
      
      protected var _props:ITooltipProps = null;
      
      private var _isRedrawed:Boolean = false;
      
      private var tween:Tween = null;
      
      private var _showDelayIntervalID:Number = 0;
      
      private var _timeStartBuild:Number = 0;
      
      private const CURSOR_OFFSET:Number = 10;
      
      private const BORDER_OFFSET:Number = 15;
      
      private const SHOW_DELAY:Number = 400;
      
      private const LIMIT_BUILD_TIME:Number = 500.0;
      
      public function ToolTipBase()
      {
         this.contentMargin = new Padding(12,17,12,17);
         this.bgShadowMargin = new Padding(3,5,7,5);
         super();
         visible = false;
         alpha = 0;
         this.x = -1000;
         this.y = -1000;
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipBase " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.background = null;
         this.content = null;
         this._data = null;
         this.res = null;
         this._props = null;
         this.bgShadowMargin = null;
         this.contentMargin = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._data && !this._isRedrawed)
         {
            this.redraw();
         }
      }
      
      public function build(param1:Object, param2:ITooltipProps) : void
      {
         this._timeStartBuild = getTimer();
         this.initData(param1);
         this._props = param2;
         this.topPosition = this.bgShadowMargin.top + this.contentMargin.top;
         this.leftPartMaxW = 0;
         if(!this._isRedrawed)
         {
            this.redraw();
         }
      }
      
      public function cleanUp() : void
      {
         this.clearDelayIntervalID();
         this.tryClearTween();
         this.cleaUpSeparators();
         if(this._data)
         {
            App.utils.data.cleanupDynamicObject(this._data);
         }
         this._data = null;
      }
      
      protected function initData(param1:Object) : void
      {
         this._type = param1.type;
         this._component = param1.component;
         this._data = param1.data;
      }
      
      protected function redraw() : void
      {
         this._isRedrawed = true;
         this.updateSize();
         if(this.isBeginShowAfterRedraw)
         {
            this.beginShow();
         }
      }
      
      protected final function beginShow() : void
      {
         this.clearDelayIntervalID();
         var _loc1_:Number = this._props && this._props.drawDelay != -1 ? Number(this._props.drawDelay) : Number(this.SHOW_DELAY);
         var _loc2_:Number = getTimer() - this._timeStartBuild;
         _loc1_ = Math.max(_loc1_ - _loc2_,0);
         this._showDelayIntervalID = setTimeout(this.startShow,_loc1_,this);
         if(_loc2_ > this.LIMIT_BUILD_TIME)
         {
            DebugUtils.LOG_WARNING("Tooltip is going to long time. May be there are too many nested blocks or slow computer performance.");
         }
      }
      
      protected function updateSize() : void
      {
         if(this.contentWidth == 0)
         {
            this.contentWidth = this.content.width;
         }
         this.background.width = this.content.width + this.contentMargin.horizontal + this.bgShadowMargin.horizontal | 0;
         this.background.height = this.content.height + this.contentMargin.vertical + this.bgShadowMargin.vertical | 0;
      }
      
      protected function startShow(... rest) : void
      {
         this.clearDelayIntervalID();
         this.fadeIn();
      }
      
      protected function popSeparator() : void
      {
         var _loc1_:Separator = this.separators.pop();
         this.content.removeChild(_loc1_);
         _loc1_.dispose();
      }
      
      private function cleaUpSeparators() : void
      {
         var _loc1_:Separator = null;
         if(this.separators != null)
         {
            for each(_loc1_ in this.separators)
            {
               this.content.removeChild(_loc1_);
               _loc1_.x = _loc1_.y = 0;
               _loc1_.dispose();
            }
            this.separators.splice(0,this.separators.length);
            this.separators = null;
         }
      }
      
      private function fadeIn() : void
      {
         var _loc1_:Number = App.appWidth;
         var _loc2_:Number = App.appHeight;
         var _loc3_:Number = this._props.x != 0 ? Number(this._props.x) : Number(App.stage.mouseX);
         var _loc4_:Number = this._props.y != 0 ? Number(this._props.y) : Number(App.stage.mouseY);
         _loc3_ += this.CURSOR_OFFSET;
         _loc4_ += this.CURSOR_OFFSET;
         if(_loc4_ + this.actualHeight > _loc2_)
         {
            _loc4_ = _loc4_ - this.actualHeight - this.CURSOR_OFFSET * 2;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = this.BORDER_OFFSET;
         }
         if(_loc3_ + this.actualWidth > _loc1_)
         {
            _loc3_ = _loc3_ - this.actualWidth - this.CURSOR_OFFSET * 2;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = this.BORDER_OFFSET;
         }
         this.x = _loc3_ | 0;
         this.y = _loc4_ | 0;
         this.visible = true;
         this.tryClearTween();
         this.tween = new Tween(100,this,{"alpha":1},{
            "paused":false,
            "onComplete":this.onTweenComplete,
            "ease":Strong.easeInOut
         });
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this.tryClearTween();
      }
      
      private function tryClearTween() : void
      {
         if(this.tween)
         {
            this.tween.paused = true;
            this.tween.dispose();
            this.tween = null;
         }
      }
      
      private function clearDelayIntervalID() : void
      {
         if(this._showDelayIntervalID != 0)
         {
            clearTimeout(this._showDelayIntervalID);
            this._showDelayIntervalID = 0;
         }
      }
      
      protected function set isRedrawed(param1:Boolean) : void
      {
         this._isRedrawed = param1;
      }
      
      protected function get isBeginShowAfterRedraw() : Boolean
      {
         return true;
      }
   }
}

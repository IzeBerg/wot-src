package net.wg.gui.lobby.eventHangar.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventHangar.data.EventDailyRewardVO;
   import net.wg.infrastructure.base.meta.IEventDailyRewardMeta;
   import net.wg.infrastructure.base.meta.impl.EventDailyRewardMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class EventDailyReward extends EventDailyRewardMeta implements IEventDailyRewardMeta
   {
      
      private static const SMALL_FRAME:int = 2;
      
      private static const DEFAULT_FRAME:int = 1;
      
      private static const BUTTON_MIN_WIDTH:int = 85;
      
      private static const LOADER_SMALL_SIZE:int = 48;
      
      private static const LOADER_SIZE:int = 110;
      
      private static const LOADER_SMALL_X:int = 17;
      
      private static const LOADER_SMALL_Y:int = 16;
      
      private static const LOADER_Y:int = -15;
      
      private static const SMALL_BUTTON_PADDING:int = 10;
      
      private static const COUNTER_PROPS_SMALL:CounterProps = new CounterProps(-10,10);
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(-13,13);
       
      
      public var iconLoader:UILoaderAlt = null;
      
      public var background:MovieClip = null;
      
      public var iconGlow:MovieClip = null;
      
      public var textField:TextField = null;
      
      public var button:ISoundButtonEx = null;
      
      public var buttonSmall:ISoundButtonEx = null;
      
      private var _data:EventDailyRewardVO = null;
      
      private var _isSmall:Boolean = false;
      
      private var _forceSmall:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _counterManager:ICounterManager;
      
      private var _emptyHitMC:Sprite;
      
      public function EventDailyReward()
      {
         this._counterManager = App.utils.counterManager;
         this._emptyHitMC = new Sprite();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.focusable = this.buttonSmall.focusable = false;
         this.button.addEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         this.buttonSmall.addEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.textField.text = EVENT.DAILYREWARD_TEXT;
         App.utils.commons.updateTextFieldSize(this.textField,true,false);
         this._toolTipMgr = App.toolTipMgr;
         this.buttonSmall.paddingHorizontal = SMALL_BUTTON_PADDING;
         this.buttonSmall.autoSize = TextFieldAutoSize.LEFT;
         this.buttonSmall.minWidth = BUTTON_MIN_WIDTH;
         this.iconGlow.mouseEnabled = this.iconGlow.mouseChildren = false;
         addChild(this._emptyHitMC);
         this.iconGlow.hitArea = this._emptyHitMC;
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(DisplayObject(this.buttonSmall));
         this._counterManager.removeCounter(DisplayObject(this.button));
         this._counterManager = null;
         this.button.removeEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         this.buttonSmall.removeEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.textField = null;
         this.buttonSmall.dispose();
         this.buttonSmall = null;
         this.button.dispose();
         this.button = null;
         this.background = null;
         this.iconGlow = null;
         this._data = null;
         this._toolTipMgr = null;
         this._emptyHitMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._isSmall || this._forceSmall;
            gotoAndStop(!!_loc1_ ? SMALL_FRAME : DEFAULT_FRAME);
            this.textField.visible = !_loc1_;
            this.buttonSmall.visible = _loc1_;
            this.button.visible = !_loc1_;
            this.iconLoader.x = !!_loc1_ ? Number(LOADER_SMALL_X) : Number(Values.ZERO);
            this.iconLoader.y = !!_loc1_ ? Number(LOADER_SMALL_Y) : Number(LOADER_Y);
            _loc2_ = !!_loc1_ ? int(LOADER_SMALL_SIZE) : int(LOADER_SIZE);
            this.iconLoader.setOriginalWidth(_loc2_);
            this.iconLoader.setOriginalHeight(_loc2_);
            this.iconLoader.updateLoaderSize();
            this.iconGlow.gotoAndStop(!!_loc1_ ? SMALL_FRAME : DEFAULT_FRAME);
            invalidateData();
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.background.gotoAndStop(this._data.phaseIndex);
            this.iconLoader.source = this._data.icon;
            this.iconGlow.visible = this._data.rewardReady;
            this.updateCounter();
            if(this._data.rewardReady)
            {
               this.buttonSmall.label = EVENT.DAILYREWARD_BUTTON_READY;
               this.button.label = EVENT.DAILYREWARD_BUTTON_READY;
            }
            else
            {
               this._counterManager.removeCounter(DisplayObject(this.buttonSmall));
               this._counterManager.removeCounter(DisplayObject(this.button));
               this.buttonSmall.label = EVENT.DAILYREWARD_BUTTON_DETAILS;
               this.button.label = EVENT.DAILYREWARD_BUTTON_DETAILS;
            }
         }
      }
      
      override protected function setData(param1:EventDailyRewardVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param1 <= StageSizeBoundaries.WIDTH_1366;
         if(this._isSmall != _loc3_)
         {
            this._isSmall = _loc3_;
            invalidateSize();
         }
      }
      
      public function forceSmallSize(param1:Boolean) : void
      {
         if(this._forceSmall != param1)
         {
            this._forceSmall = param1;
            invalidateSize();
         }
      }
      
      private function updateCounter() : void
      {
         if(this._data.rewardReady)
         {
            if(this._isSmall || this._forceSmall)
            {
               this._counterManager.removeCounter(DisplayObject(this.button));
               this._counterManager.setCounter(DisplayObject(this.buttonSmall),MENU.HEADER_NOTIFICATIONSIGN,null,COUNTER_PROPS_SMALL);
            }
            else
            {
               this._counterManager.removeCounter(DisplayObject(this.buttonSmall));
               this._counterManager.setCounter(DisplayObject(this.button),MENU.HEADER_NOTIFICATIONSIGN,null,COUNTER_PROPS);
            }
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data || StringUtils.isEmpty(this._data.tooltip))
         {
            return;
         }
         this._toolTipMgr.show(this._data.tooltip);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onBtnClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            onClickS();
         }
      }
   }
}

package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.common.Counter;
   import net.wg.gui.components.controls.ButtonIconLoader;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehPostProgressionBtn extends ButtonIconLoader
   {
      
      private static const ICON_LOCK_Y:int = 4;
      
      private static const CLICK_LOCK_DURATION:int = 500;
      
      private static const ENTRY_POINT_PARENT_SCREEN:String = "hangar";
       
      
      private var _iconLock:Image = null;
      
      private var _intCD:int = -1;
      
      private var _isClickLocked:Boolean = false;
      
      private var _tooltipManager:ITooltipMgr = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _scheduler:IScheduler = null;
      
      public function VehPostProgressionBtn()
      {
         super();
         this._tooltipManager = App.toolTipMgr;
         this._counterManager = App.utils.counterManager;
         this._scheduler = App.utils.scheduler;
         this._iconLock = new Image();
         this._iconLock.mouseEnabled = false;
         this._iconLock.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler);
         iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_PP_ICON;
         this._iconLock.addEventListener(Event.CHANGE,this.onIconLockChangeHandler);
         this._iconLock.source = RES_ICONS.MAPS_ICONS_BUTTONS_PP_LOCK;
         addChild(this._iconLock);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onButtonEventClickHandler);
         this._iconLock.removeEventListener(Event.CHANGE,this.onIconLockChangeHandler);
         this._iconLock.dispose();
         this._iconLock = null;
         this._tooltipManager = null;
         this._counterManager.removeCounter(this);
         this._counterManager = null;
         this._scheduler.cancelTask(this.unlockClick);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this._iconLock.x = width - this._iconLock.width >> 1;
            this._iconLock.y = ICON_LOCK_Y;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function handleRelease(param1:uint = 0) : void
      {
         if(this._isClickLocked)
         {
            return;
         }
         super.handleRelease(param1);
      }
      
      private function unlockClick() : void
      {
         this._isClickLocked = false;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         this._iconLock.visible = !param1;
      }
      
      public function set intCD(param1:int) : void
      {
         this._intCD = param1;
      }
      
      public function set showCounter(param1:Boolean) : void
      {
         var _loc2_:CounterProps = null;
         if(param1)
         {
            _loc2_ = new CounterProps(3,2,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
            this._counterManager.setCounter(this,CounterManager.COUNTER_EMPTY,null,_loc2_);
         }
         else
         {
            this._counterManager.removeCounter(this);
         }
      }
      
      [Event(name="iconLoaded",type="net.wg.infrastructure.events.IconLoaderEvent")]
      override protected function iconLoadingCompleteHandler(param1:Event) : void
      {
         super.iconLoadingCompleteHandler(param1);
         invalidateSize();
      }
      
      override protected function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipManager.showWulfTooltip(TOOLTIPS_CONSTANTS.VEH_POST_PROGRESSION_ENTRY_POINT,this._intCD,ENTRY_POINT_PARENT_SCREEN);
      }
      
      override protected function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipManager.hide();
      }
      
      override protected function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._tooltipManager.hide();
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this._isClickLocked)
         {
            return;
         }
         super.handleMouseRelease(param1);
      }
      
      private function onIconLockChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onButtonEventClickHandler(param1:ButtonEvent) : void
      {
         if(this._isClickLocked)
         {
            return;
         }
         this._isClickLocked = true;
         this._scheduler.scheduleTask(this.unlockClick,CLICK_LOCK_DURATION);
      }
   }
}

package net.wg.gui.lobby.hangar
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.ButtonIconLoader;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehPostProgressionBtn extends ButtonIconLoader
   {
      
      private static const ICON_LOCK_Y:int = 4;
      
      private static const ENTRY_POINT_PARENT_SCREEN:String = "hangar";
       
      
      private var _iconLock:Image = null;
      
      private var _intCD:int = -1;
      
      private var _tooltipManager:ITooltipMgr = null;
      
      private var _counterManager:ICounterManager;
      
      public function VehPostProgressionBtn()
      {
         super();
         this._tooltipManager = App.toolTipMgr;
         this._counterManager = App.utils.counterManager;
         this._iconLock = new Image();
         this._iconLock.mouseEnabled = false;
         this._iconLock.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_PP_ICON;
         this._iconLock.addEventListener(Event.CHANGE,this.onIconLockChangeHandler);
         this._iconLock.source = RES_ICONS.MAPS_ICONS_BUTTONS_PP_LOCK;
         addChild(this._iconLock);
      }
      
      override protected function onDispose() : void
      {
         this._iconLock.removeEventListener(Event.CHANGE,this.onIconLockChangeHandler);
         this._iconLock.dispose();
         this._iconLock = null;
         this._tooltipManager = null;
         this._counterManager.removeCounter(this);
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this._iconLock.x = width - this._iconLock.width >> 1;
            this._iconLock.y = ICON_LOCK_Y;
         }
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
            _loc2_ = new CounterProps(3,-3);
            this._counterManager.setCounter(this,CounterManager.COUNTER_EMPTY,null,_loc2_);
         }
         else
         {
            this._counterManager.removeCounter(this);
         }
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
      
      private function onIconLockChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}

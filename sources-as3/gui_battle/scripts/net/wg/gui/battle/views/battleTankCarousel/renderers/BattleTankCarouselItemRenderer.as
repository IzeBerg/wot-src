package net.wg.gui.battle.views.battleTankCarousel.renderers
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.battle.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleTankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
   {
       
      
      public var content:BaseBattleTankIcon = null;
      
      private var _index:uint = 0;
      
      private var _vehicleData:BattleVehicleCarouselVO = null;
      
      private var _isClickEnabled:Boolean = false;
      
      private var _isViewPortEnabled:Boolean = true;
      
      private var _isInteractive:Boolean = false;
      
      public function BattleTankCarouselItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.content.cacheAsBitmap = true;
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.content.dispose();
         this.content = null;
         this._vehicleData = null;
         _owner = null;
         super.onDispose();
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      protected function updateData() : void
      {
         var _loc1_:Boolean = this._vehicleData != null;
         if(_loc1_)
         {
            mouseEnabledOnDisabled = true;
            this._isClickEnabled = this._vehicleData.enabled;
         }
         else
         {
            this._isClickEnabled = false;
            mouseEnabledOnDisabled = false;
         }
         this.updateInteractiveState();
         this.content.setData(this._vehicleData);
      }
      
      private function updateInteractiveState() : void
      {
         this._isInteractive = this._isViewPortEnabled && this._isClickEnabled;
         this.enabled = this._isInteractive;
         this.content.enabled = this._isInteractive;
      }
      
      private function addListeners() : void
      {
         addEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function removeListeners() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this._vehicleData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._vehicleData != null)
         {
            this._vehicleData.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
            this._vehicleData = null;
         }
         if(param1 != null)
         {
            this._vehicleData = BattleVehicleCarouselVO(param1);
            this._vehicleData.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
         }
         this.updateData();
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
         if(this._isViewPortEnabled == param1)
         {
            return;
         }
         this._isViewPortEnabled = param1;
         this.updateInteractiveState();
      }
      
      private function onSlotMouseClickHandler(param1:Event) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         if(!this._isInteractive)
         {
            return;
         }
         if(this._vehicleData != null)
         {
            _loc2_ = param1 as MouseEventEx;
            _loc3_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
            if(!selected && _loc3_ == MouseEventEx.LEFT_BUTTON)
            {
               if(this._isClickEnabled)
               {
                  _loc4_ = TankItemEvent.SELECT_ITEM;
                  dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
               }
               dispatchEvent(new TankItemEvent(_loc4_,this._index));
            }
         }
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
   }
}

package net.wg.gui.battle.comp7.views.battleTankCarousel.renderers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.comp7.views.battleTankCarousel.data.BattleVehicleCarouselVO;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleTankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
   {
       
      
      public var content:BaseBattleTankIcon = null;
      
      public var border:Sprite = null;
      
      public var hoverBg:Sprite = null;
      
      public var flagLoader:UILoaderAlt = null;
      
      public var tankIcon:UILoaderAlt = null;
      
      private var _index:uint = 0;
      
      private var _vehicleData:BattleVehicleCarouselVO = null;
      
      private var _isClickEnabled:Boolean = false;
      
      private var _isViewPortEnabled:Boolean = true;
      
      private var _isInteractive:Boolean = false;
      
      private var _rowCount:int = 0;
      
      public function BattleTankCarouselItemRenderer()
      {
         super();
         preventAutosizing = true;
         constraintsDisabled = true;
         useHtmlText = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.content.cacheAsBitmap = true;
         this.border.mouseEnabled = false;
         this.border.mouseChildren = false;
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.content.dispose();
         this.content = null;
         textField = null;
         this._vehicleData = null;
         _owner = null;
         this.border = null;
         this.hoverBg = null;
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
            this.updateFlag();
            this.updateTankIcon();
            this._isClickEnabled = this._vehicleData.enabled;
            label = this._vehicleData.vehicleName;
         }
         else
         {
            this._isClickEnabled = false;
            label = Values.EMPTY_STR;
         }
         this.flagLoader.visible = textField.visible = this.tankIcon.visible = _loc1_;
         this.updateInteractiveState();
         this.content.setData(this._vehicleData);
      }
      
      protected function updateTankIcon() : void
      {
         this.tankIcon.source = this.data.vehicleIcon;
      }
      
      protected function updateFlag() : void
      {
         this.flagLoader.source = this.data.flagIcon;
      }
      
      private function updateInteractiveState() : void
      {
         this._isInteractive = this._isViewPortEnabled && this._isClickEnabled;
         this.enabled = this._isInteractive;
         this.content.enabled = this._isInteractive;
         alpha = !!this._isInteractive ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
      }
      
      private function addListeners() : void
      {
         addEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function removeListeners() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         buttonMode = useHandCursor = param1;
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
      
      public function get rowsCount() : int
      {
         return this._rowCount;
      }
      
      public function set rowsCount(param1:int) : void
      {
         this._rowCount = param1;
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
      
      private function onSlotMouseClickHandler(param1:Event) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
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
                  dispatchEvent(new TankItemEvent(TankItemEvent.SELECT_ITEM,this._index));
               }
            }
         }
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
   }
}

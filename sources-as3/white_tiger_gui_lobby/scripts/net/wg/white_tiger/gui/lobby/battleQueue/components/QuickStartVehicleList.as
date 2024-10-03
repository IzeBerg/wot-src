package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelHunterInfoVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.events.QuickStartEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuickStartVehicleList extends UIComponentEx
   {
      
      private static const ITEM_LINKAGE:String = "QuickStartVehicleRendererUI";
      
      private static const GAP_BIG:int = 12;
      
      private static const GAP_SMALL:int = 8;
       
      
      private var _isSmall:Boolean = false;
      
      private var _renderers:Vector.<QuickStartVehicleRenderer>;
      
      private var _items:Vector.<QuickStartPanelHunterInfoVO> = null;
      
      private var _selectedVehicleData:QuickStartPanelHunterInfoVO = null;
      
      public function QuickStartVehicleList()
      {
         this._renderers = new Vector.<QuickStartVehicleRenderer>(0);
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(QuickStartEvent.VEHICLE_SELECTED,this.onQuickStartVehicleSelected);
         this.clearRenderers();
         if(this._items != null)
         {
            this._items.length = 0;
            this._items = null;
         }
         this._selectedVehicleData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(QuickStartEvent.VEHICLE_SELECTED,this.onQuickStartVehicleSelected);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:QuickStartPanelHunterInfoVO = null;
         var _loc4_:QuickStartVehicleRenderer = null;
         super.draw();
         if(this._items)
         {
            _loc1_ = isInvalid(InvalidationType.SIZE);
            if(isInvalid(InvalidationType.DATA))
            {
               while(_loc2_ < this._items.length)
               {
                  _loc3_ = this._items[_loc2_];
                  _loc4_ = _loc2_ < this._renderers.length ? this._renderers[_loc2_] : this.createRenderer();
                  _loc4_.data = _loc3_;
                  _loc4_.isSmall = this._isSmall;
                  _loc2_++;
               }
               _loc1_ = true;
            }
            if(isInvalid(InvalidationType.STATE))
            {
               this.updateRenderersState();
               _loc1_ = true;
            }
            if(_loc1_)
            {
               this.updateLayout();
            }
         }
      }
      
      public function setItems(param1:Vector.<QuickStartPanelHunterInfoVO>) : void
      {
         this._selectedVehicleData = null;
         this._items = param1;
         invalidateData();
      }
      
      private function createRenderer() : QuickStartVehicleRenderer
      {
         var _loc1_:QuickStartVehicleRenderer = App.utils.classFactory.getComponent(ITEM_LINKAGE,QuickStartVehicleRenderer);
         addChild(_loc1_);
         this._renderers.push(_loc1_);
         return _loc1_;
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:QuickStartVehicleRenderer = null;
         for each(_loc1_ in this._renderers)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._renderers.length = 0;
      }
      
      private function updateLayout() : void
      {
         var _loc3_:QuickStartVehicleRenderer = null;
         var _loc1_:int = 0;
         var _loc2_:int = !!this._isSmall ? int(GAP_SMALL) : int(GAP_BIG);
         for each(_loc3_ in this._renderers)
         {
            _loc3_.x = _loc1_;
            _loc1_ += _loc3_.width + _loc2_;
         }
      }
      
      private function updateRenderersState() : void
      {
         var _loc1_:QuickStartVehicleRenderer = null;
         for each(_loc1_ in this._renderers)
         {
            if(_loc1_.data != this._selectedVehicleData)
            {
               _loc1_.state = QuickStartVehicleRenderer.STATE_NORMAL;
            }
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         var _loc2_:QuickStartVehicleRenderer = null;
         if(param1 != this._isSmall)
         {
            this._isSmall = param1;
            for each(_loc2_ in this._renderers)
            {
               _loc2_.isSmall = param1;
            }
            invalidateSize();
         }
      }
      
      public function get selectedVehicle() : QuickStartPanelHunterInfoVO
      {
         return this._selectedVehicleData;
      }
      
      private function onQuickStartVehicleSelected(param1:QuickStartEvent) : void
      {
         var _loc2_:QuickStartVehicleRenderer = QuickStartVehicleRenderer(param1.target);
         this._selectedVehicleData = _loc2_.data;
         invalidateState();
      }
   }
}

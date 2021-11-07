package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import net.wg.data.VO.FilterDAAPIDataProvider;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.carousels.interfaces.IFilterCounter;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.infrastructure.base.meta.ICarouselEnvironmentMeta;
   import net.wg.infrastructure.base.meta.impl.CarouselEnvironmentMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class CarouselEnvironment extends CarouselEnvironmentMeta implements ICarouselEnvironmentMeta, IDAAPIModule
   {
       
      
      public var filterCounter:IFilterCounter = null;
      
      private var _dataProvider:FilterDAAPIDataProvider = null;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function CarouselEnvironment()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.filterCounter.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFilterCounterResetAllFiltersHandler);
         addEventListener(TankItemEvent.SELECT_ITEM,this.onSelectItemHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(TankItemEvent.SELECT_ITEM,this.onSelectItemHandler);
         this.filterCounter.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFilterCounterResetAllFiltersHandler);
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this.filterCounter.dispose();
         this.filterCounter = null;
         this._dataProvider = null;
         super.onDispose();
      }
      
      public function as_blinkCounter() : void
      {
         this.filterCounter.blink();
      }
      
      public function as_dispose() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
         dispose();
         this._disposed = true;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
      }
      
      public function as_getDataProvider() : Object
      {
         if(scrollList.dataProvider == null)
         {
            this._dataProvider = new FilterDAAPIDataProvider(this.getRendererVo());
            scrollList.dataProvider = this._dataProvider;
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         }
         return this._dataProvider;
      }
      
      public function as_hideCounter() : void
      {
         this.filterCounter.hide();
      }
      
      public function as_populate() : void
      {
         this._isDAAPIInited = true;
      }
      
      public function as_setEnabled(param1:Boolean) : void
      {
         scrollList.enabled = param1;
         enabled = param1;
      }
      
      public function as_setInitData(param1:Object) : void
      {
         this.filterCounter.setCloseButtonTooltip(param1.counterCloseTooltip);
      }
      
      public function as_showCounter(param1:String, param2:Boolean) : void
      {
         this.filterCounter.setCount(param1,param2);
      }
      
      protected function updateSelectedIndex() : void
      {
         selectedIndex = this._dataProvider.getDAAPIselectedIdx();
      }
      
      protected function getRendererVo() : Class
      {
         return VehicleCarouselVO;
      }
      
      protected function goToSelectedItem() : void
      {
         if(selectedIndex < 0)
         {
            goToItem(0);
         }
         else
         {
            goToItem(selectedIndex,true);
         }
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onFilterCounterResetAllFiltersHandler(param1:Event) : void
      {
         resetFiltersS();
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         this.updateSelectedIndex();
      }
      
      private function onSelectItemHandler(param1:TankItemEvent) : void
      {
         selectVehicleS(param1.itemId);
      }
   }
}

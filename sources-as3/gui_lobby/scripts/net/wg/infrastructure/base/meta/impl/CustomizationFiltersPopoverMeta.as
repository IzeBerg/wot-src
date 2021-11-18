package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
   import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationFiltersPopoverMeta extends PopoverWithDropdown
   {
       
      
      public var changeGroup:Function;
      
      public var setDefaultFilter:Function;
      
      public var setShowOnlyHistoric:Function;
      
      public var setShowOnlyAcquired:Function;
      
      public var setHideOnAnotherVeh:Function;
      
      public var setShowOnlyProgressionDecals:Function;
      
      public var setShowOnlyEditableStyles:Function;
      
      public var onFilterChange:Function;
      
      public var onFormChange:Function;
      
      private var _filtersPopoverVO:FiltersPopoverVO;
      
      public function CustomizationFiltersPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._filtersPopoverVO)
         {
            this._filtersPopoverVO.dispose();
            this._filtersPopoverVO = null;
         }
         super.onDispose();
      }
      
      public function changeGroupS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeGroup,"changeGroup" + Errors.CANT_NULL);
         this.changeGroup(param1);
      }
      
      public function setDefaultFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.setDefaultFilter,"setDefaultFilter" + Errors.CANT_NULL);
         this.setDefaultFilter();
      }
      
      public function setShowOnlyHistoricS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setShowOnlyHistoric,"setShowOnlyHistoric" + Errors.CANT_NULL);
         this.setShowOnlyHistoric(param1);
      }
      
      public function setShowOnlyAcquiredS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setShowOnlyAcquired,"setShowOnlyAcquired" + Errors.CANT_NULL);
         this.setShowOnlyAcquired(param1);
      }
      
      public function setHideOnAnotherVehS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setHideOnAnotherVeh,"setHideOnAnotherVeh" + Errors.CANT_NULL);
         this.setHideOnAnotherVeh(param1);
      }
      
      public function setShowOnlyProgressionDecalsS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setShowOnlyProgressionDecals,"setShowOnlyProgressionDecals" + Errors.CANT_NULL);
         this.setShowOnlyProgressionDecals(param1);
      }
      
      public function setShowOnlyEditableStylesS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setShowOnlyEditableStyles,"setShowOnlyEditableStyles" + Errors.CANT_NULL);
         this.setShowOnlyEditableStyles(param1);
      }
      
      public function onFilterChangeS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFilterChange,"onFilterChange" + Errors.CANT_NULL);
         this.onFilterChange(param1,param2);
      }
      
      public function onFormChangeS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFormChange,"onFormChange" + Errors.CANT_NULL);
         this.onFormChange(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:FiltersPopoverVO = this._filtersPopoverVO;
         this._filtersPopoverVO = new FiltersPopoverVO(param1);
         this.setData(this._filtersPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:FiltersPopoverVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}

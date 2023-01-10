package net.wg.gui.lobby.components
{
   import flash.events.Event;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.base.ButtonFiltersBase;
   import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
   import scaleform.clik.controls.Button;
   
   public class ButtonFilters extends ButtonFiltersBase
   {
      
      private static const BUTTON_WIDTH:int = 40;
       
      
      public function ButtonFilters()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         buttonFiltersGroup.removeEventListener(Event.CHANGE,this.onFiltersGroupChangeHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonFiltersGroup.addEventListener(Event.CHANGE,this.onFiltersGroupChangeHandler);
      }
      
      override protected function applyDataToButton(param1:Button, param2:ButtonFiltersItemVO) : void
      {
         var _loc3_:BlackButton = BlackButton(param1);
         _loc3_.toggleEnable = true;
         _loc3_.iconSource = param2.icon;
         _loc3_.tooltip = param2.tooltip;
         _loc3_.mouseEnabledOnDisabled = true;
         _loc3_.dynamicSizeByText = true;
         _loc3_.width = BUTTON_WIDTH;
         param1.data = param2;
         param1.selected = param2.selected;
         param1.label = param2.label;
         if(param2.selected)
         {
            filterState |= param2.filterValue;
         }
      }
      
      protected function onSelectionChange() : void
      {
         var _loc2_:ButtonFiltersItemVO = null;
         var _loc3_:Button = null;
         var _loc1_:Vector.<Button> = buttonFiltersGroup.getSelectedButtons();
         filterState = 0;
         for each(_loc3_ in _loc1_)
         {
            _loc2_ = ButtonFiltersItemVO(_loc3_.data);
            filterState |= _loc2_.filterValue;
         }
         _loc1_.splice(0,_loc1_.length);
         dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,filtersValue));
      }
      
      private function onFiltersGroupChangeHandler(param1:Event) : void
      {
         this.onSelectionChange();
      }
   }
}

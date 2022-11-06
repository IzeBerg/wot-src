package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.base.ButtonFiltersBase;
   import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   
   public class SlotButtonFilters extends ButtonFiltersBase
   {
      
      private static const FILTERS_TILE_WIDTH:int = 32;
      
      private static const ERROR_MSG:String = "ButtonFiltersItemVO can`t be null.";
       
      
      public function SlotButtonFilters()
      {
         super();
      }
      
      override public function resetFilters(param1:int) : void
      {
         super.resetFilters(param1);
         filterState = param1;
      }
      
      public function getButtonAt(param1:int) : Button
      {
         return buttonFiltersGroup.getButtonAt(param1);
      }
      
      public function get length() : uint
      {
         return buttonFiltersGroup.length;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         super.onDispose();
      }
      
      override protected function applyDataToButton(param1:Button, param2:ButtonFiltersItemVO) : void
      {
         var _loc3_:BlackButton = null;
         _loc3_ = BlackButton(param1);
         _loc3_.toggleEnable = true;
         _loc3_.toggle = false;
         _loc3_.iconSource = param2.icon;
         _loc3_.tooltip = param2.tooltip;
         _loc3_.mouseEnabledOnDisabled = true;
         _loc3_.width = FILTERS_TILE_WIDTH;
         param1.data = param2;
         param1.selected = param2.selected;
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc3_:ButtonFiltersItemVO = null;
         var _loc2_:Button = Button(param1.target);
         if(_loc2_.data)
         {
            _loc3_ = ButtonFiltersItemVO(_loc2_.data);
            dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,filtersValue ^ _loc3_.filterValue,true));
         }
         else
         {
            DebugUtils.LOG_ERROR(ERROR_MSG);
         }
      }
   }
}

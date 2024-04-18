package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import net.wg.gui.components.controls.SortableScrollingList;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class TechniqueList extends SortableScrollingList
   {
      
      public static const SELECTED_INDEX_CHANGE:String = "selectedIndexChange";
      
      public static const NO_SELECTION_VALUE:int = -1;
       
      
      private var _selectedVehicleId:int = -1;
      
      public function TechniqueList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
      }
      
      override protected function refreshData() : void
      {
         selectedIndex = Math.max(this.getVehicleIndexByID(this._selectedVehicleId),0);
         updateSelectedIndex();
         super.refreshData();
         var _loc1_:TechniqueListVehicleVO = getSelectedVO() as TechniqueListVehicleVO;
         if(_loc1_ == null || _loc1_.id != this._selectedVehicleId)
         {
            dispatchEvent(new Event(SELECTED_INDEX_CHANGE));
         }
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:int = rowHeight;
         var _loc3_:int = availableWidth - padding.horizontal;
         var _loc4_:int = margin + padding.left;
         var _loc5_:int = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_ + _loc7_ * _loc2_;
            _loc8_.width = _loc3_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
         super.onDispose();
      }
      
      public function getVehicleIndexByID(param1:int) : int
      {
         var _loc2_:TechniqueListVehicleVO = null;
         var _loc4_:int = 0;
         var _loc3_:uint = dataProvider.length;
         if(param1 != -1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = dataProvider[_loc4_];
               if(param1 == _loc2_.id)
               {
                  return _loc4_;
               }
               _loc4_++;
            }
         }
         return NO_SELECTION_VALUE;
      }
      
      public function selectedVehicleById(param1:int) : void
      {
         this._selectedVehicleId = param1;
      }
      
      public function get selectedItem() : Object
      {
         if(dataProvider && dataProvider.length > 0)
         {
            return dataProvider[selectedIndex];
         }
         return null;
      }
      
      private function onIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:TechniqueListVehicleVO = getSelectedVO() as TechniqueListVehicleVO;
         if(_loc2_ && _loc2_.id != this._selectedVehicleId)
         {
            this._selectedVehicleId = _loc2_.id;
            dispatchEvent(new Event(SELECTED_INDEX_CHANGE));
         }
      }
   }
}

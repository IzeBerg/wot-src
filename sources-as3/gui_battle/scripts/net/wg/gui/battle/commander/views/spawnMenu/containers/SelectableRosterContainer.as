package net.wg.gui.battle.commander.views.spawnMenu.containers
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.RTS_SPAWN_MENU_ENTRY_TYPES;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.BaseRosterVO;
   import net.wg.gui.battle.commander.views.spawnMenu.events.EntryEvent;
   import net.wg.gui.battle.commander.views.spawnMenu.items.DragItem;
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   
   public class SelectableRosterContainer extends RosterContainer
   {
       
      
      public var mapButtons:MapButtons = null;
      
      private var _dragItem:DragItem = null;
      
      private var _autoSetBtnText:String;
      
      private var _resetBtnText:String;
      
      public function SelectableRosterContainer()
      {
         super();
         this._dragItem = classFactory.getComponent(Linkages.SPAWN_MENU_DRAG_ITEM,DragItem);
      }
      
      override protected function onDispose() : void
      {
         this.mapButtons.dispose();
         this.mapButtons = null;
         this._dragItem.dispose();
         this._dragItem = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.setButtonsLabels(this._autoSetBtnText,this._resetBtnText);
            this.mapButtons.validateNow();
            detailsTF.visible = false;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateDragItem();
            detailsTF.visible = false;
         }
      }
      
      override protected function onStageUpdated() : void
      {
         this.mapButtons.updateStage(_currentStage);
      }
      
      public function setButtonsLabels(param1:String, param2:String) : void
      {
         this._autoSetBtnText = param1;
         this._resetBtnText = param2;
         this.mapButtons.setLabels(this._autoSetBtnText,this._resetBtnText);
      }
      
      public function setIsAutoSetBtnEnabled(param1:Boolean) : void
      {
         this.mapButtons.isAutoSetBtnEnabled = param1;
      }
      
      public function setIsResetBtnEnabled(param1:Boolean) : void
      {
         this.mapButtons.isResetBtnEnabled = param1;
      }
      
      private function updateDragItem() : void
      {
         var _loc1_:BaseRosterVO = null;
         for each(_loc1_ in tanksData)
         {
            if(_loc1_.isDragged)
            {
               this._dragItem.attach(_loc1_);
               return;
            }
         }
         for each(_loc1_ in suppliesData)
         {
            if(_loc1_.isDragged)
            {
               this._dragItem.attach(_loc1_);
               return;
            }
         }
         this._dragItem.detach();
      }
      
      public function onEntryEvent(param1:EntryEvent) : void
      {
         var _loc2_:Object = null;
         switch(param1.entryType)
         {
            case RTS_SPAWN_MENU_ENTRY_TYPES.ALLY_VEHICLE:
               _loc2_ = tankRenderers;
               break;
            case RTS_SPAWN_MENU_ENTRY_TYPES.SUPPLY:
               _loc2_ = supplyRenderers;
         }
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:SelectableItem = _loc2_[param1.itemID];
         if(!_loc3_)
         {
            return;
         }
         switch(param1.type)
         {
            case EntryEvent.FOCUS:
               _loc3_.isFocused = param1.value;
               break;
            case EntryEvent.SELECT:
               _loc3_.isSelected = param1.value;
         }
      }
      
      public function get dragItem() : DragItem
      {
         return this._dragItem;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         if(!param1)
         {
            this._dragItem.detach();
         }
      }
   }
}

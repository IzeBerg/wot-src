package net.wg.gui.rally.views.list
{
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
   import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallyListItemVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.infrastructure.base.meta.IBaseRallyListViewMeta;
   import net.wg.infrastructure.base.meta.impl.BaseRallyListViewMeta;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.gfx.MouseEventEx;
   
   public class BaseRallyListView extends BaseRallyListViewMeta implements IBaseRallyListViewMeta
   {
       
      
      public var rallyTable:SortableTable = null;
      
      public var detailsSection:SimpleRallyDetailsSection = null;
      
      protected var listDataProvider:SortableVoDAAPIDataProvider = null;
      
      public function BaseRallyListView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         if(this.rallyTable)
         {
            this.rallyTable.listSelectedIndex = -1;
         }
         super.configUI();
         if(this.rallyTable)
         {
            this.rallyTable.listDP = this.listDataProvider;
            this.listDataProvider.addEventListener(ManualSearchEvent.DATA_UPDATED,this.onDataUpdatedHandler,false,0,true);
            this.rallyTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onListIndexChangeHandler);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onRendererDoubleClickHandler);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_ROLL_OVER,this.onRendererRollOverHandler);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_ROLL_OUT,this.onRendererRollOutHandler);
            this.rallyTable.addEventListener(SortableTableListEvent.RENDERER_PRESS,this.onRendererPressHandler);
         }
         if(this.detailsSection)
         {
            this.detailsSection.addEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRallyRequestHandler);
            this.detailsSection.addEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onAssignSlotRequestHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.rallyTable)
         {
            this.listDataProvider.removeEventListener(ManualSearchEvent.DATA_UPDATED,this.onDataUpdatedHandler);
            this.listDataProvider = null;
            this.rallyTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onListIndexChangeHandler);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onRendererDoubleClickHandler);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_ROLL_OVER,this.onRendererRollOverHandler);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_ROLL_OUT,this.onRendererRollOutHandler);
            this.rallyTable.removeEventListener(SortableTableListEvent.RENDERER_PRESS,this.onRendererPressHandler);
            this.rallyTable.dispose();
            this.rallyTable = null;
         }
         if(this.detailsSection)
         {
            this.detailsSection.removeEventListener(RallyViewsEvent.JOIN_RALLY_REQUEST,this.onJoinRallyRequestHandler);
            this.detailsSection.removeEventListener(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.onAssignSlotRequestHandler);
            this.detailsSection.dispose();
            this.detailsSection = null;
         }
         App.utils.scheduler.cancelTask(this.requestRallyData);
         super.onDispose();
      }
      
      public function as_getSearchDP() : Object
      {
         return this.listDataProvider;
      }
      
      public function as_selectByID(param1:Number) : void
      {
         var _loc2_:IRallyListItemVO = null;
         for each(_loc2_ in this.rallyTable.listDP)
         {
            if(_loc2_.mgrID == param1)
            {
               this.rallyTable.listSelectedIndex = this.rallyTable.listDP.indexOf(_loc2_);
               getRallyDetailsS(_loc2_.rallyIndex);
               return;
            }
         }
         this.detailsSection.setData(null);
         this.rallyTable.listSelectedIndex = -1;
      }
      
      public function as_selectByIndex(param1:int) : void
      {
         var _loc2_:Boolean = false;
         if(this.rallyTable.listSelectedIndex != param1)
         {
            this.rallyTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onListIndexChangeHandler);
            if(param1 == -1 && this.rallyTable.listDP && this.rallyTable.listDP.length > this.rallyTable.listSelectedIndex && this.rallyTable.listSelectedIndex > -1 || this.rallyTable.listSelectedIndex == 0 && param1 <= 0)
            {
               param1 = this.rallyTable.listSelectedIndex;
               _loc2_ = true;
            }
            this.rallyTable.listSelectedIndex = param1;
            this.rallyTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onListIndexChangeHandler);
         }
         if(_loc2_)
         {
            this.requestRallyData(param1);
         }
      }
      
      public function as_setDetails(param1:Object) : void
      {
         this.detailsSection.setData(param1 != null ? this.convertToRallyVO(param1) : null);
      }
      
      public function as_setVehiclesTitle(param1:String) : void
      {
         this.detailsSection.vehiclesLabel = param1;
      }
      
      protected function convertToRallyVO(param1:Object) : IRallyVO
      {
         return null;
      }
      
      protected function getRallyTooltipLinkage() : String
      {
         return null;
      }
      
      protected function getRallyTooltipData(param1:IRallyListItemVO) : Object
      {
         return param1.mgrID;
      }
      
      protected function requestRallyData(param1:int) : void
      {
         var _loc2_:Object = getRallyDetailsS(param1);
      }
      
      private function updateData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:IUpdatable = null;
         var _loc2_:int = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = param1[_loc6_];
            _loc3_ = _loc4_[0];
            _loc5_ = this.rallyTable.getRendererAt(_loc3_,this.rallyTable.scrollPosition) as IUpdatable;
            if(_loc5_)
            {
               _loc5_.update(_loc4_[1]);
            }
            _loc6_++;
         }
      }
      
      protected function itemRollOverPerformer(param1:SortableTableListEvent = null) : void
      {
         var _loc2_:IRallyListItemVO = param1.itemData as IRallyListItemVO;
         if(_loc2_ != null)
         {
            App.toolTipMgr.showSpecial(this.getRallyTooltipLinkage(),null,this.getRallyTooltipData(_loc2_));
         }
      }
      
      protected function joinRallyRequestPerformer(param1:RallyViewsEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:IRallyListItemVO = this.rallyTable.getListSelectedItem() as IRallyListItemVO;
         if(_loc2_ && _loc2_.mgrID != 0)
         {
            _loc3_ = {
               "alias":getRallyViewAlias(),
               "itemId":_loc2_.mgrID,
               "peripheryID":_loc2_.peripheryID,
               "slotIndex":(Boolean(param1.data) ? param1.data : -1)
            };
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
         }
      }
      
      private function onRendererRollOutHandler(param1:SortableTableListEvent) : void
      {
         onControlRollOut();
      }
      
      private function onListIndexChangeHandler(param1:SortableTableListEvent) : void
      {
         var _loc2_:int = param1.index;
         if(!isNaN(_loc2_))
         {
            App.utils.scheduler.scheduleOnNextFrame(this.requestRallyData,_loc2_);
         }
      }
      
      private function onRendererDoubleClickHandler(param1:SortableTableListEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:IRallyListItemVO = param1.itemData as IRallyListItemVO;
         if(_loc2_)
         {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
               _loc3_ = {
                  "alias":getRallyViewAlias(),
                  "itemId":_loc2_.mgrID,
                  "peripheryID":_loc2_.peripheryID,
                  "slotIndex":-1
               };
               dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc3_));
            }
         }
      }
      
      private function onRendererPressHandler(param1:SortableTableListEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRendererRollOverHandler(param1:SortableTableListEvent) : void
      {
         this.itemRollOverPerformer(param1);
      }
      
      private function onAssignSlotRequestHandler(param1:RallyViewsEvent) : void
      {
         this.joinRallyRequestPerformer(param1);
      }
      
      private function onJoinRallyRequestHandler(param1:RallyViewsEvent) : void
      {
         this.joinRallyRequestPerformer(param1);
      }
      
      private function onDataUpdatedHandler(param1:ManualSearchEvent) : void
      {
         var _loc2_:Number = Math.min(Math.max(0,this.listDataProvider.length - this.rallyTable.totalRenderers),this.rallyTable.scrollPosition);
         IManualSearchDataProvider(this.listDataProvider).requestUpdatedItems(_loc2_,Math.min(this.listDataProvider.length - 1,_loc2_ + this.rallyTable.totalRenderers - 1),this.updateData);
      }
   }
}

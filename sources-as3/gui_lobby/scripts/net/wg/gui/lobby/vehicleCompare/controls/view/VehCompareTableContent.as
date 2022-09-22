package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareParamsListEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareScrollEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehCompareTableContent extends UIComponentEx
   {
      
      private static const VEH_PARAMS_INFO_INV:String = "VehParamsInfoInv";
      
      private static const VEH_PARAMS_DATA_INV:String = "VehParamsDataInv";
      
      private static const VEH_PARAMS_DELTA_DATA_INV:String = "VehParamsDeltaDataInv";
      
      private static const VEH_PARAMS_SCROLL_INV:String = "VehParamsScrollInv";
      
      private static const SCROLL_DURATION:Number = 0.5;
       
      
      public var paramsList:ScrollingListEx = null;
      
      public var tableGrid:VehCompareTableGrid = null;
      
      public var separator:Sprite = null;
      
      public var scrollList:VehParamsScroller = null;
      
      private var _vehParamsInfoDataProvider:VehParamsListDataProvider = null;
      
      private var _carouselDataProvider:IDataProvider = null;
      
      private var _paramsDeltaData:VehCompareParamsDeltaVO = null;
      
      private var _prevItemsCount:int = -1;
      
      public function VehCompareTableContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollList.rendererWidth = VehCompareVehParamRenderer.LINE_WIDTH;
         this.scrollList.hasHorizontalElasticEdges = false;
         this.scrollList.snapToPages = true;
         this.scrollList.cropContent = true;
         this.scrollList.mouseWheelDirection = null;
         this.scrollList.pageWidth = VehCompareVehParamRenderer.LINE_WIDTH;
         this.scrollList.addEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         this.scrollList.mouseEnabled = false;
         this.paramsList.rowHeight = VehCompareVehParamRenderer.LINE_HEIGHT;
         mouseChildren = true;
         this.paramsList.mouseChildren = true;
         this.paramsList.mouseEnabled = true;
         this.paramsList.addEventListener(VehCompareParamsListEvent.RENDER_CLICK,this.onParamsListRenderClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onComponentMouseHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseHandler);
         addEventListener(VehCompareVehParamRendererEvent.PARAM_CLICK,this.onVehParamClickHandler);
         addEventListener(VehCompareVehParamRendererEvent.PARAM_MOUSE_OUT,this.onVehParamMouseOutHandler);
         this.tableGrid.addEventListener(MouseEvent.MOUSE_DOWN,this.onTableGridMouseDownHandler);
         this.tableGrid.setLineHeight(VehCompareVehParamRenderer.LINE_HEIGHT);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(this._carouselDataProvider && isInvalid(VEH_PARAMS_DATA_INV))
         {
            this.scrollList.dataProvider = this._carouselDataProvider;
         }
         if(this._vehParamsInfoDataProvider && isInvalid(VEH_PARAMS_INFO_INV))
         {
            this.paramsList.dataProvider = this._vehParamsInfoDataProvider;
            this.tableGrid.setRenderersCount(this._vehParamsInfoDataProvider.length);
            this.tableGrid.setDataProvider(this._vehParamsInfoDataProvider);
         }
         if(this._paramsDeltaData && isInvalid(VEH_PARAMS_DELTA_DATA_INV))
         {
            this._paramsDeltaData.paramIndex = -1;
            _loc1_ = this._vehParamsInfoDataProvider.length;
            _loc2_ = 0;
            while(_loc2_ != _loc1_)
            {
               _loc3_ = this._vehParamsInfoDataProvider.getItemAt(_loc2_).paramID;
               if(_loc3_ == this._paramsDeltaData.paramID)
               {
                  this._paramsDeltaData.paramIndex = _loc2_;
                  break;
               }
               _loc2_++;
            }
            this.scrollList.setParamsDelta(this._paramsDeltaData);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._vehParamsInfoDataProvider)
            {
               _loc4_ = VehCompareVehParamRenderer.LINE_HEIGHT * this._vehParamsInfoDataProvider.originalLength + VehCompareVehParamRenderer.BOTTOM_LINE_HEIGHT;
               this.paramsList.height = _loc4_;
               this.separator.height = _loc4_;
               this.tableGrid.width = width;
               height = VehCompareVehParamRenderer.LINE_HEIGHT * this._vehParamsInfoDataProvider.length + VehCompareVehParamRenderer.BOTTOM_LINE_HEIGHT;
               this.scrollList.width = width - this.scrollList.x;
               this.scrollList.height = height;
               this.scrollList.validateNow();
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
         if(isInvalid(VEH_PARAMS_SCROLL_INV))
         {
            _loc5_ = this._carouselDataProvider.length * this.scrollList.rendererWidth - this.scrollList.width;
            if(this._prevItemsCount != -1 && this._prevItemsCount < this._carouselDataProvider.length && _loc5_ > this.scrollList.horizontalScrollPosition)
            {
               this.scrollList.scrollToHorizontalPosition(_loc5_,SCROLL_DURATION);
            }
            this._prevItemsCount = this._carouselDataProvider.length;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onComponentMouseHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onComponentMouseHandler);
         removeEventListener(VehCompareVehParamRendererEvent.PARAM_CLICK,this.onVehParamClickHandler);
         removeEventListener(VehCompareVehParamRendererEvent.PARAM_MOUSE_OUT,this.onVehParamMouseOutHandler);
         this.scrollList.removeEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         this.scrollList.dispose();
         this.scrollList = null;
         this.paramsList.removeEventListener(VehCompareParamsListEvent.RENDER_CLICK,this.onParamsListRenderClickHandler);
         this.paramsList.dispose();
         this.paramsList = null;
         this.tableGrid.removeEventListener(MouseEvent.MOUSE_DOWN,this.onTableGridMouseDownHandler);
         this.tableGrid.dispose();
         this.tableGrid = null;
         this.separator = null;
         this._paramsDeltaData = null;
         this.clearCarouselDataProvider();
         this._vehParamsInfoDataProvider = null;
         super.onDispose();
      }
      
      public function clickOnTableGrid(param1:Number) : void
      {
         this.tableGrid.selectRowAt(param1);
      }
      
      public function hideDelta() : void
      {
         this.scrollList.hideDelta();
      }
      
      public function setParamsDelta(param1:VehCompareParamsDeltaVO) : void
      {
         this._paramsDeltaData = param1;
         invalidate(VEH_PARAMS_DELTA_DATA_INV);
      }
      
      public function setVehParamsInfo(param1:IDataProvider) : void
      {
         this._vehParamsInfoDataProvider = VehParamsListDataProvider(param1);
         invalidate(VEH_PARAMS_INFO_INV,VEH_PARAMS_DELTA_DATA_INV,InvalidationType.SIZE);
      }
      
      public function setVehiclesData(param1:IDataProvider) : void
      {
         if(this._carouselDataProvider)
         {
            this._carouselDataProvider.removeEventListener(Event.CHANGE,this.onCarouselDataProviderChangeHandler);
         }
         this.clearCarouselDataProvider();
         this._carouselDataProvider = param1;
         invalidate(VEH_PARAMS_DATA_INV);
         this._carouselDataProvider.addEventListener(Event.CHANGE,this.onCarouselDataProviderChangeHandler);
      }
      
      public function updateBottomLineState(param1:int, param2:Number) : void
      {
         this.scrollList.updateBottomLineState(param1,param2);
      }
      
      public function updateTableScrollPosition(param1:int) : void
      {
         this.scrollList.removeEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         this.scrollList.moveToHorizontalScrollPosition(param1);
         this.scrollList.validateNow();
         this.scrollList.addEventListener(Event.SCROLL,this.onScrollListScrollHandler);
      }
      
      private function clearCarouselDataProvider() : void
      {
         if(this._carouselDataProvider)
         {
            this._carouselDataProvider.removeEventListener(Event.CHANGE,this.onCarouselDataProviderChangeHandler);
            this._carouselDataProvider.cleanUp();
            this._carouselDataProvider = null;
         }
      }
      
      private function onTableGridMouseDownHandler(param1:MouseEvent) : void
      {
         this.scrollList.startDragging(param1.stageX,param1.stageY);
      }
      
      private function onCarouselDataProviderChangeHandler(param1:Event) : void
      {
         invalidate(VEH_PARAMS_SCROLL_INV);
      }
      
      private function onScrollListScrollHandler(param1:Event) : void
      {
         dispatchEvent(new VehCompareScrollEvent(VehCompareScrollEvent.SCROLL_CHANGED,this.scrollList.horizontalScrollPosition,this.scrollList.verticalScrollPosition,true));
      }
      
      private function onComponentMouseHandler(param1:MouseEvent) : void
      {
         this.tableGrid.highlightItemAt(new Point(param1.stageX,param1.stageY));
      }
      
      private function onParamsListRenderClickHandler(param1:VehCompareParamsListEvent) : void
      {
         this._vehParamsInfoDataProvider.update();
         this.paramsList.invalidateData();
         this.paramsList.invalidateRenderers();
         this.tableGrid.setRenderersCount(this._vehParamsInfoDataProvider.length);
         this.tableGrid.updateSelectedRows();
         invalidate(InvalidationType.SIZE);
         this.setParamsDelta(null);
      }
      
      private function onVehParamClickHandler(param1:VehCompareVehParamRendererEvent) : void
      {
         this.clickOnTableGrid(param1.stageY);
      }
      
      private function onVehParamMouseOutHandler(param1:VehCompareVehParamRendererEvent) : void
      {
         this.hideDelta();
      }
   }
}

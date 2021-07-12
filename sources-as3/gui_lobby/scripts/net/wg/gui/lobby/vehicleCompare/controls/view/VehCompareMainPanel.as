package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.events.ScrollPaneEvent;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.gui.lobby.vehicleCompare.interfaces.IMainPanel;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehCompareMainPanel extends UIComponentEx implements IMainPanel
   {
      
      private static const SCROLL_LINES_TO_REDUCE_SHADOW:int = 4;
      
      private static const DELTA_DATA_INV:String = "DeltaDataInv";
      
      private static const SCROLL_PANE_SIZE_INV:String = "ScrollPaneSizeInv";
       
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var vehCompareTableContent:VehCompareTableContent = null;
      
      public var leftBg:Sprite = null;
      
      public var bottomShadow:Sprite = null;
      
      private var _vehParamsDataProvider:IDataProvider = null;
      
      private var _vehiclesDataProvider:IDataProvider = null;
      
      private var _vehParamsDelta:VehCompareParamsDeltaVO = null;
      
      public function VehCompareMainPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehCompareTableContent = VehCompareTableContent(this.scrollPane.target);
         this.vehCompareTableContent.addEventListener(Event.RESIZE,this.onVehCompareTableContentResizeHandler);
         this.scrollPane.isSmoothScroll = false;
         this.scrollPane.addEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChangedHandler);
         this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
         this.bottomShadow.width = this.leftBg.x + this.leftBg.width;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.scrollPane.setSize(width,height);
            this.vehCompareTableContent.width = width;
            this.leftBg.height = height - this.leftBg.y;
            this.bottomShadow.y = height - this.bottomShadow.height;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._vehParamsDataProvider)
            {
               this.vehCompareTableContent.width = width;
               this.vehCompareTableContent.setVehParamsInfo(this._vehParamsDataProvider);
            }
            if(this._vehiclesDataProvider)
            {
               this.vehCompareTableContent.setVehiclesData(this._vehiclesDataProvider);
            }
         }
         if(this._vehParamsDelta && isInvalid(DELTA_DATA_INV))
         {
            this.vehCompareTableContent.setParamsDelta(this._vehParamsDelta);
         }
         if(isInvalid(SCROLL_PANE_SIZE_INV))
         {
            _loc1_ = this.scrollPane.scrollPosition * this.scrollPane.scrollStepFactor;
            _loc2_ = Math.min((this.scrollPane.maxScroll - this.scrollPane.scrollPosition) / SCROLL_LINES_TO_REDUCE_SHADOW,1);
            this.vehCompareTableContent.updateBottomLineState(height + _loc1_,_loc2_);
            this.bottomShadow.alpha = _loc2_;
         }
      }
      
      override protected function onDispose() : void
      {
         this._vehParamsDataProvider = null;
         this.scrollPane.removeEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChangedHandler);
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.vehCompareTableContent.removeEventListener(Event.RESIZE,this.onVehCompareTableContentResizeHandler);
         this.vehCompareTableContent = null;
         this.leftBg = null;
         this.bottomShadow = null;
         this._vehParamsDelta = null;
         this._vehiclesDataProvider = null;
         super.onDispose();
      }
      
      public function setParamsDelta(param1:VehCompareParamsDeltaVO) : void
      {
         this._vehParamsDelta = param1;
         invalidate(DELTA_DATA_INV);
      }
      
      public function setVehicleParams(param1:IDataProvider) : void
      {
         this._vehParamsDataProvider = param1;
         invalidateData();
      }
      
      public function setVehiclesData(param1:IDataProvider) : void
      {
         this._vehiclesDataProvider = param1;
         invalidateData();
      }
      
      public function updateTableScrollPosition(param1:int) : void
      {
         this.vehCompareTableContent.updateTableScrollPosition(param1);
      }
      
      private function onScrollPanePositionChangedHandler(param1:ScrollPaneEvent) : void
      {
         invalidate(SCROLL_PANE_SIZE_INV);
      }
      
      private function onVehCompareTableContentResizeHandler(param1:Event) : void
      {
         this.scrollPane.invalidateSize();
         invalidate(SCROLL_PANE_SIZE_INV);
      }
   }
}

package net.wg.gui.lobby.vehicleCustomization
{
   import flash.geom.Point;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorInitVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsSetVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsStateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationVehicleView extends UIComponentEx
   {
      
      private static const MESSAGE_BAR_OFFSET:int = 38;
       
      
      public var anchorsSet:CustomizationAnchorsSet = null;
      
      private var _actualWidth:int = 0;
      
      private var _actualHeight:int = 0;
      
      private var _localPoint:Point = null;
      
      public function CustomizationVehicleView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.anchorsSet.dispose();
         this.anchorsSet = null;
         this._localPoint = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            width = this._actualWidth;
            height = this._actualHeight;
            x = this._localPoint.x;
            y = this._localPoint.y;
         }
      }
      
      public function getSelectedSlotId() : CustomizationSlotIdVO
      {
         return this.anchorsSet.getSelectedSlotId();
      }
      
      public function onAfterDrop() : void
      {
         this.anchorsSet.onAfterDrop();
      }
      
      public function onDragEnd() : void
      {
         this.anchorsSet.onDragEnd();
      }
      
      public function onDragStart() : void
      {
         this.anchorsSet.onDragStart();
      }
      
      public function onStartDrop() : void
      {
         this.anchorsSet.onStartDrop();
      }
      
      public function setAnchorInit(param1:CustomizationAnchorInitVO) : void
      {
         this.anchorsSet.setInitData(param1);
      }
      
      public function setAnchorPositions(param1:CustomizationAnchorsSetVO) : void
      {
         this.anchorsSet.updatePositions(param1.renderersList);
      }
      
      public function updateAnchorData(param1:CustomizationAnchorInitVO) : void
      {
         this.anchorsSet.updateData(param1);
      }
      
      public function setAnchorsState(param1:CustomizationAnchorsStateVO) : void
      {
         this.anchorsSet.setAnchorsState(param1);
      }
      
      public function updateSize(param1:Number, param2:Number) : void
      {
         this._localPoint = parent.globalToLocal(new Point(0,0));
         this._actualWidth = param1 - this._localPoint.x;
         this._actualHeight = param2 + MESSAGE_BAR_OFFSET - this._localPoint.y;
         invalidateSize();
      }
   }
}

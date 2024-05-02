package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.OperationsHeaderVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class OperationsHeader extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const OPERATIONS_COUNT_MIN:uint = 4;
      
      private static const OPERATION_CONTAINER_OFFSET_X:int = 40;
      
      private static const OPERATIONS_CONTAINER_TOP:int = 42;
       
      
      public var separator:MovieClip;
      
      public var operationsContainer:OperationsContainer;
      
      public var bg:Sprite;
      
      private var _data:OperationsHeaderVO;
      
      public function OperationsHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseEnabled = false;
         this.operationsContainer.addEventListener(OperationEvent.SIZE_CHANGED,this.onOperationsContainerSizeChangedHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._data.operations.length < OPERATIONS_COUNT_MIN;
            this.bg.width = width;
            this.operationsContainer.x = width - this.operationsContainer.width >> 1;
            this.operationsContainer.y = OPERATIONS_CONTAINER_TOP;
            this.separator.x = width - this.separator.width >> 1;
            if(_loc1_)
            {
               this.operationsContainer.x += OPERATION_CONTAINER_OFFSET_X;
            }
            dispatchEvent(new OperationEvent(OperationEvent.SIZE_CHANGED));
         }
      }
      
      override protected function onDispose() : void
      {
         this.operationsContainer.removeEventListener(OperationEvent.SIZE_CHANGED,this.onOperationsContainerSizeChangedHandler);
         this.operationsContainer.dispose();
         this.operationsContainer = null;
         this.separator = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && param1 != this._data)
         {
            this._data = OperationsHeaderVO(param1);
            this.operationsContainer.setData(this._data.operations);
            invalidateData();
         }
      }
      
      public function get componentVisibleHeight() : Number
      {
         return this.separator.y;
      }
      
      private function onOperationsContainerSizeChangedHandler(param1:OperationEvent) : void
      {
         invalidateSize();
      }
   }
}

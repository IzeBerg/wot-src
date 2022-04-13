package net.wg.gui.battle.commander.views.vehicleSelection
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.gui.battle.commander.views.vehicleSelection.events.RTSVehicleSelectionEvent;
   import net.wg.infrastructure.base.meta.impl.VehicleSelectionMeta;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.MouseEventEx;
   
   public class VehicleSelection extends VehicleSelectionMeta
   {
       
      
      public var selectRect:MovieClip;
      
      public var hitMC:MovieClip;
      
      private var _startPoint:Point;
      
      private var _isEnabled:Boolean;
      
      private var _isOverUI:Boolean = true;
      
      private var _isMiddleButtonBeingPressed:Boolean = false;
      
      public function VehicleSelection()
      {
         super();
      }
      
      private static function checkMouseFree(param1:MouseEvent = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 != null)
         {
            _loc2_ = param1.target;
         }
         else
         {
            _loc2_ = Extensions.getTopMostEntity(App.stage.mouseX,App.stage.mouseY);
         }
         return _loc2_ == null || _loc2_ == App.stage || _loc2_.name == "HitTest Fix";
      }
      
      private static function isMiddleButton(param1:MouseEvent) : Boolean
      {
         if(param1 is MouseEventEx)
         {
            return MouseEventEx(param1).buttonIdx == MouseEventEx.MIDDLE_BUTTON;
         }
         return false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheelEvent);
         App.stage.addEventListener(Event.RENDER,this.handleStageRender);
         this.hitMC.visible = false;
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown);
         App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp);
         App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheelEvent);
         App.stage.removeEventListener(Event.RENDER,this.handleStageRender);
         super.onDispose();
      }
      
      public function updateStageSize(param1:Number, param2:Number) : void
      {
         this.hitMC.width = param1;
         this.hitMC.height = param2;
      }
      
      protected function get isSelection() : Boolean
      {
         return this.selectRect.visible;
      }
      
      protected function set isSelection(param1:Boolean) : void
      {
         if(param1 != this.isSelection && (!param1 || this._isEnabled))
         {
            dispatchEvent(new RTSVehicleSelectionEvent(RTSVehicleSelectionEvent.VEHICLE_SELECTION_VISIBILITY_CHANGE,param1));
            this.updateSelection(!param1);
         }
      }
      
      protected function handleMouseDown(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            this.hitMC.visible = true;
         }
         if(isMiddleButton(param1))
         {
            this._isMiddleButtonBeingPressed = true;
            return;
         }
         if(!this._isMiddleButtonBeingPressed && checkMouseFree(param1) && App.utils.commons.isRightButton(param1))
         {
            handleRightMouseBtnS();
         }
      }
      
      protected function handleStageRender(param1:Event) : void
      {
         this.updateMouseOverUI();
      }
      
      protected function handleMouseUp(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            this.hitMC.visible = false;
            this.isSelection = false;
            if(param1.target == this.hitMC)
            {
               this.updateSelection(true);
            }
         }
         if(isMiddleButton(param1))
         {
            this._isMiddleButtonBeingPressed = false;
            return;
         }
         if(checkMouseFree(param1) && App.utils.commons.isRightButton(param1))
         {
            handleRightMouseBtnS();
         }
      }
      
      protected function handleMouseWheelEvent(param1:MouseEvent) : void
      {
         if(checkMouseFree(param1))
         {
            handleMouseWheelS(param1.delta);
         }
      }
      
      private function handleMouseMove(param1:MouseEvent) : void
      {
         this.hitMC.visible = false;
         if(param1.target == this.hitMC)
         {
            this.isSelection = true;
         }
         if(this.isSelection)
         {
            if(!param1.buttonDown)
            {
               this.isSelection = false;
               return;
            }
            this.updateSelection();
         }
         this.updateMouseOverUI();
      }
      
      protected function updateMouseOverUI(param1:MouseEvent = null) : void
      {
         var _loc2_:Boolean = !checkMouseFree(param1);
         if(_loc2_ != this._isOverUI)
         {
            handleMouseOverUIS(_loc2_);
            this._isOverUI = _loc2_;
         }
      }
      
      protected function updateSelection(param1:Boolean = false) : void
      {
         if(this._startPoint == null)
         {
            this._startPoint = new Point(App.stage.mouseX,App.stage.mouseY);
         }
         if(this._startPoint.x < App.stage.mouseX)
         {
            this.selectRect.x = this._startPoint.x;
         }
         else
         {
            this.selectRect.x = App.stage.mouseX;
         }
         if(this._startPoint.y < App.stage.mouseY)
         {
            this.selectRect.y = this._startPoint.y;
         }
         else
         {
            this.selectRect.y = App.stage.mouseY;
         }
         this.selectRect.width = App.stage.mouseX - this._startPoint.x;
         this.selectRect.height = App.stage.mouseY - this._startPoint.y;
         this.selectRect.visible = !param1;
         if(param1)
         {
            this._startPoint = null;
         }
         setSelectionParamsS(this.selectRect.x,this.selectRect.y,this.selectRect.x + this.selectRect.width,this.selectRect.y + this.selectRect.height,param1);
      }
      
      public function as_setEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
         if(!param1)
         {
            this.isSelection = false;
         }
      }
   }
}

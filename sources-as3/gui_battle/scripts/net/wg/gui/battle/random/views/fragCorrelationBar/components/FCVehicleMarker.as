package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.VehicleStatus;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FCVehicleMarker extends MovieClip implements IDisposable
   {
      
      private static const LAST_ANIM_FRAME:int = 12;
      
      private static const NORMAL_FRAME_NAME:String = "normal";
      
      private static const DESTROY_FRAME_NAME:String = "destroy";
      
      private static const DESTROYED_FRAME_NAME:String = "destroyed";
       
      
      public var vehicleID:int = -1;
      
      public var vehicleLevel:int = -1;
      
      public var normalMarker:MovieClip = null;
      
      public var destroyedMarker:MovieClip = null;
      
      private var _vehicleStatus:int = -1;
      
      private var _vehicleType:String = "";
      
      private var _color:String = "";
      
      private var _vehicleMarkerAnimFinishedHandler:IVehicleMarkerAnimFinishedHandler = null;
      
      private var _isDisposed:Boolean = false;
      
      public function FCVehicleMarker()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function init(param1:int, param2:String, param3:int, param4:String, param5:int, param6:IVehicleMarkerAnimFinishedHandler) : void
      {
         this.vehicleID = param1;
         this.update(param2,param3,param5,param4);
         addFrameScript(LAST_ANIM_FRAME,this.updateVehicleIDs);
         this._vehicleMarkerAnimFinishedHandler = param6;
      }
      
      public function update(param1:String, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:Boolean = false;
         if(this._vehicleType != param1)
         {
            _loc5_ = true;
            this._vehicleType = param1;
         }
         if(this._color != param4)
         {
            _loc5_ = true;
            this._color = param4;
         }
         if(this.vehicleLevel != param3)
         {
            _loc5_ = true;
            this.vehicleLevel = param3;
         }
         if(_loc5_)
         {
            this.redraw();
         }
         if(this._vehicleStatus != param2)
         {
            this._vehicleStatus = param2;
            if(!(this._vehicleStatus & VehicleStatus.IS_ALIVE) > 0)
            {
               gotoAndStop(DESTROYED_FRAME_NAME);
               this.normalMarker.visible = false;
               this.destroyedMarker.visible = true;
            }
            else
            {
               gotoAndStop(NORMAL_FRAME_NAME);
               this.destroyedMarker.visible = false;
            }
         }
      }
      
      public function updateVehicleStatus(param1:uint) : void
      {
         this._vehicleStatus = param1;
         if(!(this._vehicleStatus & VehicleStatus.IS_ALIVE) > 0)
         {
            this.playDestroyAnim();
         }
      }
      
      protected function onDispose() : void
      {
         App.utils.asserter.assert(!this._isDisposed,"FCVehicleMarker is already disposed!");
         this._isDisposed = true;
         this.normalMarker = null;
         this.destroyedMarker = null;
         this._vehicleMarkerAnimFinishedHandler = null;
      }
      
      private function playDestroyAnim() : void
      {
         this.destroyedMarker.visible = true;
         gotoAndPlay(DESTROY_FRAME_NAME);
      }
      
      private function updateVehicleIDs() : void
      {
         this.normalMarker.visible = false;
         stop();
         this._vehicleMarkerAnimFinishedHandler.sort();
      }
      
      private function redraw() : void
      {
         this.normalMarker.gotoAndStop(this._color + this._vehicleType);
         this.destroyedMarker.gotoAndStop(this._color + this._vehicleType);
      }
      
      public function set color(param1:String) : void
      {
         this._color = param1;
         this.redraw();
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}

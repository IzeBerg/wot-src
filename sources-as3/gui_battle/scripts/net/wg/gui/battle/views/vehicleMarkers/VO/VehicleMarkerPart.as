package net.wg.gui.battle.views.vehicleMarkers.VO
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleMarkerPart implements IDisposable
   {
       
      
      public var cachedVisibility:Boolean = false;
      
      private var _part:Object;
      
      private var _offset:int;
      
      private var _crossOffset:CrossOffset = null;
      
      private var _height:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function VehicleMarkerPart(param1:Object, param2:int, param3:CrossOffset)
      {
         super();
         this._part = param1;
         this._offset = param2;
         this._crossOffset = param3;
         this._height = this._part.height;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this._crossOffset)
         {
            this._crossOffset.dispose();
            this._crossOffset = null;
         }
         this._part = null;
      }
      
      public function offsetFromPart(param1:VehicleMarkerPart) : int
      {
         var _loc3_:Object = null;
         var _loc2_:int = this._offset;
         if(this._crossOffset && param1)
         {
            _loc3_ = param1.part;
            _loc2_ = !!this._crossOffset.hasOffset(_loc3_) ? int(this._crossOffset.getOffset(_loc3_)) : int(this._offset);
         }
         return _loc2_;
      }
      
      public function get part() : Object
      {
         return this._part;
      }
      
      public function get y() : int
      {
         return this._part.y;
      }
      
      public function set y(param1:int) : void
      {
         this._part.y = param1;
      }
      
      public function get height() : int
      {
         if(this._height == 0)
         {
            this._height = this._part.height;
         }
         return this._height;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

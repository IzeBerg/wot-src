package net.wg.gui.battle.views.vehicleMarkers.VO
{
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrossOffset implements IDisposable
   {
       
      
      private var _offsetByObject:Dictionary;
      
      public function CrossOffset(... rest)
      {
         var _loc4_:int = 0;
         this._offsetByObject = new Dictionary(true);
         super();
         var _loc2_:int = rest.length;
         var _loc3_:Object = null;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            if((_loc5_ & 1) == 0)
            {
               _loc3_ = rest[_loc5_];
            }
            else
            {
               _loc4_ = rest[_loc5_];
               this._offsetByObject[_loc3_] = _loc4_;
            }
            _loc5_++;
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this._offsetByObject)
         {
            this._offsetByObject[_loc1_] = null;
            delete this._offsetByObject[_loc1_];
         }
         this._offsetByObject = null;
      }
      
      public function getOffset(param1:Object) : int
      {
         return this._offsetByObject[param1];
      }
      
      public function hasOffset(param1:Object) : Boolean
      {
         return this._offsetByObject[param1] != undefined && this._offsetByObject[param1] != null;
      }
   }
}

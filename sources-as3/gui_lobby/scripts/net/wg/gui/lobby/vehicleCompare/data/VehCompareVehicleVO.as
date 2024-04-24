package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehCompareVehicleVO extends DAAPIUpdatableDataClass
   {
      
      private static const PARAMS:String = "params";
       
      
      public var id:int = -1;
      
      public var index:int = -1;
      
      public var isInHangar:Boolean = false;
      
      public var nation:int = -1;
      
      public var image:String = "";
      
      public var label:String = "";
      
      public var level:int = -1;
      
      public var elite:Boolean = false;
      
      public var premium:Boolean = false;
      
      public var tankType:String = "";
      
      public var moduleType:String = "";
      
      public var isFirstEmptySlot:Boolean = false;
      
      public var isAttention:Boolean = false;
      
      public var showRevertBtn:Boolean = false;
      
      private var _params:Vector.<VehParamsDataVO>;
      
      public function VehCompareVehicleVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:VehParamsDataVO = null;
         if(param1 == PARAMS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,PARAMS + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            this.clearParams();
            this._params = new Vector.<VehParamsDataVO>(0);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc5_ < this._params.length)
               {
                  this._params[_loc5_].fromHash(_loc3_[_loc5_]);
               }
               else
               {
                  _loc6_ = new VehParamsDataVO(_loc3_[_loc5_]);
                  this._params.push(_loc6_);
               }
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearParams();
         super.onDispose();
      }
      
      private function clearParams() : void
      {
         var _loc1_:IDisposable = null;
         if(this._params)
         {
            for each(_loc1_ in this._params)
            {
               _loc1_.dispose();
            }
            this._params.splice(0,this._params.length);
            this._params = null;
         }
      }
      
      public function get params() : Vector.<VehParamsDataVO>
      {
         return this._params;
      }
   }
}

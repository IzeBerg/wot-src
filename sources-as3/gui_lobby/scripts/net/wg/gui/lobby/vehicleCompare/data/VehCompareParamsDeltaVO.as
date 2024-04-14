package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehCompareParamsDeltaVO extends DAAPIDataClass
   {
      
      private static const DELTAS:String = "deltas";
       
      
      public var paramID:String = "";
      
      public var paramIndex:int = -1;
      
      private var _deltas:Vector.<String>;
      
      public function VehCompareParamsDeltaVO(param1:Object)
      {
         this._deltas = new Vector.<String>(0);
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._deltas.splice(0,this.deltas.length);
         this._deltas = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(param1 == DELTAS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,DELTAS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._deltas.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get deltas() : Vector.<String>
      {
         return this._deltas;
      }
   }
}

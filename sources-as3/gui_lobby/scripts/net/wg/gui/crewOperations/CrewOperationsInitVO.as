package net.wg.gui.crewOperations
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class CrewOperationsInitVO extends DAAPIDataClass
   {
      
      private static const OPERATIONS_ARRAY:String = "operationsArray";
       
      
      private var _castedOperations:DataProvider = null;
      
      public function CrewOperationsInitVO(param1:Object)
      {
         this._castedOperations = new DataProvider();
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._castedOperations)
         {
            _loc1_.dispose();
         }
         this._castedOperations.cleanUp();
         this._castedOperations = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == OPERATIONS_ARRAY)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this._castedOperations.push(new CrewOperationInfoVO(_loc3_[_loc5_]));
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get castedOperations() : IDataProvider
      {
         return this._castedOperations;
      }
   }
}

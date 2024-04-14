package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class MissionVehicleTypeRendererVO extends DAAPIDataClass
   {
      
      private static const VAL_LIST_FIELD:String = "list";
       
      
      public var typeIcon:String = "";
      
      public var label:String = "";
      
      public var def:String = "";
      
      public var list:DataProvider = null;
      
      public function MissionVehicleTypeRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.list)
         {
            _loc1_.dispose();
         }
         this.list.cleanUp();
         this.list = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param2 != null && param1 == VAL_LIST_FIELD)
         {
            App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE + Array);
            this.list = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.list.push(new MissionVehicleParamRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}

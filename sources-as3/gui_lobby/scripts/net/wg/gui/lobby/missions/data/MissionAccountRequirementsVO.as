package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class MissionAccountRequirementsVO extends DAAPIDataClass
   {
      
      private static const REQUIREMENTS:String = "requirements";
       
      
      public var header:String = "";
      
      private var _requirements:DataProvider;
      
      public function MissionAccountRequirementsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._requirements)
         {
            _loc1_.dispose();
         }
         this._requirements.cleanUp();
         this._requirements = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == REQUIREMENTS)
         {
            App.utils.asserter.assertNotNull(param2,REQUIREMENTS + Errors.CANT_NULL);
            this._requirements = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._requirements.push(new MissionAccountRequirementRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get requirements() : DataProvider
      {
         return this._requirements;
      }
   }
}

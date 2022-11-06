package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class RetrainCrewBlockVOBase extends DAAPIDataClass
   {
      
      private static const CREW:String = "crew";
       
      
      private var _crewInfoVO:DataProvider = null;
      
      public function RetrainCrewBlockVOBase(param1:Object)
      {
         this._crewInfoVO = new DataProvider();
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._crewInfoVO)
         {
            _loc1_.dispose();
         }
         this._crewInfoVO.cleanUp();
         this._crewInfoVO = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:RetrainTankmanVO = null;
         if(param1 == CREW)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = new RetrainTankmanVO(_loc3_[_loc5_]);
               this._crewInfoVO.push(_loc6_);
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get crewInfoVO() : IDataProvider
      {
         return this._crewInfoVO;
      }
   }
}

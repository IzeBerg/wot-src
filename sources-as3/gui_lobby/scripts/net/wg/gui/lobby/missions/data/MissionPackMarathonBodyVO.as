package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import scaleform.clik.data.DataProvider;
   
   public class MissionPackMarathonBodyVO extends DAAPIDataClass
   {
      
      private static const MISSIONS_FIELD:String = "missions";
      
      private static const DUMMY_FIELD:String = "dummy";
       
      
      private var _missionsDataProvider:DataProvider;
      
      private var _dummy:DummyVO;
      
      private var _blockId:String = "";
      
      public function MissionPackMarathonBodyVO(param1:Object, param2:String)
      {
         this._blockId = param2;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(param2 != null && param1 == MISSIONS_FIELD)
         {
            App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE + "Array");
            this._missionsDataProvider = new DataProvider();
            for each(_loc3_ in param2)
            {
               _loc4_ = new this.missionCardClass(_loc3_);
               _loc4_.blockID = this._blockId;
               this._missionsDataProvider.push(_loc4_);
            }
            return false;
         }
         if(param2 != null && DUMMY_FIELD == param1)
         {
            this._dummy = new DummyVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      protected function get missionCardClass() : Class
      {
         return MissionCardViewVO;
      }
      
      override protected function onDispose() : void
      {
         if(this._missionsDataProvider)
         {
            this._missionsDataProvider.cleanUp();
            this._missionsDataProvider = null;
         }
         if(this._dummy)
         {
            this._dummy.dispose();
            this._dummy = null;
         }
         super.onDispose();
      }
      
      public function get missionsDataProvider() : DataProvider
      {
         return this._missionsDataProvider;
      }
      
      public function get dummy() : DummyVO
      {
         return this._dummy;
      }
   }
}

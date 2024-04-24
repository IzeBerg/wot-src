package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionProgressVO extends MissionDetailsPopUpPanelVO
   {
      
      private static const PROGRESS_LIST:String = "progressList";
       
      
      private var _progressList:DataProvider;
      
      public function MissionProgressVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == PROGRESS_LIST)
         {
            App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE + "Array");
            this._progressList = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._progressList.push(new MissionDetailsAchievementRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._progressList != null)
         {
            for each(_loc1_ in this._progressList)
            {
               _loc1_.dispose();
            }
            this._progressList.cleanUp();
            this._progressList = null;
         }
         super.onDispose();
      }
      
      public function get progressList() : IDataProvider
      {
         return this._progressList;
      }
   }
}

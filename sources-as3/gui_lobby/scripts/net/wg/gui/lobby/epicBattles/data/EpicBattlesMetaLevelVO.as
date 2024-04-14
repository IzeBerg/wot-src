package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   
   public class EpicBattlesMetaLevelVO extends DAAPIDataClass
   {
      
      private static const PROGRESS_BAR_DATA_FIELD:String = "progressBarData";
       
      
      public var progressBarData:ProgressBarAnimVO = null;
      
      public function EpicBattlesMetaLevelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PROGRESS_BAR_DATA_FIELD)
         {
            this.progressBarData = new ProgressBarAnimVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.progressBarData)
         {
            this.progressBarData.dispose();
            this.progressBarData = null;
         }
         super.onDispose();
      }
   }
}

package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   
   public class EpicBattlesInfoMetaProgressVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const PROGRESS_BAR_DATA_FIELD:String = "progressBarData";
       
      
      public var titleHtmlText:String = "";
      
      public var descriptionHtmlText:String = "";
      
      public var buttonText:String = "";
      
      public var progressBarData:ProgressBarAnimVO = null;
      
      public var famePointsText:String = "";
      
      public var canPrestige:Boolean = false;
      
      public var isEndGameState:Boolean = false;
      
      public var awards:Vector.<AwardItemRendererExVO> = null;
      
      public function EpicBattlesInfoMetaProgressVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == AWARDS)
         {
            this.awards = new Vector.<AwardItemRendererExVO>(0);
            for each(_loc3_ in param2)
            {
               this.awards.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == PROGRESS_BAR_DATA_FIELD)
         {
            this.progressBarData = new ProgressBarAnimVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardItemRendererExVO = null;
         if(this.awards)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.splice(0,this.awards.length);
         }
         this.awards = null;
         if(this.progressBarData)
         {
            this.progressBarData.dispose();
            this.progressBarData = null;
         }
         super.onDispose();
      }
   }
}

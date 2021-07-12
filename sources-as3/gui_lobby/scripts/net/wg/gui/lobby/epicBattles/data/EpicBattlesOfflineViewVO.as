package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicBattlesOfflineViewVO extends DAAPIDataClass
   {
      
      private static const PRESTIGE_PROGRESS_VO:String = "prestigeProgressVO";
       
      
      public var backgroundImageSrc:String = "";
      
      public var headlineTitleHtmlTextBig:String = "";
      
      public var headlineTitleHtmlTextSmall:String = "";
      
      public var calendarText:String = "";
      
      public var calendarSubTitleHtmlText:String = "";
      
      public var prestigeProgressVO:EpicBattlesPrestigeProgressVO = null;
      
      public function EpicBattlesOfflineViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PRESTIGE_PROGRESS_VO)
         {
            this.prestigeProgressVO = new EpicBattlesPrestigeProgressVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.prestigeProgressVO != null)
         {
            this.prestigeProgressVO.dispose();
            this.prestigeProgressVO = null;
         }
         super.onDispose();
      }
   }
}

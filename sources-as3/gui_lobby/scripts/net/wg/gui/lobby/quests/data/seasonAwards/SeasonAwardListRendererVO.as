package net.wg.gui.lobby.quests.data.seasonAwards
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SeasonAwardListRendererVO extends DAAPIDataClass
   {
      
      private static const EXTRA_AWARD_FIELD_NAME:String = "extraAward";
      
      private static const BASIC_AWARD_FIELD_NAME:String = "basicAward";
       
      
      public var title:String = "";
      
      public var background:String = "";
      
      public var basicAward:VehicleSeasonAwardVO = null;
      
      public var extraAward:IconTitleDescSeasonAwardVO = null;
      
      public function SeasonAwardListRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BASIC_AWARD_FIELD_NAME)
         {
            this.basicAward = new VehicleSeasonAwardVO(param2);
            return false;
         }
         if(param1 == EXTRA_AWARD_FIELD_NAME)
         {
            this.extraAward = new IconTitleDescSeasonAwardVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.basicAward != null)
         {
            this.basicAward.dispose();
            this.basicAward = null;
         }
         if(this.extraAward != null)
         {
            this.extraAward.dispose();
            this.extraAward = null;
         }
         super.onDispose();
      }
   }
}

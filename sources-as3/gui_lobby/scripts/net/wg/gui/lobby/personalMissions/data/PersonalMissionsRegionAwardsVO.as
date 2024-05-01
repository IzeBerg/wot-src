package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   
   public class PersonalMissionsRegionAwardsVO extends DAAPIDataClass
   {
      
      private static const MAIN_AWARD:String = "mainAward";
       
      
      public var mainAwardText:String = "";
      
      public var mainAward:AwardItemRendererExVO = null;
      
      public function PersonalMissionsRegionAwardsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == MAIN_AWARD)
         {
            App.utils.asserter.assertNotNull(param2,param2 + Errors.CANT_NULL);
            this.mainAward = new AwardItemRendererExVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.mainAward)
         {
            this.mainAward.dispose();
            this.mainAward = null;
         }
         super.onDispose();
      }
   }
}

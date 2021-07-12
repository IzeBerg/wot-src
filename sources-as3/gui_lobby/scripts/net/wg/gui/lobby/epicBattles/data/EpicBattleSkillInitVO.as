package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicBattleSkillInitVO extends DAAPIDataClass
   {
       
      
      public var upgradeBtnLoc:String = "";
      
      public var acquireBtnLoc:String = "";
      
      public var abilityMaxLevelTxtLoc:String = "";
      
      public var abilityLockedTxtLoc:String = "";
      
      public var abilityNotPointsTxtLoc:String = "";
      
      public var statsTitleLoc:String = "";
      
      public function EpicBattleSkillInitVO(param1:Object = null)
      {
         super(param1);
      }
   }
}

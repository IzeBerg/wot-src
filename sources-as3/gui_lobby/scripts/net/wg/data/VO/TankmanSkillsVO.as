package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle;
   
   public class TankmanSkillsVO extends DAAPIDataClass
   {
       
      
      public var skillsCountForLearn:int = 0;
      
      public var lastNewSkillExp:int = 0;
      
      public var selectedTab:int = 0;
      
      public var specializationLevel:Number;
      
      public var skills:Array;
      
      public var wg_freeXpToTankman:Boolean = false;
      
      public var enoughFreeXPForTeaching:Boolean = false;
      
      public var tankmanInBattle:Boolean = false;
      
      public var currentNation:String = "";
      
      public var currentVehicle:PersonalCaseCurrentVehicle = null;
      
      public function TankmanSkillsVO(param1:Object)
      {
         this.skills = [];
         super(param1);
      }
   }
}

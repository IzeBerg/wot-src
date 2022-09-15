package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TankmanSkillsInfoBlockVO extends DAAPIDataClass
   {
       
      
      public var nation:String = "";
      
      public var tankmanName:String = "";
      
      public var tankmanIcon:String = "";
      
      public var roleIcon:String = "";
      
      public var skillsCount:int = 0;
      
      public var lastSkill:String = "";
      
      public var lastSkillLevel:int = 0;
      
      public var preLastSkill:String = "";
      
      public var hasNewSkill:Boolean = false;
      
      public var newSkillsCount:int = 0;
      
      public var lastNewSkillLevel:int = 0;
      
      public var roleLevel:int = -1;
      
      public function TankmanSkillsInfoBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}

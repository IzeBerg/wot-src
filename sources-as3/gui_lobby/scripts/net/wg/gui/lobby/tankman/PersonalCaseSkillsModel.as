package net.wg.gui.lobby.tankman
{
   public class PersonalCaseSkillsModel
   {
       
      
      public var list:Array = null;
      
      public var isBootcamp:Boolean = false;
      
      public var specializationLevel:int = -1;
      
      public function PersonalCaseSkillsModel(param1:Array, param2:Boolean = false, param3:int = -1)
      {
         super();
         this.list = param1;
         this.isBootcamp = param2;
         this.specializationLevel = param3;
      }
   }
}

package net.wg.gui.lobby.tankman
{
   public class PersonalCaseSkillsModel
   {
       
      
      public var list:Array = null;
      
      public var isBootcamp:Boolean = false;
      
      public function PersonalCaseSkillsModel(param1:Array, param2:Boolean = false)
      {
         super();
         this.list = param1;
         this.isBootcamp = param2;
      }
   }
}

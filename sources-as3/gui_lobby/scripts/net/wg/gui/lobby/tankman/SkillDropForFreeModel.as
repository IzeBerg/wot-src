package net.wg.gui.lobby.tankman
{
   public class SkillDropForFreeModel extends SkillDropModel
   {
       
      
      public var timeLeft:int = 0;
      
      public function SkillDropForFreeModel(param1:Object)
      {
         this.timeLeft = param1.timeLeft;
         super(param1);
      }
   }
}

package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RequirementBlockVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var containerElements:Array;
      
      public var topConditions:Array;
      
      public function RequirementBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}

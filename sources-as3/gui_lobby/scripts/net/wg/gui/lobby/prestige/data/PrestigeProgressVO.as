package net.wg.gui.lobby.prestige.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PrestigeProgressVO extends DAAPIDataClass
   {
       
      
      public var vehCD:int = -1;
      
      public var gradeType:String = "";
      
      public var grade:String = "";
      
      public var lvl:String = "";
      
      public var currentXP:Number = -1;
      
      public var nextLvlXP:Number = -1;
      
      public var gainedXP:String = "";
      
      public var isLvlUp:Boolean = false;
      
      public var linkage:String = "PrestigeProgressSubTaskUI";
      
      public function PrestigeProgressVO(param1:Object)
      {
         super(param1);
      }
   }
}

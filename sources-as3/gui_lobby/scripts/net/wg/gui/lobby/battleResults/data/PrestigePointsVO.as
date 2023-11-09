package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PrestigePointsVO extends DAAPIDataClass
   {
       
      
      public var isVisible:Boolean = false;
      
      public var value:String = "";
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public function PrestigePointsVO(param1:Object)
      {
         super(param1);
      }
   }
}

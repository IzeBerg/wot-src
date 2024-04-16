package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RosterLimitsVO extends DAAPIDataClass
   {
       
      
      public var minLevel:int = -1;
      
      public var maxLevel:int = -1;
      
      public function RosterLimitsVO(param1:Object = null)
      {
         super(param1);
      }
   }
}

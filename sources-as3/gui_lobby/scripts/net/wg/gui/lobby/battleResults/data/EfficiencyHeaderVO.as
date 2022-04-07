package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EfficiencyHeaderVO extends DAAPIDataClass
   {
       
      
      public var kill:String = "";
      
      public var damage:String = "";
      
      public var crits:String = "";
      
      public var armor:String = "";
      
      public var assist:String = "";
      
      public var spotted:String = "";
      
      public var assistStun:String = "";
      
      public var killTooltip:String = "";
      
      public var damageTooltip:String = "";
      
      public var critsTooltip:String = "";
      
      public var armorTooltip:String = "";
      
      public var assistTooltip:String = "";
      
      public var spottedTooltip:String = "";
      
      public var stunTooltip:String = "";
      
      public var isStunDataEnabled:Boolean = false;
      
      public var hasEfficencyStats:Boolean = true;
      
      public function EfficiencyHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}

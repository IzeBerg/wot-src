package net.wg.gui.battle.commander.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DAAPISupplyInfoVO extends DAAPIDataClass
   {
       
      
      public var playerName:String = "";
      
      public var supplyID:Number = -1;
      
      public var supplyType:String = "";
      
      public var supplyName:String = "";
      
      public var all:Number = -1;
      
      public var alive:Number = -1;
      
      public var frags:Number = -1;
      
      public function DAAPISupplyInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}

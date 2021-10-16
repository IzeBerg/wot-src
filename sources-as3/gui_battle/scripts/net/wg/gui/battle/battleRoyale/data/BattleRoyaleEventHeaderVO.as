package net.wg.gui.battle.battleRoyale.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyaleEventHeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var subTitle:String = "";
      
      public var description:String = "";
      
      public var battleType:String = "";
      
      public function BattleRoyaleEventHeaderVO(param1:Object = null)
      {
         super(param1);
      }
   }
}

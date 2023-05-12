package net.wg.gui.battle.battleRoyale.views.playerStats
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyalePlayerStatVO extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var description:String = "";
      
      public var imageID:String = "";
      
      public function BattleRoyalePlayerStatVO(param1:Object = null)
      {
         super(param1);
      }
   }
}

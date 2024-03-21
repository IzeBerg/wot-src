package net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleRoyalePlatoonVO extends DAAPIDataClass
   {
       
      
      public var isEnemy:Boolean = false;
      
      public var isDead:Boolean = false;
      
      public var isDefaultData:Boolean = false;
      
      public function BattleRoyalePlatoonVO(param1:Object = null)
      {
         super(param1);
         this.isDefaultData = Boolean(!param1);
      }
      
      public function isEqual(param1:Object) : Boolean
      {
         return param1 && this.isEnemy == param1.isEnemy && this.isDead == param1.isDead && (this.isDefaultData == param1.isDefaultData || param1.isDefaultData == undefined);
      }
   }
}

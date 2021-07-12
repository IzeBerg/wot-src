package net.wg.gui.battle.views.staticMarkers.repairPoint
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   
   public class RepairPointIcon extends BattleIconHolder
   {
       
      
      public var cooldown:MovieClip = null;
      
      public var active:MovieClip = null;
      
      public var enemyCooldown:MovieClip = null;
      
      public var enemyActive:MovieClip = null;
      
      public var enemyCooldownCB:MovieClip = null;
      
      public var enemyActiveCB:MovieClip = null;
      
      public function RepairPointIcon()
      {
         super();
         this.cooldown.visible = false;
         this.active.visible = false;
         this.enemyCooldown.visible = false;
         this.enemyActive.visible = false;
         this.enemyCooldownCB.visible = false;
         this.enemyActiveCB.visible = false;
      }
      
      public function showMarker(param1:Boolean, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc4_:MovieClip = null;
         if(param2)
         {
            _loc4_ = !!param1 ? this.cooldown : this.active;
         }
         else if(param3)
         {
            _loc4_ = !!param1 ? this.enemyCooldownCB : this.enemyActiveCB;
         }
         else
         {
            _loc4_ = !!param1 ? this.enemyCooldown : this.enemyActive;
         }
         showItem(_loc4_);
      }
      
      override protected function onDispose() : void
      {
         this.cooldown = null;
         this.active = null;
         this.enemyCooldown = null;
         this.enemyActive = null;
         this.enemyCooldownCB = null;
         this.enemyActiveCB = null;
         super.onDispose();
      }
   }
}

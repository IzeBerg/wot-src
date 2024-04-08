package net.wg.gui.battle.views.deathCamHud
{
   import net.wg.infrastructure.base.meta.IDeathCamUIMeta;
   import net.wg.infrastructure.base.meta.impl.DeathCamUIMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class DeathCamHud extends DeathCamUIMeta implements IDeathCamUIMeta, IDisplayableComponent
   {
       
      
      public function DeathCamHud()
      {
         super();
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}

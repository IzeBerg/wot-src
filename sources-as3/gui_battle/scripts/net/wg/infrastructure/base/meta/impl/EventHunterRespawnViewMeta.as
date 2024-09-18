package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.eventBattle.views.shared.EventDeploymentMapView;
   
   public class EventHunterRespawnViewMeta extends EventDeploymentMapView
   {
       
      
      public var onRespawnPointClick:Function;
      
      public function EventHunterRespawnViewMeta()
      {
         super();
      }
      
      public function onRespawnPointClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onRespawnPointClick,"onRespawnPointClick" + Errors.CANT_NULL);
         this.onRespawnPointClick(param1);
      }
   }
}

package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class LobbyVehicleMarkerViewMeta extends AbstractView
   {
       
      
      public var onMarkerClick:Function;
      
      public function LobbyVehicleMarkerViewMeta()
      {
         super();
      }
      
      public function onMarkerClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMarkerClick,"onMarkerClick" + Errors.CANT_NULL);
         this.onMarkerClick(param1);
      }
   }
}

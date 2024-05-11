package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehPostProgression.VehPostProgressionViewBase;
   
   public class VehiclePostProgressionCmpViewMeta extends VehPostProgressionViewBase
   {
       
      
      public var onCloseClick:Function;
      
      public function VehiclePostProgressionCmpViewMeta()
      {
         super();
      }
      
      public function onCloseClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseClick,"onCloseClick" + Errors.CANT_NULL);
         this.onCloseClick();
      }
   }
}

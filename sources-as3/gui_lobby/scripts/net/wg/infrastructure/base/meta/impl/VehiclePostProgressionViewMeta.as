package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehPostProgression.VehPostProgressionViewBase;
   
   public class VehiclePostProgressionViewMeta extends VehPostProgressionViewBase
   {
       
      
      public var onGoBackClick:Function;
      
      public var goToVehicleView:Function;
      
      public var compareVehicle:Function;
      
      public var onAboutClick:Function;
      
      public function VehiclePostProgressionViewMeta()
      {
         super();
      }
      
      public function onGoBackClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onGoBackClick,"onGoBackClick" + Errors.CANT_NULL);
         this.onGoBackClick();
      }
      
      public function goToVehicleViewS() : void
      {
         App.utils.asserter.assertNotNull(this.goToVehicleView,"goToVehicleView" + Errors.CANT_NULL);
         this.goToVehicleView();
      }
      
      public function compareVehicleS() : void
      {
         App.utils.asserter.assertNotNull(this.compareVehicle,"compareVehicle" + Errors.CANT_NULL);
         this.compareVehicle();
      }
      
      public function onAboutClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onAboutClick,"onAboutClick" + Errors.CANT_NULL);
         this.onAboutClick();
      }
   }
}

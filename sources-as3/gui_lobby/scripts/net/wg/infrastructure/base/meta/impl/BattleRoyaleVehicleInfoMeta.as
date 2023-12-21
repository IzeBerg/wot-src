package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.VehicleInfoViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleVehicleInfoMeta extends AbstractView
   {
       
      
      public var onClose:Function;
      
      private var _vehicleInfoViewVO:VehicleInfoViewVO;
      
      public function BattleRoyaleVehicleInfoMeta()
      {

package net.wg.gui.battle.battleRoyale.views.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.battleRoyale.data.IVehicleWeakZonesVO;
   
   public class BattleRoyaleWeakZonesBlockVO extends DAAPIDataClass implements IVehicleWeakZonesVO
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var imagePath:String = "";
      
      private var _engineLabel:String = "";
      
      private var _ammunitionLabel:String = "";
      
      public function BattleRoyaleWeakZonesBlockVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get weakZonesSrc() : String
      {
         return this.imagePath;
      }
      
      public function get engineLabel() : String
      {
         return this._engineLabel;
      }
      
      public function set engineLabel(param1:String) : void
      {
         this._engineLabel = param1;
      }
      
      public function get ammunitionLabel() : String
      {
         return this._ammunitionLabel;
      }
      
      public function set ammunitionLabel(param1:String) : void
      {
         this._ammunitionLabel = param1;
      }
   }
}

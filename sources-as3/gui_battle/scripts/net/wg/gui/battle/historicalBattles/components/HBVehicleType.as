package net.wg.gui.battle.historicalBattles.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HBVehicleType extends BattleUIComponent
   {
      
      private static const PATH:String = "img://historical_battles/gui/maps/icons/vehicleTypes/flat/";
      
      private static const SIZE:String = "/16x16/";
      
      private static const PNG:String = ".png";
      
      public static const GREEN:String = "green";
      
      public static const ORANGE:String = "orange";
       
      
      public var icon:IImage = null;
      
      private var _vehicleType:String = "";
      
      private var _color:String = "green";
      
      public function HBVehicleType()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._color) && StringUtils.isNotEmpty(this._vehicleType) && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = PATH + this._color + SIZE + this._vehicleType + PNG;
         }
      }
      
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
      
      public function set vehicleType(param1:String) : void
      {
         if(this._vehicleType == param1)
         {
            return;
         }
         this._vehicleType = param1;
         invalidateData();
      }
      
      public function get color() : String
      {
         return this._color;
      }
      
      public function set color(param1:String) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         invalidateData();
      }
   }
}

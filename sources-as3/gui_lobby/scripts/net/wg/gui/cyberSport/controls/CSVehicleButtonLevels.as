package net.wg.gui.cyberSport.controls
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CSVehicleButtonLevels extends UIComponentEx
   {
      
      private static const UPDATE_LEVELS:String = "updateLevels";
       
      
      public var vehicleLevelEff:MovieClip;
      
      public var vehicleLevel:MovieClip;
      
      private var _level:uint = 0;
      
      public function CSVehicleButtonLevels()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._level != 0 && isInvalid(UPDATE_LEVELS))
         {
            this.vehicleLevel.gotoAndStop(this._level);
            this.vehicleLevelEff.gotoAndStop(this._level);
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleLevelEff = null;
         this.vehicleLevel = null;
         super.onDispose();
      }
      
      public function setData(param1:uint) : void
      {
         this._level = param1;
         invalidate(UPDATE_LEVELS);
      }
      
      public function setState(param1:String) : void
      {
         gotoAndPlay(param1);
      }
   }
}

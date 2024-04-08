package net.wg.gui.battle.views.postmortemPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehiclePanel extends Sprite implements IDisposable
   {
      
      private static const HORIZONTAL_MARGIN:int = 12;
      
      private static const ELEMENTS_GAP:int = 7;
      
      protected static const VEHICLE_IMAGE_HEIGHT:int = 22;
       
      
      public var bgMC:BattleAtlasSprite = null;
      
      public var levelTF:TextField = null;
      
      public var typeMC:UILoaderAlt = null;
      
      public var nameTF:TextField = null;
      
      protected var vehicleMC:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function VehiclePanel()
      {
         super();
         this.bgMC.imageName = BATTLEATLAS.POSTMORTEM_VEHICLE_PANEL_BG;
         this.levelTF.autoSize = TextFieldAutoSize.LEFT;
         this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleMC = new Image();
         addChild(this.vehicleMC);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.bgMC = null;
         this.levelTF = null;
         this.nameTF = null;
         this.typeMC.dispose();
         this.typeMC = null;
         this.vehicleMC.removeEventListener(Event.CHANGE,this.onVehicleMCChangeHandler);
         this.vehicleMC.dispose();
         this.vehicleMC = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setVehicleData(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.typeMC.source = param2;
         this.nameTF.text = param3;
         this.levelTF.text = param1;
         if(param4 == Values.EMPTY_STR)
         {
            this.vehicleMC.clearImage();
            this.adjustPositions();
         }
         else
         {
            this.vehicleMC.source = param4;
            this.vehicleMC.addEventListener(Event.CHANGE,this.onVehicleMCChangeHandler);
         }
      }
      
      protected function adjustPositions() : void
      {
         this.levelTF.x = HORIZONTAL_MARGIN;
         this.vehicleMC.y = this.height - VEHICLE_IMAGE_HEIGHT >> 1;
         this.vehicleMC.x = this.levelTF.x + this.levelTF.width;
         this.typeMC.x = this.vehicleMC.x + this.vehicleMC.width * this.vehicleMC.scaleX - ELEMENTS_GAP;
         this.nameTF.x = this.typeMC.x + this.typeMC.originalWidth + ELEMENTS_GAP;
         this.bgMC.width = this.nameTF.x + this.nameTF.width + HORIZONTAL_MARGIN;
         this.x = -this.width >> 1;
      }
      
      private function onVehicleMCChangeHandler(param1:Event) : void
      {
         this.vehicleMC.height = VEHICLE_IMAGE_HEIGHT;
         this.vehicleMC.scaleX = this.vehicleMC.scaleY;
         this.adjustPositions();
      }
   }
}

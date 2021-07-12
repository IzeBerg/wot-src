package net.wg.gui.battle.views.calloutPanel.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   import scaleform.gfx.TextFieldEx;
   
   public class VehicleInfoLabel extends MovieClip implements IDisposable
   {
      
      private static const VEHICLE_TYPE_NAME_OFFSET:int = 21;
       
      
      public var vehNameTF:TextField = null;
      
      public var vehTypeImg:MovieClip = null;
      
      private var _atlasMgr:IAtlasManager = null;
      
      public function VehicleInfoLabel()
      {
         super();
         this._atlasMgr = App.atlasMgr;
         this.vehNameTF.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setNoTranslate(this.vehNameTF,true);
      }
      
      public final function dispose() : void
      {
         this._atlasMgr = null;
         this.vehNameTF = null;
         this.vehTypeImg = null;
      }
      
      public function updatePositionOnDraw() : void
      {
         var _loc1_:int = 0;
         _loc1_ = -(VEHICLE_TYPE_NAME_OFFSET + this.vehNameTF.textWidth >> 1);
         this.vehTypeImg.x = _loc1_;
         this.vehNameTF.x = _loc1_ + (VEHICLE_TYPE_NAME_OFFSET - this.vehTypeImg.width);
      }
      
      public function setVehicleData(param1:String, param2:String) : void
      {
         this.vehNameTF.text = param2;
         if(param1 != Values.EMPTY_STR)
         {
            this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.vehTypeImg.graphics,Values.EMPTY_STR,false,false,true);
         }
      }
   }
}

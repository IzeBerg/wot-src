package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class NationTreeVehicleCollectionBtn extends SoundButtonEx
   {
      
      private static const SMALL_BTN_HEIGHT:int = 24;
      
      private static const BIG_BTN_HEIGHT:int = 30;
       
      
      public var bgSmallMc:Sprite = null;
      
      public var bgBigMc:Sprite = null;
      
      private var _nation:String = "";
      
      private var _isSmall:Boolean = true;
      
      public function NationTreeVehicleCollectionBtn()
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
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.bgSmallMc = null;
         this.bgBigMc = null;
         super.onDispose();
      }
      
      private function updateLayout() : void
      {
         this.bgSmallMc.visible = this._isSmall;
         this.bgBigMc.visible = !this._isSmall;
         hitMc.height = this.currentHeight;
      }
      
      public function get currentHeight() : int
      {
         return !!this._isSmall ? int(SMALL_BTN_HEIGHT) : int(BIG_BTN_HEIGHT);
      }
      
      public function set isSmallLayout(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateSize();
         }
      }
      
      public function set nation(param1:String) : void
      {
         this._nation = param1;
      }
      
      public function get nation() : String
      {
         return this._nation;
      }
      
      override protected function showTooltip() : void
      {
         if(App.toolTipMgr != null && StringUtils.isNotEmpty(this._nation))
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_COLLECTOR_INFO,null,this._nation);
         }
      }
   }
}

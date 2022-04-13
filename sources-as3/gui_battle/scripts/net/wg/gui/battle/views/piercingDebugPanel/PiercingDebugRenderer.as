package net.wg.gui.battle.views.piercingDebugPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.views.piercingDebugPanel.data.PiercingItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class PiercingDebugRenderer extends ListItemRenderer
   {
       
      
      public var vehiclePartTF:TextField = null;
      
      public var baseArmorTF:TextField = null;
      
      public var angleTF:TextField = null;
      
      public var penetrationArmorTF:TextField = null;
      
      public var piercingPowerLeftTF:TextField = null;
      
      public var piercingPercentTF:TextField = null;
      
      public var resultBG:MovieClip = null;
      
      private var _rendererData:PiercingItemVO = null;
      
      public function PiercingDebugRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this._rendererData = param1 != null ? PiercingItemVO(param1) : null;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         visible = false;
         super.configUI();
      }
      
      override protected function draw() : void
      {
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.vehiclePartTF.htmlText = this._rendererData.vehiclePart;
            this.baseArmorTF.htmlText = this._rendererData.armor;
            this.angleTF.htmlText = this._rendererData.angle;
            this.penetrationArmorTF.htmlText = this._rendererData.penetrationArmor;
            this.piercingPowerLeftTF.htmlText = this._rendererData.piercingPowerLeft;
            this.piercingPercentTF.htmlText = this._rendererData.piercingPercent;
            this.resultBG.gotoAndStop(this._rendererData.result);
            visible = true;
         }
         if(this._rendererData == null)
         {
            visible = false;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.vehiclePartTF = null;
         this.baseArmorTF = null;
         this.angleTF = null;
         this.penetrationArmorTF = null;
         this.piercingPowerLeftTF = null;
         this.piercingPercentTF = null;
         this.resultBG = null;
         this._rendererData = null;
         super.onDispose();
      }
   }
}

package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SuitableVehicleBlockItem extends UIComponentEx
   {
       
      
      public var vehicleName:TextField = null;
      
      public var levelMc:MovieClip = null;
      
      public var vehicleType:UILoaderAlt = null;
      
      public var nationIco:UILoaderAlt = null;
      
      public var vehicleIco:UILoaderAlt = null;
      
      private var _vName:String = null;
      
      private var _lNum:Number = NaN;
      
      private var _vType:String = null;
      
      private var _nIco:String = null;
      
      private var _vIco:String = null;
      
      private var _dataDirty:Boolean = false;
      
      public function SuitableVehicleBlockItem()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataDirty && isInvalid(InvalidationType.DATA))
         {
            this.levelMc.gotoAndStop(this._lNum);
            this.vehicleType.source = this._vType;
            this.nationIco.source = this._nIco;
            this.vehicleIco.source = this._vIco;
            this.vehicleName.htmlText = this._vName;
            this.vehicleName.width = this.vehicleName.textWidth + 3;
            this._dataDirty = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.nationIco.dispose();
         this.nationIco = null;
         this.vehicleIco.dispose();
         this.vehicleIco = null;
         this.vehicleName = null;
         this.levelMc = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:uint, param3:String, param4:String, param5:String) : void
      {
         this._nIco = param1;
         this._lNum = param2;
         this._vIco = param3;
         this._vType = param4;
         this._vName = param5;
         this._dataDirty = true;
         invalidateData();
      }
   }
}

package net.wg.gui.components.crosshairPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.components.crosshairPanel.components.wt.PlasmaIndicator;
   
   public class WTCrosshairBase extends CrosshairWithCassette
   {
      
      private static const PLASMA_DAMAGE_INDICATOR_X_OFFSET:Number = -10;
       
      
      public var plasmaIndicator:PlasmaIndicator = null;
      
      public var wtExplosiveShot:MovieClip = null;
      
      private var _plasmaDamageIndicatorYPos:Array = null;
      
      private var _plasmaDamageIndicatorScale:Array = null;
      
      public function WTCrosshairBase()
      {
         super();
         this._plasmaDamageIndicatorYPos = this.getPlasmaDamageIndicatorYPos();
         this._plasmaDamageIndicatorScale = this.getPlasmaDamageIndicatorScale();
         this.updatePlasmaIndicatorSize(this.netType);
         this.setExplosiveShotVisible(false);
      }
      
      override public function setNetType(param1:Number) : void
      {
         super.setNetType(param1);
         if(this.netType != param1)
         {
            this.updatePlasmaIndicatorSize(this.netType);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._plasmaDamageIndicatorYPos)
         {
            this._plasmaDamageIndicatorYPos.length = 0;
            this._plasmaDamageIndicatorYPos = null;
         }
         if(this._plasmaDamageIndicatorScale)
         {
            this._plasmaDamageIndicatorScale.length = 0;
            this._plasmaDamageIndicatorScale = null;
         }
         if(this.plasmaIndicator)
         {
            this.plasmaIndicator = null;
         }
         super.onDispose();
      }
      
      public function setExplosiveShotVisible(param1:Boolean) : void
      {
         if(this.wtExplosiveShot)
         {
            this.wtExplosiveShot.visible = param1;
         }
      }
      
      public function showPlasmaIndicator(param1:Number, param2:Boolean, param3:String) : void
      {
         if(this.plasmaIndicator)
         {
            this.plasmaIndicator.showPlasma(param1,param2,param3);
         }
      }
      
      protected function updatePlasmaIndicatorSize(param1:Number) : void
      {
         var plasmaIndicatorScale:Number = NaN;
         var plasmaIndicatorXPos:Number = NaN;
         var plasmaIndicatorYPos:Number = NaN;
         var netType:Number = param1;
         if(!this.plasmaIndicator)
         {
            return;
         }
         try
         {
            plasmaIndicatorScale = this._plasmaDamageIndicatorScale[netType];
            this.plasmaIndicator.setPlasmaDamageIndicatorScale(plasmaIndicatorScale);
         }
         catch(error:Error)
         {
         }
         try
         {
            plasmaIndicatorXPos = (this.plasmaIndicator.plasmaDamageIndicator.width >> 1) * -1 + PLASMA_DAMAGE_INDICATOR_X_OFFSET;
            plasmaIndicatorYPos = this._plasmaDamageIndicatorYPos[netType];
            this.plasmaIndicator.setPlasmaDamageIndicatorPosition(plasmaIndicatorXPos,plasmaIndicatorYPos);
         }
         catch(error:Error)
         {
         }
      }
      
      protected function getPlasmaDamageIndicatorYPos() : Array
      {
         return [];
      }
      
      protected function getPlasmaDamageIndicatorScale() : Array
      {
         return [];
      }
   }
}

package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class AutoloaderIndicator extends SimpleContainer
   {
      
      private static const TOTAL_AMMO:String = "TOTAL_AMMO_INVALID";
      
      private static const CURRENT_AMMO:String = "QUANTITY_IN_CLIP_INVALID";
      
      private static const SHOOT_STATE:int = 2;
      
      private static const SHELL_RELOAD_INDICATOR_OFFSETS_X:Vector.<int> = Vector.<int>([0,15,5,-9,-20,0,0,0]);
      
      private static const SHELL_RELOAD_INDICATOR_OFFSETS_Y:Vector.<int> = Vector.<int>([0,1,8,15,25,0,0,0]);
       
      
      public var cassette:AutoloaderShellsCassette = null;
      
      public var boostndicator:BoostIndicator = null;
      
      public var fireMc:MovieClip = null;
      
      private var _totalAmmo:int = -1;
      
      private var _currentAmmo:int = -1;
      
      public function AutoloaderIndicator()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         super.draw();
         if(isInvalid(TOTAL_AMMO))
         {
            this.cassette.totalAmmo = this._totalAmmo;
            if(this._totalAmmo > -1)
            {
               _loc1_ = this._totalAmmo - 1;
               if(_loc1_ > SHELL_RELOAD_INDICATOR_OFFSETS_X.length - 1)
               {
                  _loc1_ = SHELL_RELOAD_INDICATOR_OFFSETS_X.length - 1;
               }
               this.boostndicator.x = this.cassette.x + SHELL_RELOAD_INDICATOR_OFFSETS_X[_loc1_];
               this.boostndicator.y = this.cassette.y - SHELL_RELOAD_INDICATOR_OFFSETS_Y[_loc1_];
            }
         }
         if(isInvalid(CURRENT_AMMO))
         {
            this.cassette.currentAmmo = this._currentAmmo;
         }
      }
      
      override protected function onDispose() : void
      {
         this.cassette.dispose();
         this.cassette = null;
         this.boostndicator.dispose();
         this.boostndicator = null;
         this.fireMc = null;
         super.onDispose();
      }
      
      public function autoloaderShowShot() : void
      {
         this.fireMc.gotoAndPlay(SHOOT_STATE);
      }
      
      public function autoloaderUpdate(param1:Number, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         this.cassette.autoloadProgress(param1,param2,param3,param4);
      }
      
      public function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void
      {
         this.boostndicator.autoloaderBoostUpdate(param1,param2,param3);
      }
      
      public function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void
      {
         this.boostndicator.autoloaderBoostUpdateAsPercent(param1,param2);
      }
      
      public function get autoloaderBoostParams() : BoostIndicatorStateParamsVO
      {
         return this.boostndicator.stateParams;
      }
      
      public function setGunReloadingPercent(param1:Number) : void
      {
         this.cassette.reloadingPercent(param1);
      }
      
      public function updateCritical(param1:Boolean) : void
      {
         this.cassette.updateCritical(param1);
      }
      
      public function updateCurrentAmmo(param1:int) : void
      {
         if(this._currentAmmo != param1)
         {
            this._currentAmmo = param1;
            invalidate(CURRENT_AMMO);
         }
      }
      
      public function updateQuantityInClip(param1:int, param2:int) : void
      {
         this.updateCurrentAmmo(param1);
         this.updateTotalAmmo(param2);
      }
      
      public function updateTotalAmmo(param1:int) : void
      {
         if(this._totalAmmo != param1)
         {
            this._totalAmmo = param1;
            invalidate(TOTAL_AMMO);
         }
      }
   }
}

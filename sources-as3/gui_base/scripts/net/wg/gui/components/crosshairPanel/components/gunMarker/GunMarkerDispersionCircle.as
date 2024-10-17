package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import com.gskinner.motion.GTweener;
   import mx.effects.easing.Cubic;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerDispersionCircle extends SimpleContainer
   {
      
      public static const BOLD:String = "bold";
      
      public static const THIN:String = "thin";
      
      private static const SECONDARY_ALPHA_MULTIPLAYER:Number = 0.2;
      
      private static const TWEEN_DURATION:Number = 1;
       
      
      public var currMixingMC:IGunMarkerMixing = null;
      
      public var mixingType0:GunMarkerMixing = null;
      
      public var mixingType1:GunMarkerMixingWithoutProgress = null;
      
      public var mixingType2:GunMarkerMixingWithoutProgress = null;
      
      public var mixingType3:GunMarkerMixingSolid = null;
      
      public var mixingType4:GunMarkerMixingWithoutProgress = null;
      
      public var mixingType5:GunMarkerMixingWithoutProgress = null;
      
      public var invalidateCrosshair:Function = null;
      
      private var _type:Number = -1;
      
      private var _alpha:Number = 1;
      
      private var _reloadingInPercent:Number = -1;
      
      private var _reloadingState:String = "";
      
      private var _isSecondary:Boolean = false;
      
      private var _mixings:Object = null;
      
      public function GunMarkerDispersionCircle()
      {
         super();
         this._mixings = {
            "type0":this.mixingType0,
            "type1":this.mixingType1,
            "type2":this.mixingType2,
            "type3":this.mixingType3,
            "type4":this.mixingType4,
            "type5":this.mixingType5,
            "type6":this.mixingType5,
            "type7":this.mixingType5
         };
         this.mixingType0.visible = this.mixingType1.visible = this.mixingType2.visible = this.mixingType3.visible = this.mixingType4.visible = this.mixingType5.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(GunMarkerConsts.GUN_MIXING_TYPE_VALIDATION))
         {
            if(this.currMixingMC)
            {
               this.currMixingMC.visible = false;
            }
            this.currMixingMC = this._mixings[GunMarkerConsts.GUN_MIXING_PREFIX + this._type];
            if(this.currMixingMC)
            {
               if(this.invalidateCrosshair != null)
               {
                  this.invalidateCrosshair();
               }
               this.currMixingMC.visible = true;
            }
            invalidate(GunMarkerConsts.GUN_RELOAD_VALIDATION);
         }
         if(isInvalid(GunMarkerConsts.GUN_ALPHA_VALIDATION))
         {
            if(this._isSecondary)
            {
               GTweener.removeTweens(this.currMixingMC);
               GTweener.to(this.currMixingMC,TWEEN_DURATION,{"alpha":this.mixingAlpha * SECONDARY_ALPHA_MULTIPLAYER},{
                  "onComplete":this.onFadeComplete,
                  "ease":Cubic.easeOut
               });
            }
            else
            {
               this.updateAlpha();
            }
         }
         if(isInvalid(GunMarkerConsts.GUN_RELOAD_VALIDATION))
         {
            if(this._reloadingInPercent != -1)
            {
               if(this.currMixingMC)
               {
                  this.currMixingMC.setReloadingAsPercent(this._reloadingInPercent);
                  this.currMixingMC.setReloadingState(this._reloadingState);
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         GTweener.removeTweens(this.currMixingMC);
         this.currMixingMC = null;
         this.invalidateCrosshair = null;
         this.mixingType0.dispose();
         this.mixingType0 = null;
         this.mixingType1.dispose();
         this.mixingType1 = null;
         this.mixingType2.dispose();
         this.mixingType2 = null;
         this.mixingType3.dispose();
         this.mixingType3 = null;
         this.mixingType4.dispose();
         this.mixingType4 = null;
         this.mixingType5.dispose();
         this.mixingType5 = null;
         this._mixings = this.cleanupObject(this._mixings);
         super.onDispose();
      }
      
      public function setAlpha(param1:Number, param2:Boolean) : void
      {
         this._isSecondary = param2;
         this._alpha = param1;
         if(this.currMixingMC)
         {
            this.currMixingMC.alpha = this.mixingAlpha;
         }
         invalidate(GunMarkerConsts.GUN_ALPHA_VALIDATION);
      }
      
      public function setReloadingParams(param1:Number, param2:String) : void
      {
         var _loc3_:uint = 0;
         if(this._reloadingState != param2)
         {
            this._reloadingState = param2;
            _loc3_ |= 1;
         }
         if(this._reloadingInPercent != param1)
         {
            this._reloadingInPercent = param1;
            _loc3_ |= 1;
         }
         if(_loc3_ > 0)
         {
            invalidate(GunMarkerConsts.GUN_RELOAD_VALIDATION);
         }
      }
      
      public function setThickness(param1:String) : void
      {
         this.mixingType0.setThickness(param1);
         this.mixingType1.setThickness(param1);
         this.mixingType2.setThickness(param1);
         this.mixingType3.setThickness(param1);
      }
      
      public function setType(param1:Number) : void
      {
         if(this._type != param1)
         {
            this._type = param1;
            invalidate(GunMarkerConsts.GUN_MIXING_TYPE_VALIDATION);
         }
      }
      
      protected function get mixingAlpha() : Number
      {
         return this._alpha;
      }
      
      private function updateAlpha() : void
      {
         var _loc2_:SimpleContainer = null;
         var _loc1_:Number = !!this._isSecondary ? Number(this.mixingAlpha * SECONDARY_ALPHA_MULTIPLAYER) : Number(this.mixingAlpha);
         for each(_loc2_ in this._mixings)
         {
            _loc2_.alpha = _loc1_;
         }
      }
      
      private function onFadeComplete() : void
      {
         this.updateAlpha();
      }
      
      private function cleanupObject(param1:Object) : Object
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         for each(_loc3_ in _loc2_)
         {
            delete param1[_loc3_];
         }
         _loc2_.splice(0,_loc2_.length);
         return null;
      }
   }
}

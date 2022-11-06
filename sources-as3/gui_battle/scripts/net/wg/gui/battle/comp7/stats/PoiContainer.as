package net.wg.gui.battle.comp7.stats
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.poi.components.PoiProgressCircleWrapper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class PoiContainer extends BattleUIComponent
   {
      
      private static const INTEREST_POINT_GAP_X:int = -35;
      
      private static const INTEREST_POINT_SIZE:uint = 60;
      
      private static const POI_X_ANIM_DURATION:uint = 300;
       
      
      private var _pois:Vector.<PoiProgressCircleWrapper>;
      
      private var _poisDict:Dictionary;
      
      private var _poisXTween:Vector.<Tween>;
      
      public function PoiContainer()
      {
         this._pois = new Vector.<PoiProgressCircleWrapper>();
         this._poisDict = new Dictionary();
         this._poisXTween = new Vector.<Tween>();
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._pois)
         {
            _loc1_.dispose();
         }
         this._pois.splice(0,this._pois.length);
         this._pois = null;
         App.utils.data.cleanupDynamicObject(this._poisDict);
         this._poisDict = null;
         this.cleanPoisXTween();
         this._poisXTween = null;
         super.onDispose();
      }
      
      public function removeAllPOI() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this._poisDict)
         {
            this.removePoi(_loc1_,false);
         }
      }
      
      public function removePointOfInterest(param1:uint) : void
      {
         var _loc2_:PoiProgressCircleWrapper = this._poisDict[param1];
         if(_loc2_)
         {
            _loc2_.hide(this.onPoiHideComplete);
            this.updatePositions();
         }
      }
      
      public function updatePointOfInterest(param1:uint, param2:Number, param3:Boolean = true) : void
      {
         var _loc5_:PoiProgressCircleWrapper = null;
         var _loc4_:PoiProgressCircleWrapper = this._poisDict[param1];
         if(_loc4_)
         {
            _loc4_.updateProgress(param2);
         }
         else
         {
            _loc5_ = new PoiProgressCircleWrapper(Linkages.PLAYERS_PANEL_POI_PROGRESS_BAR_UI,INTEREST_POINT_SIZE,INTEREST_POINT_SIZE);
            _loc5_.iconType = param1;
            _loc5_.alpha = 0;
            addChild(_loc5_);
            this._pois.push(_loc5_);
            this._poisDict[param1] = _loc5_;
            _loc5_.updateProgress(param2);
            _loc5_.show(this.onPoiShowComplete,param3);
            this.updatePositions();
         }
      }
      
      private function updatePositions(param1:Boolean = false) : void
      {
         var _loc3_:PoiProgressCircleWrapper = null;
         this.cleanPoisXTween();
         var _loc2_:int = 0;
         for each(_loc3_ in this._pois)
         {
            if(param1)
            {
               this._poisXTween.push(new Tween(POI_X_ANIM_DURATION,_loc3_,{"x":_loc2_}));
            }
            else
            {
               _loc3_.x = _loc2_;
            }
            _loc2_ += _loc3_.width + INTEREST_POINT_GAP_X | 0;
         }
      }
      
      private function cleanPoisXTween() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._poisXTween)
         {
            _loc1_.dispose();
         }
         this._poisXTween.length = 0;
      }
      
      private function onPoiShowComplete(param1:uint) : void
      {
         this.updatePositions();
      }
      
      private function onPoiHideComplete(param1:uint) : void
      {
         this.removePoi(param1);
      }
      
      private function removePoi(param1:uint, param2:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PoiProgressCircleWrapper = this._poisDict[param1];
         if(_loc3_)
         {
            delete this._poisDict[param1];
            _loc4_ = this._pois.indexOf(_loc3_);
            if(_loc4_ != -1)
            {
               this._pois.splice(_loc4_,1);
            }
            removeChild(_loc3_);
            _loc3_.dispose();
            this.updatePositions(param2);
         }
      }
   }
}
